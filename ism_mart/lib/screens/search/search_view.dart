import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ism_mart/controllers/export_controllers.dart';
import 'package:ism_mart/models/exports_model.dart';
import 'package:ism_mart/exports/export_presentation.dart';
import 'package:ism_mart/utils/exports_utils.dart';
import 'package:ism_mart/utils/languages/translations_key.dart' as langKey;

class SearchView extends GetView<CustomSearchController> {
  const SearchView({
    Key? key,
    this.passedSearchQuery,
    this.isCalledForDeals = false,
  }) : super(key: key);
  final bool? isCalledForDeals;
  final String? passedSearchQuery;
  @override
  Widget build(BuildContext context) {
    //  final controller = Get.find<SearchController>();
    String? searchQuery;
    if(passedSearchQuery == 'ISMMART Originals'){
      searchQuery = 'IsmmartOriginal';
      controller.setSelectedCategory(searchQuery);
    }
    else if(passedSearchQuery == 'Popular Products'){
      searchQuery = 'Latest';
      controller.setSelectedCategory(searchQuery);
    }
    else if(passedSearchQuery == 'Featured Products'){
      searchQuery = 'Featured';
      controller.setSelectedCategory(searchQuery);
    }
    else{
      searchQuery = passedSearchQuery;
      controller.setSelectedCategory(passedSearchQuery);
    }
    controller.getProductsByType(searchQuery);


    return Hero(
      tag: "productSearchBar",
      child: SafeArea(
        child: WillPopScope(
          onWillPop: (){
            return controller.goBack();
          },
          child: Scaffold(
            backgroundColor: Colors.grey[100]!,
            appBar: _searchAppBar(),
            body: _body(),
            //floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
            //floatingActionButton: _filterBar(),
          ),
        ),
      ),
    );
    /* return controller.obx((state) {

    },onLoading: NoDataFound());*/
  }

  _searchAppBar() {
    return AppBar(
      backgroundColor: kAppBarColor,
      elevation: 0,
      automaticallyImplyLeading: false,
      leadingWidth: 40,
      leading: isCalledForDeals!
          ? null
          : InkWell(
              onTap: () {
                controller.goBack();
              },
              child: Icon(
                Icons.arrow_back_ios_new,
                size: 18,
                color: kPrimaryColor,
              ),
            ),
      title: Container(
        height: 36,
        child: TextField(
          controller: controller.searchTextController,
          //focusNode: controller.focus,
          onChanged: (value){
            if(value != '') {
              controller.setSelectedCategory(null);
              controller.search(controller.searchTextController.text);
            }
          },
          cursorColor: kPrimaryColor,
          autofocus: false,
          maxLines: 1,
          style: TextStyle(
            color: kLightColor,
            fontWeight: FontWeight.w600,
            fontSize: 15.0,
          ),
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
            filled: true,
            prefixIcon: Icon(Icons.search, color: kPrimaryColor),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: kLightGreyColor,
                width: 0.5,
              ), //BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: kLightGreyColor,
                width: 0.5,
              ), //BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            fillColor: kWhiteColor,
            contentPadding: EdgeInsets.zero,
            hintText: langKey.searchIn.tr,
            hintStyle: TextStyle(
              color: kLightColor,
              fontWeight: FontWeight.w600,
              fontSize: 13.0,
            ),
          ),
        ),
      ),
    );
  }

  _body() {
    //print("ProductList: ${controller.productList.length}");
    /* return GetBuilder<SearchController>(
        builder: (_) => */ /*controller.isLoading.isTrue
            ? CustomLoading(isItForWidget: true, color: kPrimaryColor)
            : */ /*controller.productList.isEmpty
                ? Center(
                    child: NoDataFoundWithIcon(
                      title: langKey.emptyProductSearch.tr,
                      subTitle: langKey.emptyProductSearchMsg.tr,
                    ),
                  )
                : _buildProductView(controller.productList));*/

    return Obx(() => controller.isLoading.isTrue
        ? CustomLoading(isItForWidget: true, color: kPrimaryColor)
        : controller.productList.isEmpty
            ? Center(
                child: NoDataFoundWithIcon(
                  title: langKey.emptyProductSearch.tr,
                  subTitle: langKey.emptyProductSearchMsg.tr,
                ),
              )
            : _buildProductView(controller.productList));
  }

  Widget _buildProductView(List<ProductModel> list) {
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
                        controller.makeSelectedCategory(categoryModel);
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
                          title: categoryModel.name,
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

  Widget _filtersBtn() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 15),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: CustomButton(
              onTap: () => controller.clearFilters(),
              text: clear.tr,
              color: kOrangeColor,
              height: 36,
            ),
          ),
          SizedBox(width: 20),
          Expanded(
            child: CustomButton(
              onTap: () {
                controller.applyFilter();
                controller.minPriceController.clear();
                controller.maxPriceController.clear();
              },
              text: langKey.search.tr,
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
