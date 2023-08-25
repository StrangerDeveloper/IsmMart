import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:get/get.dart';
import 'package:ism_mart/api_helper/api_service.dart';
import 'package:ism_mart/exports/export_controllers.dart';
import 'package:ism_mart/exports/exports_model.dart';
import 'package:ism_mart/exports/exports_utils.dart';
import 'package:ism_mart/helper/languages/translations_key.dart' as langKey;
import 'package:ism_mart/helper/no_internet_view.dart';
import 'package:ism_mart/screens/dashboard/dashboard_viewmodel.dart';
import 'package:ism_mart/screens/top_vendors/top_vendors_model.dart';

import '../../helper/global_variables.dart';
import '../../widgets/custom_grey_border_container.dart';
import '../../widgets/custom_loading.dart';
import '../../widgets/custom_network_image.dart';
import '../../widgets/custom_price_widget.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/no_data_found.dart';
import '../../widgets/single_category_item.dart';
import '../../widgets/single_product_grid_item.dart';
import '../../widgets/sticky_label_with_view_more.dart';
import '../../widgets/sticky_labels.dart';
import '../live_match/live_match_view.dart';
import '../product_detail/product_detail_view.dart';
import '../search_details/search_details_view.dart';

class DashboardView extends GetView<BaseController> {
  DashboardView({Key? key}) : super(key: key);

  final DashboardViewModel viewModel = Get.put(DashboardViewModel());

  @override
  Widget build(BuildContext context) {
    /// Update Alert used for display update dialog of the app Updates
    return SafeArea(
      child: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    _slider(controller.sliderImages),
                    StickyLabel(text: langKey.topCategories.tr),
                    _topCategoriesGrid(controller.categories),
                    //Top Vendors List
                    StickyLabel(text: langKey.topVendors.tr),
                    _topVendors(),
                    StickyLabel(text: langKey.discountDeals.tr),
                    _displayDiscountProducts(),
                    Obx(
                      () => _displayProducts(
                        productMap: controller.productsWithTypesMap,
                      ),
                    ),
                    kDivider,
                    Obx(
                      () => _displayProducts(
                        productMap: controller.productsMap,
                        calledForCategoryProducts: true,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          chatWidget(),

          NoInternetView(
            onPressed: () {
              controller.getAllApiFunc();
              GlobalVariable.btnPress(true);
            },
          ),
        banner(),
        ],
      ),
    );
  }

  Widget _slider(List<SliderModel> list) {
    return Obx(
      () => controller.isSliderLoading.isTrue
          ? CustomLoading(isItForWidget: true)
          : Stack(
              alignment: Alignment.bottomCenter,
              children: [
                SizedBox(
                  height: AppResponsiveness.getBoxHeightPoint15(),
                  child: PageView.builder(
                    controller: controller.sliderPageController,
                    onPageChanged: (value) {
                      controller.sliderIndex(value);
                    },
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      SliderModel model = list[index];
                      return CustomNetworkImage(
                        imageUrl: model.image!,
                        fit: BoxFit.fill,
                        width: AppConstant.getSize().width,
                      );
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 6),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      list.length,
                      (index) => AnimatedContainer(
                        duration: const Duration(milliseconds: 400),
                        height: 6.0,
                        width: controller.sliderIndex.value == index ? 14 : 6,
                        margin: const EdgeInsets.only(right: 3),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: controller.sliderIndex.value == index
                              ? Colors.black
                              : Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Widget _displayDiscountProducts() {
    return Obx(
      () => Container(
        margin: const EdgeInsets.only(top: 10),
        color: kWhiteColor,
        height: AppResponsiveness.getBoxHeightPoint32(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            controller.discountSliderProductsList.isEmpty
                ? NoDataFound()
                : SizedBox(
                    width: AppConstant.getSize().width * 0.9,
                    height: AppResponsiveness.height * 0.24,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.discountSliderProductsList.length,
                      itemBuilder: (_, index) {
                        ProductModel model =
                            controller.discountSliderProductsList[index];
                        return _singleDiscountProductItem(model);
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Widget _singleDiscountProductItem(ProductModel model) {
    var endTime =
        DateTime.now().add(const Duration(hours: 17)).millisecondsSinceEpoch;
    return InkWell(
      onTap: () {
        // Get.toNamed(Routes.singleProductDetails, arguments: [
        //   {"calledFor": "customer", "productID": "${model.id}"}
        // ]);
        Get.to(
          () => ProductDetailView(),
          arguments: {'productID': model.id, 'isBuyer' : true},
        );
      },
      child: Stack(
        fit: StackFit.loose,
        children: [
          Container(
            width: AppResponsiveness.width * 0.9,
            height: AppResponsiveness.height * 0.2,
            margin: const EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey.shade200, width: 1),
            ),
            child: CustomNetworkImage(
              imageUrl: model.thumbnail,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 0,
                ),
                child: Column(
                  children: [
                    CountdownTimer(
                      endTime: endTime,
                      widgetBuilder: (context, CurrentRemainingTime? time) {
                        if (time == null) {
                          endTime = DateTime.now()
                              .add(const Duration(hours: 4))
                              .millisecondsSinceEpoch;
                          return Text(
                            '',
                            style: bodyText2,
                          );
                        }
                        return singleTimeWidget(time);
                      },
                    ),
                    Card(
                      shadowColor: kDarkColor,
                      child: SizedBox(
                        height: AppResponsiveness.getHeight90_100(),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CustomText(
                                title: model.name ?? '',
                                size: 16,
                                weight: FontWeight.bold,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CustomPriceWidget(
                                    title: "${model.discountPrice!}",
                                    style: headline3,
                                  ),
                                  AppConstant.spaceWidget(width: 5),
                                  CustomPriceWidget(
                                    title: "${model.price!}",
                                    style: bodyText1.copyWith(
                                      decoration: TextDecoration.lineThrough,
                                      fontSize: 13,
                                    ),
                                  ),
                                  AppConstant.spaceWidget(width: 8),
                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: "${model.discount}% ",
                                          style: bodyText1.copyWith(
                                            color: kRedColor,
                                          ),
                                        ),
                                        TextSpan(
                                          text: langKey.OFF.tr,
                                          style: bodyText2,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
          ),
        ],
      ),
    );
  }

  Widget singleTimeWidget(CurrentRemainingTime? time) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (time!.days != null) _timeCard(time.days!, "days"),
        if (time.hours != null) _timeCard(time.hours!, "hours"),
        if (time.min != null) _timeCard(time.min!, "min"),
        if (time.sec != null) _timeCard(time.sec!, "sec"),
      ],
    );
  }

  Widget _timeCard(int timePart, String format) {
    return Card(
      child: SizedBox(
        width: AppResponsiveness.getWidth50(),
        height: AppResponsiveness.getHeight50_60(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomText(
              title: "$timePart",
              style: bodyText1,
            ),
            CustomText(title: "$format", style: bodyText2),
          ],
        ),
      ),
    );
  }

  Widget _displayProducts(
      {JSON? productMap, bool? calledForCategoryProducts = false}) {
    var isPopular = false;
    return Column(
        children: productMap!.entries.map((e) {
      List list = e.value;
      if (list.isNotEmpty && list.length > 1) {
        if (e.key.toLowerCase().contains("popular"))
          isPopular = true;
        else
          isPopular = false;
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            StickyLabelWithViewMoreOption(
              title: e.key,
              textSize: 20,
              onTap: () {
                Get.find<CustomSearchController>().filters.clear();
                Get.to(
                  () => SearchDetailsView(
                    isCalledForLatestAndBestSeller:
                        e.key == 'Best Seller' || e.key == 'Popular Products'
                            ? true
                            : false,
                    searchQuery: "",
                    productTypeKey: "${e.key}",
                    calledToGoBackOnce: true,
                  ),
                );
              },
            ),
            AppConstant.spaceWidget(height: 10),
            _trendingProducts(list as List<ProductModel>, isPopular,
                calledForCategoryProducts)
          ],
        );
      }

      return Container();
    }).toList());
  }

  Widget _trendingProducts(
    List<ProductModel> list,
    bool? isPopular,
    bool? isCategoryProducts,
  ) {
    if (isPopular!)
      return Padding(
        padding: const EdgeInsets.all(6.0),
        child: SizedBox(
          //height: AppConstant.getSize().height * 0.5,
          child: GridView.builder(
              shrinkWrap: true,

              ///Reducing memory consumption
              addAutomaticKeepAlives: false,
              addRepaintBoundaries: false,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                // Maximum width of each item
                childAspectRatio: 0.92,
                // Aspect ratio of each item (width / height)
                mainAxisSpacing: 10,
                // Spacing between rows
                crossAxisSpacing: 10, // Spacing between columns
              ),
              itemCount: list.length,
              itemBuilder: (_, index) {
                ProductModel productModel = list[index];
                return SingleProductItems(
                  productModel: productModel,
                  isCategoryProducts: isCategoryProducts,
                );
              }),
        ),
      );

    if (isCategoryProducts!)
      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          //crossAxisCount: AppResponsiveness.getGridItemCount(),
          maxCrossAxisExtent: 170,
          // Maximum width of each item
          childAspectRatio: 0.8,
          // Aspect ratio of each item (width / height)
          mainAxisSpacing: 5,
          // Spacing between rows
          crossAxisSpacing: 5, // Spacing between columns
        ),
        itemCount: list.length,
        itemBuilder: (context, index) {
          ProductModel productModel = list[index];
          return SingleProductItems(
            productModel: productModel,
            isCategoryProducts: isCategoryProducts,
          );
        },
      );

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: isCategoryProducts ? 170 : 190,
        // height: AppResponsiveness.height *
        //     (!isCategoryProducts!
        //         ? 0.28
        //         : 0.22), //AppResponsiveness.getBoxHeightPoint25(),
        child: ListView.builder(
          ///Reducing memory consumption
          addAutomaticKeepAlives: false,
          addRepaintBoundaries: false,
          scrollDirection: Axis.horizontal,
          itemCount: list.length,
          itemBuilder: (context, index) {
            ProductModel productModel = list[index];
            return SingleProductItems(
              productModel: productModel,
              isCategoryProducts: isCategoryProducts,
            );
          },
        ),
      ),
    );
  }

  Widget _topCategoriesGrid(List<CategoryModel> list) {
    return Obx(
      () => controller.isCategoriesLoading.isTrue
          ? CustomLoading(isItForWidget: true)
          : Padding(
              padding: const EdgeInsets.fromLTRB(10, 8, 10, 5),
              child: SizedBox(
                height: AppResponsiveness.getBoxHeightPoint25(),
                child: list.isEmpty
                    ? NoDataFound(text: langKey.noCategoryFound.tr)
                    : GridView.builder(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          //maxCrossAxisExtent: 150,
                          crossAxisCount: 2,
                          //childAspectRatio: 1,
                          mainAxisSpacing: 5,
                          crossAxisSpacing: 5,
                        ),
                        itemCount: list.length,
                        itemBuilder: (context, index) {
                          CategoryModel model = list[index];
                          return SingleCategoryItem(categoryModel: model);
                        },
                      ),
              ),
            ),
    );
  }

  Widget _topVendors() {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.fromLTRB(10, 8, 10, 5),
        child: SizedBox(
          height: 120,
          child: topVendorsViewModel.topVendorList.isEmpty
              ? NoDataFound()
              : ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemCount: topVendorsViewModel.topVendorList.length,
                  itemBuilder: (context, index) {
                    TopVendorsModel vendorsModel =
                        topVendorsViewModel.topVendorList[index];
                    return topVendorsListViewItem(vendorsModel: vendorsModel);
                  },
                ),
        ),
      ),
    );
  }

  Widget topVendorsListViewItem({TopVendorsModel? vendorsModel}) {
    return InkWell(
      onTap: () {
        Get.toNamed('/storeDetails/${vendorsModel.id}');
      },
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CustomGreyBorderContainer(
          width: 100,
          padding: const EdgeInsets.all(8),
          borderColor: kTransparent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                padding: EdgeInsets.all(1),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: kPrimaryColor.withOpacity(0.2),
                ),
                child: ClipOval(
                  child: SizedBox.fromSize(
                    size: Size.fromRadius(25), // Image radius
                    child: CustomNetworkImage(
                      imageUrl: vendorsModel!.storeImage,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Flexible(
                child: CustomText(
                  title: vendorsModel.storeName ?? '',
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  weight: FontWeight.w600,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget banner(){
    return Obx(() => Visibility(
        visible: viewModel.bannerVisibility.value,
        child: Container(
          color: Colors.black54,
          width: MediaQuery.of(Get.context!).size.width,
          height: MediaQuery.of(Get.context!).size.height,
          child: Center(
            child: Stack(
              fit: StackFit.loose,
              children: [
                GestureDetector(
                  onTap: (){
                    Get.to(()=> LiveMatchView());
                    viewModel.bannerVisibility.value = false;
                  },
                  child: Stack(
                    children: [
                      Image.asset('assets/images/qpl_banner.png',
                        width: MediaQuery.of(Get.context!).size.width/1.2,
                        height: MediaQuery.of(Get.context!).size.height/1.8,),
                    ],
                  ),
                ),
                Positioned(
                  top: -5,
                  right: -10,
                  child: IconButton(
                      onPressed: (){
                        viewModel.bannerVisibility.value = false;
                      },
                      icon: Icon(Icons.highlight_remove, size: 30, color: Colors.white,)),
                )
              ],
            ),
            ),
          ),
        ),
      );
  }

  Widget chatWidget() {
    return Positioned(
      bottom: 12,
      right: 10,
      child: SlideTransition(
        position: viewModel.animation1,
        child: GestureDetector(
          onTap: () async {
            Get.to(()=> LiveMatchView());
          //  Get.toNamed(Routes.chatScreen);
            // await viewModel.getCurrentLocation();
          },
          child: Obx(
            () => AnimatedContainer(
              width: viewModel.containerWidth.value,
              height: 50,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1.5,
                  color: Colors.red
                ),
                  color: Colors.white,
                  // color: Color(0xff3769CA),
                  borderRadius: BorderRadius.all(Radius.circular(28)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        offset: Offset(0, 3),
                        blurRadius: 1,
                        spreadRadius: 1)
                  ]),
              duration: Duration.zero,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 13.0),
                child: FadeTransition(
                  opacity: viewModel.animation3,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/qpl_logo.png', width: 35, height: 35,),
                    Text(
                          'Live',
                            style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.w600,
                                fontSize: 14),
                          ),
                        FadeTransition(
                            opacity: viewModel.animation4,
                            child: Icon(Icons.circle,
                                size: 15, color: Colors.red),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }


}
