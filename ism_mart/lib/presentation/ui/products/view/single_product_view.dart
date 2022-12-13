import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:ism_mart/api_helper/export_api_helper.dart';
import 'package:ism_mart/controllers/export_controllers.dart';
import 'package:ism_mart/models/exports_model.dart';
import 'package:ism_mart/presentation/ui/exports_ui.dart';
import 'package:ism_mart/presentation/widgets/export_widgets.dart';
import 'package:ism_mart/utils/exports_utils.dart';

class SingleProductView extends GetView<ProductController> {
  const SingleProductView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //controller.fetchSliderImages();
    if (Get.parameters['id'] == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    controller.fetchProduct(int.parse(Get.parameters['id']!));
    final isDarkMode = Get.isDarkMode;

    return controller.obx((state) {
      if (state == null) {
        return CustomLoading(isDarkMode: isDarkMode);
      }
      return _build(context: context, productModel: state);
    }, onLoading: CustomLoading(isDarkMode: isDarkMode));
  }

  Widget _build({context, ProductModel? productModel}) {
    debugPrint("ProductSingleView: ${productModel.toString()}");
    return Scaffold(
      backgroundColor: Colors.grey[300]!,
      body: CustomScrollView(
        slivers: [
          _sliverAppBar(),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                productModel!.images!.isEmpty
                    ? CustomNetworkImage(
                        imageUrl: productModel.thumbnail!,
                        //fit: BoxFit.contain,
                        width: MediaQuery.of(Get.context!).size.width,
                        height: MediaQuery.of(Get.context!).size.height * 0.4,
                      )
                    : _productImages(imagesList: productModel.images!),
                _productBasicDetails(productModel: productModel),
                _productAdvanceDetails(productModel: productModel),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Get.arguments["calledFor"]!.contains("seller")
          ? null
          : _footerBottomBar(),
    );
  }

  SliverAppBar _sliverAppBar() {
    var baseController = Get.find<BaseController>();
    return SliverAppBar(
      //backgroundColor: kTransparent,
      automaticallyImplyLeading: true,
      leadingWidth: 30,
      floating: true,
      pinned: true,
      centerTitle: true,
      title: Get.arguments["calledFor"]!.contains("seller")
          ? CustomText(
              title: "Product Details",
              size: 18,
            )
          : Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(flex: 5, child: SearchBar()),
                    AppConstant.spaceWidget(width: 10),
                    CartIcon(
                      onTap: () {
                          Get.toNamed(Routes.cartRoute);

                        //Get.back();
                        //baseController.changePage(2);
                      },
                      iconWidget: Icon(
                        IconlyLight.buy,
                        color: kPrimaryColor,
                        size: 25,
                      ),
                    ),
                  ],
                ),
              ],
            ),
    );
  }

  _productImages({List<ProductImages>? imagesList}) {
    return Stack(
      children: [
        SizedBox(
          height: MediaQuery.of(Get.context!).size.height * 0.45,
          child: PageView.builder(
            controller: controller.pageController,
            onPageChanged: controller.changePage,
            itemCount: imagesList!.length,
            itemBuilder: (context, index) {
              return CustomNetworkImage(
                  imageUrl: imagesList[index].url,
                  width: MediaQuery.of(context).size.width);
            },
          ),
        ),
        Positioned(
          bottom: 16.0,
          left: 0.0,
          right: 0.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              imagesList.length,
              (index) => AnimatedContainer(
                duration: const Duration(milliseconds: 400),
                height: 6.0,
                width: /*controller.sliderIndex.value == index ? 14.0 :*/ 6.0,
                margin: const EdgeInsets.only(right: 4.0),
                decoration: BoxDecoration(
                  color: controller.pageIndex.value == index
                      ? kPrimaryColor
                      : kLightColor,
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  _productBasicDetails({ProductModel? productModel}) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          //mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                    title: productModel!.name,
                    size: 15, //color: kPrimaryColor,
                    weight: FontWeight.w700),
                AppConstant.spaceWidget(width: 5),
                CustomText(
                    title: "Stock: ${productModel.stock}",
                    color: kPrimaryColor,
                    weight: FontWeight.w600),
              ],
            ),
            AppConstant.spaceWidget(height: 10),
            //Price section
            Row(
              children: [
                CustomText(
                    title:
                        '${AppConstant.getCurrencySymbol()}${productModel.discountPrice}',
                    style: textTheme.headline5),
                AppConstant.spaceWidget(width: 10),
                if (productModel.discount! > 0)
                  CustomText(
                    title:
                        '${AppConstant.getCurrencySymbol()}${productModel.price}',
                    style: textTheme.bodyText1!
                        .copyWith(decoration: TextDecoration.lineThrough),
                  ),
                AppConstant.spaceWidget(width: 5),
                if (productModel.discount! > 0)
                  CustomText(
                      title: "${productModel.discount}% OFF",
                      style: textTheme.bodyText2!.copyWith(
                          fontWeight: FontWeight.w600, color: Colors.redAccent))
              ],
            ),
            AppConstant.spaceWidget(height: 8),
            // reviews
            Row(
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    width: 30,
                    height: 20,
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    decoration: BoxDecoration(
                        color: kPrimaryColor,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(5)),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Icon(
                          Icons.star,
                          color: kWhiteColor,
                          size: 9,
                        ),
                        CustomText(
                            title: "Top rated",
                            style: textTheme.bodyText1!
                                .copyWith(color: kWhiteColor, fontSize: 11)),
                      ],
                    ),
                  ),
                ),
                AppConstant.spaceWidget(width: 5),
                Expanded(
                  flex: 2,
                  child: Row(
                    children: [
                      CustomText(title: "${productModel.rating}/5 (44)"),
                      const Icon(
                        Icons.arrow_forward_ios_sharp,
                        color: kPrimaryColor,
                        size: 15,
                      ),
                      CustomText(title: "${productModel.sold} Sold"),
                    ],
                  ),
                ),
                /*Expanded(
                  //alignment: Alignment.centerRight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Icon(
                        Icons.favorite_rounded,
                        color: kPrimaryColor,
                        size: 15,
                      ),
                      CustomText(
                          title: "1k",
                          style: textTheme.bodyText2!
                              .copyWith(fontWeight: FontWeight.w600))
                    ],
                  ),
                ),*/
              ],
            ),
            AppConstant.spaceWidget(height: 8),
            ListTile(
              dense: true,
              leading: const Icon(Icons.question_answer),
              title: CustomText(
                  title: "5 Product Questions and Answer",
                  style: textTheme.bodyText2),
              trailing: const Icon(
                Icons.arrow_forward_ios_sharp,
                color: kPrimaryColor,
                size: 15,
              ),
            ),
            ListTile(
              dense: true,
              leading: const Icon(Icons.store),
              title: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                        text: "${productModel.brand} ",
                        style: textTheme.bodyLarge),
                    TextSpan(
                      text: "${_getPositiveResponse()} ",
                      style: textTheme.bodySmall!.copyWith(
                          backgroundColor: Colors.blueGrey.withOpacity(0.2)),
                    )
                  ],
                ),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios_sharp,
                color: kPrimaryColor,
                size: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }

  _productAdvanceDetails({ProductModel? productModel}) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ListTile(
              onTap: () => showVariationBottomSheet(productModel: productModel),
              dense: true,
              leading: const CustomText(title: "Variation"),
              title: Obx(
                () => CustomText(
                    title:
                        "Size: ${controller.size.value}, Color: ${controller.color.value}",
                    style: textTheme.bodyText2),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios_sharp,
                color: kPrimaryColor,
                size: 15,
              ),
            ),
            ListTile(
              dense: true,
              leading: const CustomText(title: "Specification"),
              title: CustomText(
                  title:
                      "Brand: ${productModel!.brand}, Sku: ${productModel.sku}",
                  style: textTheme.bodyText2),
              trailing: const Icon(
                Icons.arrow_forward_ios_sharp,
                color: kPrimaryColor,
                size: 15,
              ),
            ),
            ListTile(
              dense: true,
              leading: const CustomText(title: "Delivery"),
              title: CustomText(title: "deliver to!", style: textTheme.caption),
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                      title: "Standard Delivery, 2 - 7 Days!",
                      style: textTheme.caption),
                  CustomText(
                      title: "Rs. 109",
                      style: textTheme.caption!.copyWith(color: Colors.blue)),
                ],
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios_sharp,
                color: kPrimaryColor,
                size: 15,
              ),
            ),
            ListTile(
              dense: true,
              leading: const CustomText(title: "Service"),
              title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _getServices().map((e) {
                    return CustomText(title: e, style: textTheme.caption);
                  }).toList()),
              trailing: const Icon(
                Icons.arrow_forward_ios_sharp,
                color: kPrimaryColor,
                size: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getPositiveResponse() {
    return " 80% Positive Response ";
  }

  List<String> _getServices() {
    return <String>[
      "• 100% Authentic",
      "• 14 days easy Return",
      "• Change of mind not acceptable",
      "• Warranty not available"
    ];
  }

  void showVariationBottomSheet({ProductModel? productModel}) {
    AppConstant.showBottomSheet(
      widget: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(8),
        children: [
          ListTile(
            leading: CustomNetworkImage(
                imageUrl: productModel!.thumbnail!, height: 60),
            title: CustomText(title: productModel.name),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  title:
                      "${AppConstant.getCurrencySymbol()}${productModel.discountPrice}",
                  color: kPrimaryColor,
                  size: 18,
                  weight: FontWeight.bold,
                ),
                if (productModel.discount! > 0)
                  Row(
                    children: [
                      CustomText(
                        title:
                            '${AppConstant.getCurrencySymbol()}${productModel.price}',
                        style: textTheme.bodyText2!
                            .copyWith(decoration: TextDecoration.lineThrough),
                      ),
                      AppConstant.spaceWidget(width: 5),
                      CustomText(
                          title: "${productModel.discount}% OFF",
                          style: textTheme.bodyText2!.copyWith(
                              fontWeight: FontWeight.w600,
                              color: Colors.redAccent))
                    ],
                  ),
                Obx(
                  () => CustomText(
                      title:
                          "Size: ${controller.size.value}, Color: ${controller.color.value}"),
                ),
              ],
            ),
          ),
          productModel.colors == null
              ? Container()
              : Column(
                  children: [
                    const StickyLabel(
                      text: "Colors",
                      textSize: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: productModel.colors!
                          .map((e) => _buildChip(label: e))
                          .toList(),
                    )
                  ],
                ),
          productModel.sizes == null
              ? Container()
              : Column(
                  children: [
                    const StickyLabel(
                      text: "Sizes",
                      textSize: 15,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      //mainAxisAlignment: MainAxisAlignment.sp,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: productModel.sizes!
                          .map((e) =>
                              _buildChip(label: e, calledForColors: false))
                          .toList(),
                    )
                  ],
                ),
          kSmallDivider,
          _buildQtyChosen(),
          kSmallDivider,
          _buildBuyNowAndCartBtn(productModel: productModel),
          AppConstant.spaceWidget(
            height: 20,
          ),
        ],
      ),
    );
  }

  Widget _buildChip({String? label, calledForColors = true}) {
    return Obx(
      () => ChoiceChip(
        label: CustomText(
            title: label,
            style: textTheme.bodyText1!.copyWith(color: Colors.white)),
        selected: label!.toLowerCase() ==
            (calledForColors
                ? controller.color.value.toLowerCase()
                : controller.size.value.toLowerCase()),
        selectedColor: kPrimaryColor,
        onSelected: (value) {
          if (calledForColors) {
            value ? controller.color(label) : controller.color("Black");
          } else {
            value ? controller.size(label) : controller.color("L");
          }
        },
      ),
    );
  }

  Widget _buildQtyChosen() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const StickyLabel(text: "Quantity"),
        ProductQuantityCounter(
          onDecrementPress: () => controller.decrement(),
          onIncrementPress: () => controller.increment(),
          textEditingController: controller.quantityController,
        ),
      ],
    );
  }

  Widget _buildBuyNowAndCartBtn({ProductModel? productModel}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        CustomButton(
          onTap: () => LocalStorageHelper.deleteAllCart(),
          text: "Buy Now",
          color: Colors.yellow[800],
          width: 120,
          height: 35,
        ),
        CustomButton(
          onTap: () {
            controller.addItemToCart(product: productModel);
            Get.back();
          },
          text: "Add to Cart",
          width: 120,
          height: 35,
        ),
      ],
    );
  }

  _footerBottomBar() {
    return BottomAppBar(
      elevation: 20,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _getNavBarItems(icon: Icons.store),
            _getNavBarItems(icon: Icons.message),
            CustomButton(
              onTap: () =>
                  showVariationBottomSheet(productModel: controller.state),
              text: "Buy Now",
              color: Colors.yellow[800],
              width: 100,
              height: 35,
            ),
            CustomButton(
              onTap: () =>
                  showVariationBottomSheet(productModel: controller.state),
              text: "Add to Cart",
              width: 100,
              height: 35,
            ),
            //_buildBuyNowAndCartBtn(),
          ],
        ),
      ),
    );
  }

  _getNavBarItems({icon}) {
    //return BottomNavigationBarItem(icon: Icon(icon), label: "$page");
    return GestureDetector(
      onTap: () {},
      child: Icon(
        icon,
        color: kPrimaryColor,
        size: 22,
      ),
    );
  }
}
