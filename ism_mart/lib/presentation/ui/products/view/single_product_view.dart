import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:ism_mart/models/exports_model.dart';
import 'package:ism_mart/presentation/ui/exports_ui.dart';
import 'package:ism_mart/presentation/widgets/export_widgets.dart';
import 'package:ism_mart/utils/exports_utils.dart';

class SingleProductView extends GetView<ProductController> {
  const SingleProductView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (Get.parameters['id'] == null) {
      return const Center(child: CircularProgressIndicator());
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
    return Scaffold(
      backgroundColor: Colors.grey[300]!,
      body: CustomScrollView(
        slivers: [
          _sliverAppBar(productModel!),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                productModel.images!.isEmpty
                    ? CustomNetworkImage(
                        imageUrl: productModel.thumbnail,
                        width: MediaQuery.of(Get.context!).size.width,
                        height: MediaQuery.of(Get.context!).size.height * 0.4,
                      )
                    : _productImages(imagesList: productModel.images!),
                _productBasicDetails(productModel: productModel),
                _productAdvanceDetails(productModel: productModel),
                if (Get.arguments["calledFor"]!.contains("customer"))
                  _buildCustomerAlsoViewed(controller.subCategoryProductList)
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

  SliverAppBar _sliverAppBar(ProductModel productModel) {
    return SliverAppBar(
      backgroundColor: kAppBarColor,
      automaticallyImplyLeading: true,
      leadingWidth: 30,
      floating: true,
      pinned: true,
      centerTitle: true,
      leading: InkWell(
        onTap: () => Get.back(),
        child: Icon(
          Icons.arrow_back_ios_new,
          size: 18,
          color: kPrimaryColor,
        ),
      ),
      title: Get.arguments["calledFor"]!.contains("seller")
          ? CustomText(
              title: "Product Details",
              style: appBarTitleSize,
            )
          : Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                        flex: 5,
                        child: SearchBar(searchText: productModel.name)),
                    AppConstant.spaceWidget(width: 10),
                    CartIcon(
                      onTap: () {
                        Get.offNamed(Routes.cartRoute,
                            preventDuplicates: false);
                      },
                      iconWidget: Icon(
                        IconlyLight.buy,
                        size: 25,
                        color: kPrimaryColor,
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
                Expanded(
                  flex: 5,
                  child: CustomText(
                    title: productModel!.name,
                    maxLines: 3,
                    style: headline3,
                  ),
                ),
                AppConstant.spaceWidget(width: 5),
                Expanded(
                  flex: 2,
                  child: CustomText(
                      title: "Stock: ${productModel.stock}",
                      color: kPrimaryColor,
                      weight: FontWeight.w600),
                ),
              ],
            ),
            AppConstant.spaceWidget(height: 10),
            //Price section
            Row(
              children: [
                CustomPriceWidget(
                  title: '${productModel.discountPrice}',
                  style: headline2,
                ),
                AppConstant.spaceWidget(width: 10),
                if (productModel.discount! > 0)
                  CustomPriceWidget(
                    title: '${productModel.price}',
                    style: headline2.copyWith(
                        decoration: TextDecoration.lineThrough,
                        fontWeight: FontWeight.w600),
                  ),
                AppConstant.spaceWidget(width: 5),
                if (productModel.discount! > 0)
                  CustomText(
                      title: "${productModel.discount}% OFF",
                      style: bodyText1.copyWith(
                          fontWeight: FontWeight.w600, color: Colors.redAccent))
              ],
            ),
            AppConstant.spaceWidget(height: 8),

            //Categories
            Row(
              children: [
                CustomText(title: "Category: ", style: bodyText2),
                CustomText(
                    title: "\t${productModel.category!.name}", style: bodyText1),
                AppConstant.spaceWidget(width: 3),
                const Icon(
                  Icons.arrow_forward_ios_sharp,
                  color: kPrimaryColor,
                  size: 12,
                ),
                AppConstant.spaceWidget(width: 3),
                CustomText(
                    title: "${productModel.subCategory!.name}",
                    style: bodyText1),
              ],
            ),
            AppConstant.spaceWidget(height: 8),
            // reviews
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(Icons.star_rate_rounded, color: Colors.amber),
                AppConstant.spaceWidget(width: 5),
                Expanded(
                  flex: 2,
                  child: Row(
                    children: [
                      CustomText(
                        title: "${productModel.rating!.toStringAsFixed(1)}",
                        style: bodyText1,
                      ),
                      //5(44)
                      const Icon(
                        Icons.arrow_forward_ios_sharp,
                        color: kPrimaryColor,
                        size: 12,
                      ),
                      AppConstant.spaceWidget(width: 5),
                      CustomText(
                        title: "${productModel.sold} Sold",
                        style: bodyText1,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            AppConstant.spaceWidget(height: 8),
            /*ListTile(
              dense: true,
              leading: const Icon(
                Icons.question_answer,
                color: kPrimaryColor,
              ),
              title: CustomText(
                  title: "5 Product Questions and Answer",
                  style: textTheme.bodyText2),
              trailing: const Icon(
                Icons.arrow_forward_ios_sharp,
                color: kPrimaryColor,
                size: 15,
              ),
            ),*/
            ListTile(
              dense: true,
              leading: const Icon(
                Icons.store,
                color: kPrimaryColor,
              ),
              title: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                        text:
                            "${productModel.sellerModel!.storeName ?? productModel.sellerModel!.user!.firstName ?? productModel.sellerModel!.user!.name ?? ""} \n",
                        style: bodyText1),
                    TextSpan(
                      text: " ${_getPositiveResponse()}  ",

                      style: bodyText2.copyWith(
                          backgroundColor: Colors.blueGrey.withOpacity(0.2)),
                    )
                  ],
                ),
              ),
              //TODO: store information
              trailing: const Icon(
                Icons.arrow_forward_ios_sharp,
                color: kPrimaryColor,
                size: 13,
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
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  title: "Description",
                  style: headline2,
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      if (productModel!.brand!.isNotEmpty)
                        TextSpan(
                            text: "Brand: ${productModel.brand},",
                            style: bodyText2),
                      TextSpan(
                          text: "Sku: ${productModel.sku}", style: bodyText2)
                    ],
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    title: productModel.description,
                    maxLines: productModel.description!.length,
                    style: bodyText2,
                  ),
                  AppConstant.spaceWidget(height: 8),
                  /* CustomText(
                    title: "Services",
                    size: 18,
                    weight: FontWeight.w600,
                  ),
                  AppConstant.spaceWidget(height: 5),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: _getServices().map((e) {
                        return Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: CustomText(
                            title: e,
                            //size: 13,
                          ),
                        );
                      }).toList()),
                  AppConstant.spaceWidget(height: 5),*/
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomerAlsoViewed(List<ProductModel> list) {
    return Obx(
      () => list.isEmpty
          ? Container()
          : controller.isLoading.isTrue
              ? CustomLoading(isItForWidget: true)
              : Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: AppConstant.getSize().height * 0.3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CustomText(
                            title: "People Also Viewed",
                            size: 18,
                            weight: FontWeight.w600,
                          ),
                          AppConstant.spaceWidget(height: 10),
                          Expanded(
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: list.length,
                              itemBuilder: (context, index) {
                                ProductModel productModel = list[index];
                                return SingleProductItems(
                                  productModel: productModel,
                                  onTap: () {
                                    Get.offNamed('/product/${productModel.id}',
                                        preventDuplicates: false,
                                        arguments: {"calledFor": "customer"});
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
    );
  }

  String _getPositiveResponse() {
    int min = 70;
    int max = 100;

    var rnd = new Random();
    int r = min + rnd.nextInt(max - min);

    return " $r% Positive Response  ";
  }

  List<String> _getServices() {
    return <String>[
      "• Free shipping apply to all orders over shipping \$100",
      "• Guaranteed 100% organic from natural products",
      "• 7 Days returns money back guarantee",
      "• 14 days easy Return",
      "• Cash on Delivery Available",
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
                CustomPriceWidget(title: "${productModel.discountPrice}"),
                if (productModel.discount! > 0)
                  Row(
                    children: [
                      CustomPriceWidget(
                          title: "${productModel.price}",
                          style: bodyText1.copyWith(
                              decoration: TextDecoration.lineThrough)),
                      AppConstant.spaceWidget(width: 5),
                      CustomText(
                          title: "${productModel.discount}% OFF",
                          style: bodyText2.copyWith(color: Colors.redAccent))
                    ],
                  ),
              ],
            ),
          ),
          productModel.colors == null
              ? Container()
              : Column(
                  children: [
                    const StickyLabel(text: "Colors"),
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
                    const StickyLabel(text: "Sizes"),
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
            title: label, style: bodyText1.copyWith(color: Colors.white)),
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
          bgColor: kPrimaryColor,
          textColor: kWhiteColor,
        ),
      ],
    );
  }

  Widget _buildBuyNowAndCartBtn({ProductModel? productModel}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        /*CustomButton(
          onTap: () => LocalStorageHelper.deleteAllCart(),
          text: "Buy Now",
          color: Colors.yellow[800],
          width: 120,
          height: 35,
        ),*/
        CustomButton(
          onTap: () {
            controller.addItemToCart(product: productModel);
            Get.back();
          },
          text: "Add to Cart",
          width: 320,
          height: 40,
        ),
      ],
    );
  }

  _footerBottomBar() {
    return BottomAppBar(
      elevation: 20,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //_getNavBarItems(icon: Icons.store,),
            ProductQuantityCounter(
              onDecrementPress: () => controller.decrement(),
              onIncrementPress: () => controller.increment(),
              textEditingController: controller.quantityController,
              bgColor: kPrimaryColor,
              textColor: kWhiteColor,
            ),
            CustomButton(
              onTap: () =>
                  showVariationBottomSheet(productModel: controller.state),
              text: "Next",
              width: 100,
              height: 40,
            ),
            //_buildBuyNowAndCartBtn(),
          ],
        ),
      ),
    );
  }

}
