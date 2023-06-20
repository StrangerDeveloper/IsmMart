import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ism_mart/exports/export_presentation.dart';
import 'package:ism_mart/helper/no_internet_view.dart';
import 'package:ism_mart/screens/deals/deals_viewmodel.dart';
import 'package:ism_mart/utils/languages/translations_key.dart' as langKey;
import '../../controllers/controllers.dart';
import '../categories/model/category_model.dart';
import '../../models/product/product_model.dart';
import '../../helper/constants.dart';
import '../../helper/responsiveness.dart';
import '../../widgets/loader_view.dart';

class DealsView extends StatelessWidget {
  DealsView({super.key});

  final DealsViewModel viewModel = Get.put(DealsViewModel());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar: _appBar(),
        body: Obx(() =>
        viewModel.noProductsFound.value ?
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              NoDataFoundWithIcon(
                title: langKey.emptyProductSearch.tr,
                subTitle: langKey.emptyProductSearchMsg.tr,
              ),
              AppConstant.spaceWidget(
                height: 18
              ),
              TextButton(
                  onPressed: ()async {
                    viewModel.filters.clear();
                    viewModel.page = 1;
                    viewModel.searchTextController.clear();
                    viewModel.searchEnabled.value = false;
                    viewModel.selectedCategoryId.value = 0;
                    viewModel.unselectCategory();
                    viewModel.url = 'filter?type=Discounts&limit=${viewModel
                        .limit}&page=${viewModel.page}&';
                    await viewModel.getProducts();
                  }, child: Text(
                'Clear Filters',
                style: TextStyle(
                  color: kPrimaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 17
                ),
              ))
            ],
          ),
          // NoInternetView(
          // onPressed: () {
          //   viewModel.addFilters();
          //   },
          // ),
        ) : Stack(
          children: [
            Column(
              children: [
                Material(
                  elevation: 1,
                  child: Container(
                    height: AppConstant
                        .getSize()
                        .height * 0.05,
                    color: kWhiteColor,
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: CustomText(
                            title:
                            "${viewModel.productList.length} ${langKey
                                .itemsFound.tr}",
                            weight: FontWeight.w600,
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton.icon(
                                onPressed: () {
                                  viewModel.setCategories(baseController.categories);
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
                // AppConstant.spaceWidget(height: 13),
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 6.0, horizontal: 4),
                    child: Visibility(
                        child: viewModel.searchEnabled.value ? TextButton(
                          onPressed: () {
                            viewModel.filters.remove('text');
                            viewModel.searchTextController.clear();
                            viewModel.searchEnabled.value = false;
                            viewModel.addFilters();
                          },
                          child: Text(
                            'Clear Search',
                            style: TextStyle(
                                color: kPrimaryColor,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline
                            ),
                          ),
                        ),
                        Expanded(
                          child: GridView.builder(
                            padding: EdgeInsets.all(8),
                            controller: viewModel.scrollController,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount:
                                    AppResponsiveness.getGridItemCount(),
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 10,
                                childAspectRatio: AppResponsiveness
                                    .getChildAspectRatioPoint90()
                                // mainAxisExtent:
                                //     AppResponsiveness.getMainAxisExtentPoint25(),
                                ),
                            itemCount: viewModel.productList.length,
                            itemBuilder: (_, index) {
                              ProductModel productModel =
                                  viewModel.productList[index];
                              return SingleProductItems(
                                  productModel: productModel);
                            },
                          ),
                        ),
                        if (viewModel.isLoadingMore.isTrue)
                          CustomLoading(
                            isItForWidget: true,
                            color: kPrimaryColor,
                          )
                      ],
                    ),
                    NoInternetView(
                      onPressed: () {
                        viewModel.addFilters();
                        // viewModel.addFilters();
                        // viewModel.addPriceFilter();
                      },
                    ),
                    LoaderView(),
                  ],
                ),
        ),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      backgroundColor: kAppBarColor,
      elevation: 0,
      automaticallyImplyLeading: false,
      leadingWidth: 40,
      leading: InkWell(
        onTap: () {
          baseController.changePage(0);
          viewModel.productList.clear();
          viewModel.page = 1;
          viewModel.limit.value = 15;
          viewModel.searchTextController.clear();
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
          controller: viewModel.searchTextController,
          textInputAction: TextInputAction.search,
          onSubmitted: (value) {
            viewModel.filters.clear();
            viewModel.page = 1;
            viewModel.unselectCategory();
            viewModel.url =
                'filter?type=Discounts&limit=${viewModel.limit}&page=${viewModel.page}&';
            viewModel.filters.addAll({'text': value});
            viewModel.searchProducts(value);
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
                itemCount: viewModel.categoriesList.length,
                itemBuilder: (_, index) {
                  CategoryModel categoryModel = viewModel.categoriesList[index];
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 13),
                    child: InkWell(
                      onTap: () {
                        viewModel.selectedCategoryId(categoryModel.id!);
                        viewModel.setSelectedCategory(categoryModel);
                        if (viewModel.filters.containsKey('category')) {
                          viewModel.filters.remove('category');
                          viewModel.filters
                              .addAll({'category': '${categoryModel.id}'});
                          viewModel.addFilters();
                        } else {
                          viewModel.filters
                              .addAll({'category': '${categoryModel.id}'});
                          viewModel.addFilters();
                        }
                        Get.back();
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
                    controller: viewModel.minPriceController,
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
                    controller: viewModel.maxPriceController,
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
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: CustomTextBtn(
              onPressed: () {}, //=> controller.clearFilters(),
              title: langKey.clear.tr,
              height: 36,
            ),
          ),
          SizedBox(width: 20),
          Expanded(
            child: CustomTextBtn(
              onPressed: () {
                viewModel.addPriceFilter();
                // controller.applyFilter();
                // Get.back();
                // controller.minPriceController.clear();
                // controller.maxPriceController.clear();
              },
              title: langKey.search.tr,
              height: 36,
            ),
          ),
        ],
      ),
    );
  }
}
