import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ism_mart/api_helper/api_service.dart';
import 'package:ism_mart/controllers/export_controllers.dart';
import 'package:ism_mart/models/exports_model.dart';
import 'package:ism_mart/presentation/ui/exports_ui.dart';
import 'package:ism_mart/presentation/widgets/export_widgets.dart';
import 'package:ism_mart/utils/exports_utils.dart';

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
                _displayDiscountProducts(),

                StickyLabelWithViewMoreOption(
                    title: "Top Categories",
                    onTap: () => controller.changePage(1)),
                _topCategoriesGrid(controller.categories),
                kDivider,
                Obx(() => _displayProducts(
                    productMap: controller.productsWithTypesMap)),
                kDivider,
                Obx(() => _displayProducts(productMap: controller.productsMap)),
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
      backgroundColor: kPrimaryColor,
      // elevation: 5,
      floating: true,
      pinned: true,

      title: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          buildSvgLogo(),
          const Expanded(flex: 6, child: SearchBar()),
          //const Expanded(flex:1,child:Center())
        ],
      ),
    );
  }

  Widget _slider(List<SliderModel> list) {
    return Obx(
      () => controller.isSliderLoading.isTrue
          ? CustomLoading(
              isDarkMode: Get.isDarkMode,
              isItForWidget: true,
            )
          : Stack(
              children: [
                SizedBox(
                  height: 170.0,
                  child: PageView.builder(
                    controller: controller.sliderPageController,
                    onPageChanged: (value) {
                      controller.sliderIndex(value);
                    },
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      SliderModel model = list[index];
                      return Stack(
                        children: [
                          CustomNetworkImage(
                            imageUrl: model.image!,
                            width: MediaQuery.of(context).size.width,
                          ),
                          Positioned(
                            left: 5,
                            top: 5,
                            child: Column(
                              children: [
                                CustomText(
                                  title: model.type,
                                  size: 20,
                                  weight: FontWeight.bold,
                                ),
                                CustomText(
                                  title: model.title,
                                )
                              ],
                            ),
                          ),
                        ],
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
        color: kLightGreenColor,
        height: 150,
        child: controller.discountSliderProductsList.isEmpty
            ? NoDataFound()
            : ListView.builder(
                shrinkWrap: true,
                itemCount: controller.discountSliderProductsList.length,
                itemBuilder: (_, index) {
                  ProductModel model =
                      controller.discountSliderProductsList[index];
                  return Container();
                },
              ),
      ),
    );
  }

  _singleDiscountProductItem(ProductModel model) {

    return Container(
      clipBehavior: Clip.hardEdge,
      margin: const EdgeInsets.only(right: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Get.isDarkMode ? Colors.grey.shade700 : Colors.white60,
        border: Border.all(
            color: Get.isDarkMode ? Colors.transparent : Colors.grey.shade200,
            width: 1),
      ),
      child: ListTile(
        leading: CustomNetworkImage(
          imageUrl: model.thumbnail,
        ),
        title: Row(
          children: [
            RichText(
              text: TextSpan(children: [
                TextSpan(text: "${model.discount} "),
                TextSpan(text: "Off"),
              ]),
            ),
            AppConstant.spaceWidget(width: 10),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              decoration: BoxDecoration(
                color: kLightGreenColor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: CustomText(
                title: "Active",
                color: kWhiteColor,
                size: 13,
                weight: FontWeight.w600,
              ),
            ),
          ],
        ),
        subtitle: Column(
          children: [

          ],
        ),
      ),
    );
  }

  Widget _trendingProducts(List<ProductModel> list) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 200,
        child: ListView.builder(
          // padding: const EdgeInsets.only(left: 10),
          scrollDirection: Axis.horizontal,
          itemCount: list.length,
          itemBuilder: (context, index) {
            ProductModel productModel = list[index];
            return _buildProductItem(model: productModel);
          },
        ),
      ),
    );
  }

  _buildProductItem({ProductModel? model}) {
    return AspectRatio(
      aspectRatio: 0.75,
      child: GestureDetector(
        onTap: () {
          Get.toNamed('/product/${model.id}',
              arguments: {"calledFor": "customer"});
        },
        child: Container(
          clipBehavior: Clip.hardEdge,
          margin: const EdgeInsets.only(right: 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Get.isDarkMode ? Colors.grey.shade700 : Colors.white60,
            border: Border.all(
                color:
                    Get.isDarkMode ? Colors.transparent : Colors.grey.shade200,
                width: 1),
          ),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 100,
                    width: double.infinity,
                    child: CustomNetworkImage(imageUrl: model!.thumbnail),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(title: "Sold: ${model.sold!}"),
                        CustomText(title: model.name!, maxLines: 1),
                        AppConstant.spaceWidget(height: 5),
                        CustomPriceWidget(title: "${model.discountPrice!}"),
                        if (model.discount != 0)
                          CustomText(
                            title:
                                "${AppConstant.getCurrencySymbol()}${model.price!}",
                            style: textTheme.caption?.copyWith(
                                decoration: TextDecoration.lineThrough,
                                fontSize: 14,
                                color: kLightGreyColor),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
              if (model.discount != 0)
                Positioned(
                  top: 5,
                  right: 5,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    decoration: BoxDecoration(
                      color: kOrangeColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: CustomText(
                      title: "${model.discount}% Off",
                      color: kWhiteColor,
                      size: 12,
                      weight: FontWeight.w600,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _displayProducts({JSON? productMap}) {
    return Column(
        children: productMap!.entries.map((e) {
      List list = e.value;
      if (list.isNotEmpty) {
        return Column(
          children: [
            StickyLabelWithViewMoreOption(
                title: e.key,
                onTap: () {
                  Get.toNamed(Routes.searchRoute,
                      arguments: {"searchText": "${e.key}"});
                }),
            _trendingProducts(e.value as List<ProductModel>)
          ],
        );
      }

      return Container();
    }).toList());
  }

  Widget _topCategoriesGrid(List<CategoryModel> list) {
    var theme = Theme.of(Get.context!);
    return Obx(
      () => controller.isCategoriesLoading.isTrue
          ? CustomLoading(isDarkMode: Get.isDarkMode, isItForWidget: true)
          : Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 8.0),
              child: SizedBox(
                height: 120,
                child: list.isEmpty
                    ? const NoDataFound(text: "No category found")
                    : GridView.builder(
                        scrollDirection: Axis.horizontal,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          //maxCrossAxisExtent: 150,
                          crossAxisCount: 1,
                          childAspectRatio: _getChildAspectRatio(Get.context!),
                          mainAxisSpacing: 5.0,
                          crossAxisSpacing: 5.0,
                        ),
                        itemCount: list.length,
                        itemBuilder: (context, index) {
                          CategoryModel model = list[index];
                          return _buildCategory(model, index, theme);
                        },
                      ),
              ),
            ),
    );
  }

  Widget _buildCategory(CategoryModel category, index, theme) {
    return InkWell(
      onTap: () {
        Get.toNamed(Routes.searchRoute,
            arguments: {"searchText": "${category.name}"});
      },
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        margin: EdgeInsets.only(
            right: controller.categories.length - 1 == index ? 0 : 5),
        child: Stack(
          children: [
            SizedBox(
              width: 130,
              height: 130,
              child: CustomNetworkImage(imageUrl: category.image!),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.black.withAlpha(110),
                ),
                child: Center(
                  child: Text(
                    category.name ?? "",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: textTheme.subtitle2?.copyWith(color: Colors.white),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _getChildAspectRatio(context) {
    double aspectRatio = MediaQuery.of(context).size.width /
        (MediaQuery.of(context).size.height / 2.7);
    return aspectRatio;
  }
}
