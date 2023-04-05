import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ism_mart/controllers/export_controllers.dart';
import 'package:ism_mart/models/exports_model.dart';
import 'package:ism_mart/presentation/export_presentation.dart';
import 'package:ism_mart/utils/exports_utils.dart';
import 'package:ism_mart/utils/languages/translations_key.dart' as langKey;

class SearchUI extends GetView<SearchController> {
 const SearchUI({
    Key? key,
    this.isCalledForDeals = false,
  }) : super(key: key);
  final bool? isCalledForDeals;



 // final controller = Get.find<SearchController>();
  @override
  Widget build(BuildContext context) {

    controller.search(
        Get.arguments != null ? Get.arguments["searchText"].toString() : " ");

    return Hero(
      tag: "productSearchBar",
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.grey[100]!,
          appBar: _searchAppBar(),
          body: _body(),
          //floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          //floatingActionButton: _filterBar(),
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
              onTap: () => Get.back(),
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
        builder: (_) => *//*controller.isLoading.isTrue
            ? CustomLoading(isItForWidget: true, color: kPrimaryColor)
            : *//*controller.productList.isEmpty
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
                    title: "${list.length} items found",
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
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Expanded(
                  child: GridView.builder(
                    controller: controller.scrollController,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: AppResponsiveness.getGridItemCount(),
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        mainAxisExtent:
                            AppResponsiveness.getMainAxisExtentPoint25()),
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
        ),
      ],
    );
  }

  void showFilterBottomSheet() {
    //var categoryController = Get.find<CategoryController>();
    debugPrint(">>> ${controller.categoriesList.length}");
    AppConstant.showBottomSheet(
      widget: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  StickyLabel(text: "Categories"),
                  Obx(
                    () => Container(
                      height: 70,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: ListView.builder(
                        //shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.categoriesList.length,
                        itemBuilder: (_, index) {
                          CategoryModel categoryModel =
                              controller.categoriesList[index];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () {
                                controller
                                    .selectedCategoryId(categoryModel.id!);
                                controller.makeSelectedCategory(categoryModel);
                              },
                              child: Container(
                                //height: 50,
                                constraints: BoxConstraints(minWidth: 50),
                                alignment: Alignment.center,
                                padding: const EdgeInsets.all(8.0),
                                margin:
                                    const EdgeInsets.symmetric(vertical: 5.0),
                                // margin: const EdgeInsets.only(bottom: 20.0),
                                decoration: BoxDecoration(
                                    color: categoryModel.isPressed!
                                        ? kPrimaryColor
                                        : kTransparent,
                                    border: categoryModel.isPressed!
                                        ? Border()
                                        : Border.all(),
                                    borderRadius: BorderRadius.circular(5.0)),
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
                  StickyLabel(text: "Price"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: 130,
                        height: 50,
                        child: FormInputFieldWithIcon(
                          controller: controller.minPriceController,
                          iconPrefix: Icons.attach_money_rounded,
                          labelText: 'Min Price',
                          iconColor: kPrimaryColor,
                          enableBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: kPrimaryColor, width: 1.5),
                            //borderRadius: BorderRadius.circular(25.0),
                          ),
                          autofocus: false,
                          textStyle: bodyText1,
                          keyboardType: TextInputType.number,
                          onChanged: (value) {},
                          onSaved: (value) {},
                        ),
                      ),
                      SizedBox(
                        width: 130,
                        height: 50,
                        child: FormInputFieldWithIcon(
                          controller: controller.maxPriceController,
                          iconPrefix: Icons.attach_money_rounded,
                          labelText: 'Max Price',
                          iconColor: kPrimaryColor,
                          autofocus: false,
                          enableBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: kPrimaryColor, width: 1.5),
                            //borderRadius: BorderRadius.circular(25.0),
                          ),
                          textStyle: bodyText1,
                          keyboardType: TextInputType.number,
                          onChanged: (value) {},
                          onSaved: (value) {},
                        ),
                      ),
                    ],
                  ),
                  AppConstant.spaceWidget(height: 20),
                  _filtersBtn(),
                  AppConstant.spaceWidget(height: 10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _filtersBtn() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        CustomButton(
          onTap: () => controller.clearFilters(),
          text: "Clear",
          color: kOrangeColor,
          width: 120,
          height: 35,
        ),
        CustomButton(
          onTap: () => controller.applyFilter(),
          text: "Search",
          width: 120,
          height: 35,
        ),
      ],
    );
  }

  void showSortBottomSheet() {
    AppConstant.showBottomSheet(
      widget: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            CustomText(
                title: langKey.sortBy.tr, size: 20, weight: FontWeight.bold),
            AppConstant.spaceWidget(height: 10),
            RadioListTile(
              //selected: controller.sortBy!.contains("low-to-high"),
              activeColor: kPrimaryColor,
              toggleable: true,
              title: CustomText(
                title: 'Low to High',
                size: 16,
              ),
              value: 'low-to-high',
              onChanged: (String? value) {
                controller.setSortBy(value!);
                Get.back();
              },
              groupValue: controller.sortBy,
            ),
            RadioListTile(
              activeColor: kPrimaryColor,
              //selected: controller.sortBy!.contains("high-to-low"),
              toggleable: true,
              title: CustomText(
                title: 'High to Low',
                size: 16,
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
      ),
    );
  }
}
