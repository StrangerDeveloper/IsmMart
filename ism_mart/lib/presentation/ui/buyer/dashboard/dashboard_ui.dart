import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:get/get.dart';
import 'package:ism_mart/api_helper/api_service.dart';
import 'package:ism_mart/controllers/export_controllers.dart';
import 'package:ism_mart/models/exports_model.dart';
import 'package:ism_mart/presentation/ui/exports_ui.dart';
import 'package:ism_mart/presentation/widgets/export_widgets.dart';
import 'package:ism_mart/utils/exports_utils.dart';
import 'package:ism_mart/utils/languages/translations_key.dart' as langKey;

class DashboardUI extends GetView<BaseController> {
  const DashboardUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          _sliverAppBar(),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                _slider(controller.sliderImages),

                StickyLabel(text: langKey.topCategories.tr),
                _topCategoriesGrid(controller.categories),
                //kDivider,
                _displayDiscountProducts(),
                // kDivider,
                Obx(() => _displayProducts(
                    productMap: controller.productsWithTypesMap)),
                kDivider,
                Obx(() => _displayProducts(
                    productMap: controller.productsMap,
                    calledForCategoryProducts: true)),
                // _productByCategories(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  SliverAppBar _sliverAppBar() {
    return SliverAppBar(
      backgroundColor: kAppBarColor,
      // elevation: 5,
      floating: true,
      pinned: true,

      title: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          buildSvgLogo(),
          Expanded(
            flex: 5,
            child: Obx(
              () => SearchBar(searchText: controller.randomSearchText.value),
            ),
          ),
          //const Expanded(flex:1,child:Center())
        ],
      ),
    );
  }

  Widget _slider(List<SliderModel> list) {
    //var height = AppConstant.getSize().height;
    return Obx(
      () => controller.isSliderLoading.isTrue
          ? CustomLoading(isItForWidget: true)
          : Stack(
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
                      return InkWell(
                        onTap: () => Get.toNamed(Routes.registerRoute),
                        child: CustomNetworkImage(
                          imageUrl: model.image!,
                          fit: BoxFit.fill,
                          width: AppConstant.getSize().width,
                          //height: 190,
                        ),
                      );
                    },
                  ),
                ),
                Positioned(
                  bottom: 0.0,
                  left: 0.0,
                  right: 0.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      list.length,
                      (index) => AnimatedContainer(
                        duration: const Duration(milliseconds: 400),
                        height: 6.0,
                        width:
                            controller.sliderIndex.value == index ? 14.0 : 6.0,
                        margin: const EdgeInsets.only(right: 3.0),
                        decoration: BoxDecoration(
                          color: controller.sliderIndex.value == index
                              ? kPrimaryColor
                              : kLightColor,
                          borderRadius: BorderRadius.circular(5.0),
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
          children: [
            StickyLabel(text: langKey.discountDeals.tr),
            AppConstant.spaceWidget(height: 10),
            controller.discountSliderProductsList.isEmpty
                ? Center(child: NoDataFound())
                : SizedBox(
                    width: AppConstant.getSize().width * 0.9,
                    height: AppResponsiveness.height * 0.24,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      //physics: const AlwaysScrollableScrollPhysics(),
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

  _singleDiscountProductItem(ProductModel model) {
    var endTime =
        DateTime.now().add(const Duration(hours: 17)).millisecondsSinceEpoch;
    return InkWell(
      onTap: () {
        Get.toNamed('/product/${model.id}',
            arguments: {"calledFor": "customer"});
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
              //fit: BoxFit.fill,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                //height: 60,
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
                                title: model.name,
                                size: 16,
                                weight: FontWeight.bold,
                              ),
                              Row(
                                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                        fontSize: 13),
                                  ),
                                  AppConstant.spaceWidget(width: 8),
                                  RichText(
                                    text: TextSpan(children: [
                                      TextSpan(
                                          text: "${model.discount}% ",
                                          style: bodyText1.copyWith(
                                              color: kRedColor)),
                                      TextSpan(
                                          text: langKey.OFF.tr,
                                          style: bodyText1),
                                    ]),
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

  _timeCard(int timePart, String format) {
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
                  Get.toNamed(Routes.searchRoute,
                      arguments: {"searchText": "${e.key}"});
                }),
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
      List<ProductModel> list, bool? isPopular, bool? isCategoryProducts) {
    //var height = AppConstant.getSize().height;
    if (isPopular!)
      return Padding(
        padding: const EdgeInsets.all(6.0),
        child: SizedBox(
          //height: AppConstant.getSize().height * 0.5,
          child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: AppResponsiveness.getGridItemCount(),
                  mainAxisExtent: AppResponsiveness.getMainAxisExtentPoint25(),
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10),
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

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height:
            AppResponsiveness.getBoxHeightPoint25(),
        child: ListView.builder(
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
    //var theme = Theme.of(Get.context!);
    //double height = AppConstant.getSize().height;
    return Obx(
      () => controller.isCategoriesLoading.isTrue
          ? CustomLoading(isItForWidget: true)
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: SizedBox(
                height: AppResponsiveness.getBoxHeightPoint25(),
                child: list.isEmpty
                    ? NoDataFound(text: langKey.noCategoryFound.tr)
                    : GridView.builder(
                        scrollDirection: Axis.horizontal,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          //maxCrossAxisExtent: 150,
                          crossAxisCount: 2,
                          //childAspectRatio: 1.8,
                          //mainAxisSpacing: 3.0,
                          //crossAxisSpacing: 3.0,
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

/* _getChildAspectRatio(context) {
    double aspectRatio = MediaQuery.of(context).size.width /
        (MediaQuery.of(context).size.height / 2.5);
    print("aspectRatio: $aspectRatio");
    return aspectRatio;
  }*/
}
