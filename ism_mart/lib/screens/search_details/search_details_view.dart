import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ism_mart/exports/export_controllers.dart';
import 'package:ism_mart/helper/no_internet_view.dart';
import 'package:ism_mart/exports/exports_model.dart';
import 'package:ism_mart/exports/export_presentation.dart';
import 'package:ism_mart/exports/exports_utils.dart';
import 'package:ism_mart/helper/languages/translations_key.dart' as langKey;
import 'package:ism_mart/widgets/custom_appbar.dart';

class SearchDetailsView extends GetView<CustomSearchController> {
  const SearchDetailsView(
      {Key? key,
      this.searchQuery = "",
      this.productTypeKey = "",
      this.subCategoryID = 0,
      this.categoryID = 0,
      this.isCalledForLatestAndBestSeller = false,
      this.calledFromCategories,
      this.calledToGoBackOnce})
      : super(key: key);

  final bool? isCalledForLatestAndBestSeller,
      calledFromCategories,
      calledToGoBackOnce;
  final String? searchQuery, productTypeKey;
  final int? categoryID, subCategoryID;

  @override
  Widget build(BuildContext context) {
    //----- used for calling from----------//
    // 1. all products (dashboard)
    // 2. Deals
    //3. on SearchBar (dashboard)
    // print("SearchView: $isCalledForDeals--$searchQuery---$productTypeKey");
    // controller.isLoading.value = true;
    if (searchQuery != null && searchQuery != '') {
      controller.addFilters("text", searchQuery);
    }
    if (productTypeKey != null && productTypeKey != '') {
      print('Type: $productTypeKey');
      if (productTypeKey == 'All Products') {
        null;
      } else {
        controller.addFilters(
            "type", baseController.getProductTypeKeys(productTypeKey));
      }
    }
    if (categoryID != null && categoryID != 0) {
      controller.addFilters("category", categoryID);
    }
    if (subCategoryID != null && subCategoryID != 0) {
      controller.addFilters("subCategory", subCategoryID);
    }
    if (controller.filters.isEmpty) {
      controller.handleFilters(controller.filters);
    }

    return WillPopScope(
      onWillPop: () {
        Future.delayed(
          Duration(seconds: 2),
          () => Get.back(),
        );

        return controller.clearFilters();
      },
      child: SafeArea(
        child: Scaffold(
            backgroundColor: Colors.grey[100]!,
            appBar: _appBar(),
            body: Obx(
              () => controller.noProductsFound.value
                  ? NoInternetView()
                  // Center(
                  //     child: NoDataFoundWithIcon(
                  //       title: langKey.emptyProductSearch.tr,
                  //       subTitle: langKey.emptyProductSearchMsg.tr,
                  //     ),
                  //   )
                  : Stack(
                      children: [
                        _body(),
                        NoInternetView(
                          onPressed: () => controller.applyFilter(),
                        )
                      ],
                    ),
            )),
      ),
    );
  }

  CustomAppBar _appBar() {
    return CustomAppBar(
      leading: InkWell(
        onTap: () {
          if (calledToGoBackOnce == true) {
            Get.back();
          } else {
            int count = 0;
            Get.offNamedUntil(Routes.searchRoute, (route) => count++ >= 2);
            controller.clearFilters();
            controller.productList.clear();
          }
        },
        child: Icon(
          Icons.arrow_back_ios_new,
          size: 18,
          color: kPrimaryColor,
        ),
      ),
      searchBar: CustomSearchBar(
        searchText: searchQuery,
        calledFromSearchDetailsView: calledToGoBackOnce != null ? false : true,
      ),
    );
  }

  _body() {
    return Obx(() => controller.isLoading.isTrue
        ? CustomLoading(isItForWidget: true, color: kPrimaryColor)
        : controller.productList.isEmpty
            ? NoInternetView(
                onPressed: () => controller.applyFilter(),
              )
            //  Center(
            //     child: NoDataFoundWithIcon(
            //       title: langKey.emptyProductSearch.tr,
            //       subTitle: langKey.emptyProductSearchMsg.tr,
            //     ),
            //   )
            : _buildProductView(controller.productList));
  }

  Column _buildProductView(List<ProductModel> list) {
    return Column(
      children: [
        ///Filter bar
        ///Material is used for elevation like appbar
        Material(
          elevation: 1,
          child: Container(
            height: AppConstant.getSize().height * 0.05,
            color: kWhiteColor,
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: CustomText(
                    title: "${list.length} ${langKey.itemsFound.tr}",
                    weight: FontWeight.w600,
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      if (isCalledForLatestAndBestSeller == false)
                        TextButton.icon(
                          onPressed: () => showSortBottomSheet(),
                          icon: Icon(
                            Icons.sort_rounded,
                            color: kPrimaryColor,
                          ),
                          label: CustomText(
                            title: langKey.sortBy.tr,
                            color: kPrimaryColor,
                            weight: FontWeight.bold,
                          ),
                        ),
                      TextButton.icon(
                        onPressed: () {
                          controller.setCategories(baseController.categories);
                          showFilterBottomSheet();
                        },
                        icon: Icon(
                          Icons.filter_alt_rounded,
                          color: kPrimaryColor,
                        ),
                        label: CustomText(
                          title: langKey.filter.tr,
                          color: kPrimaryColor,
                          weight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Column(
            children: [
              Expanded(
                child: GridView.builder(
                  padding: EdgeInsets.all(8),
                  controller: controller.scrollController,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: AppResponsiveness.getGridItemCount(),
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio:
                          AppResponsiveness.getChildAspectRatioPoint90()
                      // mainAxisExtent:
                      //     AppResponsiveness.getMainAxisExtentPoint25(),
                      ),
                  itemCount: list.length,
                  itemBuilder: (_, index) {
                    ProductModel productModel = list[index];
                    return SingleProductItems(productModel: productModel);
                  },
                ),
              ),
              if (controller.isLoadingMore.isTrue)
                CustomLoading(
                  isItForWidget: true,
                  color: kPrimaryColor,
                )
            ],
          ),
        ),
      ],
    );
  }

  void showFilterBottomSheet() {
    AppConstant.showBottomSheet(
      widget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 8, top: 10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: CustomText(
                        title: langKey.filter.tr,
                        weight: FontWeight.bold,
                        size: 16,
                      ),
                    ),
                    IconButton(
                      visualDensity: VisualDensity.compact,
                      onPressed: () {
                        Get.back();
                      },
                      icon: Icon(Icons.close),
                    ),
                  ],
                ),
                Divider(),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 13),
            child: CustomText(
              title: langKey.categories.tr,
              weight: FontWeight.bold,
              size: 14,
            ),
          ),
          Obx(
            () => Container(
              height: 70,
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 8),
                scrollDirection: Axis.horizontal,
                itemCount: controller.categoriesList.length,
                itemBuilder: (_, index) {
                  CategoryModel categoryModel =
                      controller.categoriesList[index];
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 13),
                    child: InkWell(
                      onTap: () {
                        controller.selectedCategoryId(categoryModel.id!);
                        controller.setSelectedCategory(categoryModel);
                      },
                      borderRadius: BorderRadius.circular(5),
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: categoryModel.isPressed!
                              ? kPrimaryColor
                              : kTransparent,
                          border: categoryModel.isPressed!
                              ? Border()
                              : Border.all(),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: CustomText(
                          title: categoryModel.name ?? '',
                          color: categoryModel.isPressed!
                              ? kWhiteColor
                              : kDarkColor,
                          weight: FontWeight.w600,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 13, top: 10),
            child: CustomText(
              title: langKey.price.tr,
              weight: FontWeight.bold,
              size: 14,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Expanded(
                  child: FormInputFieldWithIcon(
                    controller: controller.minPriceController,
                    iconPrefix: Icons.attach_money_rounded,
                    labelText: langKey.minPrice.tr,
                    iconColor: kPrimaryColor,
                    enableBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: kPrimaryColor,
                        width: 1.5,
                      ),
                    ),
                    autofocus: false,
                    textStyle: bodyText1,
                    keyboardType: TextInputType.number,
                    onChanged: (value) {},
                    onSaved: (value) {},
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: FormInputFieldWithIcon(
                    controller: controller.maxPriceController,
                    iconPrefix: Icons.attach_money_rounded,
                    labelText: langKey.maxPrice.tr,
                    iconColor: kPrimaryColor,
                    autofocus: false,
                    enableBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: kPrimaryColor,
                        width: 1.5,
                      ),
                    ),
                    textStyle: bodyText1,
                    keyboardType: TextInputType.number,
                    onChanged: (value) {},
                    onSaved: (value) {},
                  ),
                ),
              ],
            ),
          ),
          _filtersBtn(),
        ],
      ),
    );
  }

  Padding _filtersBtn() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: CustomTextBtn(
              onPressed: () => controller.clearFilters(),
              title: langKey.clear.tr,
              height: 36,
            ),
          ),
          SizedBox(width: 20),
          Expanded(
            child: CustomTextBtn(
              onPressed: () {
                controller.applyFilter();
                Get.back();
                controller.minPriceController.clear();
                controller.maxPriceController.clear();
              },
              title: langKey.search.tr,
              height: 36,
            ),
          ),
        ],
      ),
    );
  }

  void showSortBottomSheet() {
    AppConstant.showBottomSheet(
      widget: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 8, top: 10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: CustomText(
                        title: langKey.sortByPrice.tr,
                        weight: FontWeight.bold,
                        size: 16,
                      ),
                    ),
                    IconButton(
                      visualDensity: VisualDensity.compact,
                      onPressed: () {
                        Get.back();
                      },
                      icon: Icon(Icons.close),
                    ),
                  ],
                ),
                Divider(),
              ],
            ),
          ),
          RadioListTile(
            visualDensity: const VisualDensity(
              horizontal: VisualDensity.minimumDensity,
            ),
            activeColor: kPrimaryColor,
            toggleable: true,
            title: CustomText(
              title: langKey.lowToHigh.tr,
              size: 14,
            ),
            value: 'low-to-high',
            onChanged: (String? value) {
              controller.setSortBy(value!);
              Get.back();
            },
            groupValue: controller.sortBy,
          ),
          RadioListTile(
            visualDensity: const VisualDensity(
              horizontal: VisualDensity.minimumDensity,
            ),
            activeColor: kPrimaryColor,
            toggleable: true,
            title: CustomText(
              title: langKey.highToLow.tr,
              size: 14,
            ),
            value: 'high-to-low',
            onChanged: (String? value) {
              controller.setSortBy(value!);
              Get.back();
            },
            groupValue: controller.sortBy,
          ),
        ],
      ),
    );
  }
}
