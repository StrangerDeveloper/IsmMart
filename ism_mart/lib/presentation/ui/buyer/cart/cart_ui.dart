import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:ism_mart/api_helper/export_api_helper.dart';
import 'package:ism_mart/controllers/export_controllers.dart';
import 'package:ism_mart/models/exports_model.dart';
import 'package:ism_mart/presentation/widgets/export_widgets.dart';
import 'package:ism_mart/utils/exports_utils.dart';

//final cartController = Get.find<CartController>();
class CartUI extends GetView<CartController> {
  const CartUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint(
        ">>>SingleProduct>>GetCurrentUser: ${ApiConstant.SESSION_EXPIRED}: ${authController.isSessionExpired}");

    if (authController.isSessionExpired!) {
      controller.fetchCartItemsFromLocal();
    } else
      controller.fetchCartItems();
    return controller.obx((state) {
      if (state == null) {
        return noDataFound();
      }
      if (state is List<CartModel> && state.isEmpty) {
        return noDataFound();
      }
      return _build(listData: state);
    }, onLoading: CustomLoading(isDarkMode: Get.isDarkMode));
  }

  Widget noDataFound() {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.grey[100]!,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: CustomText(
          title: 'cart'.tr,
          weight: FontWeight.w700,
          size: 20,
            color: kWhiteColor
          //style: textTheme.headline6!.copyWith(color: kWhiteColor),
        ),
      ),
      body:


      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
                color: kPrimaryColor.withOpacity(0.22), shape: BoxShape.circle),
            child: Icon(
              IconlyLight.buy,
              size: 50,
              color: kPrimaryColor,
            ),
          ),

          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
            children: [
              TextSpan(text: '\n${"empty_cart".tr}\n', style: textTheme.headline6),
              TextSpan(text: "empty_cart_message".tr, style: textTheme.bodySmall)
            ]
          ),),
        ],
      ),
    ));
  }

  Widget _build({List<CartModel>? listData}) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[100]!,
        body: CustomScrollView(
          slivers: [
            _sliverAppBar(),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  _buildCartItemSection(cartItemsList: listData),
                  //_subTotalDetails(),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar:
            _checkOutBottomBar(items: controller.cartItemsList),
      ),
    );
  }

  SliverAppBar _sliverAppBar() {
    return SliverAppBar(
      expandedHeight: 14.0,
      floating: true,
      pinned: false,
      automaticallyImplyLeading: false,
      backgroundColor: kPrimaryColor,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: false,
        titlePadding: const EdgeInsets.symmetric(horizontal: 16),
        title: Obx(
          () => CustomText(
            title: 'cart (${controller.totalQtyCart.value} items)',
              style: textTheme.headline6!.copyWith(color: kWhiteColor)),
          ),
        ),

    );
  }

/*  SliverAppBar _sliverAppBarLocation() {
    return SliverAppBar(
      //expandedHeight: 80.0,
      floating: false,
      pinned: true,
      automaticallyImplyLeading: false,
      backgroundColor: kWhiteColor,
      title: Container(
        height: 40.0,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: kFixPadding),
        decoration: BoxDecoration(
          color: kWhiteColor,
          border: Border.all(color: kLightGreyColor),
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: Row(
          children: const [
            Icon(Icons.location_on_rounded, color: kPrimaryColor),
            Padding(
              padding: EdgeInsets.only(left: 4.0),
              child: CustomText(
                title: "Deliver To: location goes here",
                style: TextStyle(
                  color: kLightColor,
                  fontSize: 12.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }*/

  Widget _buildCartItemSection({List<CartModel>? cartItemsList}) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: cartItemsList!.length,
      itemBuilder: (context, index) {
        CartModel cartModel = cartItemsList[index];
        return _singleCartItem(cartModel: cartModel, index: index);
      },
    );

    /*Obx(
      () => cartItemsList!.isEmpty
          ? const NoDataFound(text: "No Cart Item Found")
          : ,
    );*/
  }

  Widget _singleCartItem({CartModel? cartModel, index}) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: CircleAvatar(
                          radius: 40,
                          backgroundImage: NetworkImage(
                              cartModel!.productModel!.thumbnail ?? AppConstant.defaultImgUrl)),
                    ),
                    AppConstant.spaceWidget(width: 5),
                    Expanded(
                      flex: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              title: cartModel.productModel!.brand,
                              weight: FontWeight.w600,
                            ),
                            AppConstant.spaceWidget(height: 5),
                            CustomText(
                              title: cartModel.productModel!.name,
                              weight: FontWeight.bold,
                              size: 16,
                            ),
                            AppConstant.spaceWidget(height: 8),
                            CustomPriceWidget(
                              title:
                                  "${cartModel.productModel!.discountPrice!}",
                            ),
                            if (cartModel.productModel!.discount != null &&
                                cartModel.productModel!.discount! > 0)
                              Row(
                                children: [
                                  CustomPriceWidget(
                                    title: "${cartModel.productModel!.price}",
                                    style: bodyText1.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: kLightColor,
                                        decoration: TextDecoration.lineThrough),
                                  ),
                                  AppConstant.spaceWidget(width: 5),
                                  CustomText(
                                      title:
                                          "${cartModel.productModel!.discount!}% OFF",
                                      style: bodyText3.copyWith(
                                          fontWeight: FontWeight.w700,
                                          color: Colors.red))
                                ],
                              ),
                          ],
                        ),
                      ),
                    ),
                    /*Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [

                        InkWell(
                          onTap: () {
                            cartModel.onQuantityClicked =
                                !cartModel.onQuantityClicked!;
                            controller.update();
                          },
                          child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12.0, vertical: 5),
                              decoration: BoxDecoration(
                                color: kWhiteColor,
                                border: Border.all(
                                    color: cartModel.onQuantityClicked!
                                        ? kDarkColor
                                        : kLightColor),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Row(
                                children: [
                                  CustomText(
                                    title: cartModel.quantity!,
                                    size: 16,
                                    color: kDarkColor,
                                    weight: FontWeight.bold,
                                  ),
                                  AppConstant.spaceWidget(width: 5),
                                  Icon(
                                    cartModel.onQuantityClicked!
                                        ? Icons.keyboard_arrow_up
                                        : Icons.keyboard_arrow_down,
                                    size: 20,
                                    color: cartModel.onQuantityClicked!
                                        ? kDarkColor
                                        : kLightColor,
                                  ),
                                ],
                              )),
                        ),
                      ],
                    ),*/
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        cartModel.onQuantityClicked =
                            !cartModel.onQuantityClicked!;
                        controller.update();
                      },
                      child: Container(
                          width: 60,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 5),
                          decoration: BoxDecoration(
                            color: kWhiteColor,
                            border: Border.all(
                                color: cartModel.onQuantityClicked!
                                    ? kDarkColor
                                    : kLightColor),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Row(
                            children: [
                              CustomText(
                                title: cartModel.quantity!,
                                size: 16,
                                color: kDarkColor,
                                weight: FontWeight.bold,
                              ),
                              AppConstant.spaceWidget(width: 5),
                              Icon(
                                cartModel.onQuantityClicked!
                                    ? Icons.keyboard_arrow_up
                                    : Icons.keyboard_arrow_down,
                                size: 20,
                                color: cartModel.onQuantityClicked!
                                    ? kDarkColor
                                    : kLightColor,
                              ),
                            ],
                          )),
                    ),
                  ],
                ),
                AppConstant.spaceWidget(height: 5),
                cartModel.onQuantityClicked!
                    ? AnimatedContainer(
                        duration: const Duration(milliseconds: 1500),
                        curve: Curves.fastOutSlowIn,
                        width: double.infinity,
                        height: 40,
                        child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: controller.moq,
                            itemBuilder: (_, index) {
                              return InkWell(
                                onTap: () async {
                                  if (authController.isSessionExpired!) {
                                    cartModel.quantity = "${(index + 1)}";
                                    await LocalStorageHelper.updateCartItems(
                                        cartModel: cartModel);
                                    controller.update();
                                  } else {
                                    await controller.updateCart(
                                        cartItemId: cartModel.id,
                                        quantity: (index + 1));
                                  }
                                },
                                child: Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 3),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12.0, vertical: 5),
                                  decoration: int.parse(cartModel.quantity!) ==
                                          (index + 1)
                                      ? BoxDecoration(
                                          color: kPrimaryColor,
                                          border: Border.all(color: kDarkColor),
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        )
                                      : BoxDecoration(
                                          color: kWhiteColor,
                                          border: Border.all(color: kDarkColor),
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                  child: CustomText(
                                    title: "${index + 1}",
                                    weight: FontWeight.w600,
                                  ),
                                ),
                              );
                            }),
                      )
                    : Container(),
              ],
            ),
            Positioned(
              right: 0,
              child: CustomActionIcon(
                onTap: () {
                  if (authController.isSessionExpired!) {
                    controller.cartItemsList.removeAt(index);
                    LocalStorageHelper.removeSingleItem(
                        cartList: controller.cartItemsList);
                  } else {
                    controller.deleteCartItem(cartItemId: cartModel.id);
                  }
                },
                hasShadow: false,
                icon: Icons.close_rounded,
                bgColor: kRedColor.withOpacity(0.2),
                iconColor: kRedColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /* Widget _subTotalDetails() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(text: "Subtotal ", style: bodyText1),
                        TextSpan(
                            text: "(${controller.totalQtyCart.value} items)",
                            style: caption),
                      ],
                    ),
                  ),
                  _buildPrice(
                      title: controller.totalCartAmount.value,
                      style: bodyText1),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(title: "Shipping Fee", style: bodyText1),
                  _buildPrice(title: 169.0, style: bodyText1),
                ],
              ),
              kSmallDivider,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(text: "Total ", style: headline5),
                        TextSpan(text: "(Inclusive of GST)", style: caption),
                      ],
                    ),
                  ),
                  _buildPrice(
                      title: (controller.totalCartAmount.value + 169.0)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }*/

  _checkOutBottomBar({List<CartModel>? items}) {
    return BottomAppBar(
      elevation: 22,
      child: Container(
        height: 110,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    title: "${controller.totalQtyCart.value} items",
                    style: headline6,
                  ),
                  CustomPriceWidget(
                      title: "${controller.totalCartAmount.value}"),
                ],
              ),
            ),
            AppConstant.spaceWidget(height: 10),
            CustomButton(
              onTap: () => Get.toNamed(Routes.checkOutRoute),
              text: "Proceed to Checkout",
              //width: 150,
              color: kPrimaryColor,
              height: 40,
            ),
            //_buildBuyNowAndCartBtn(),
          ],
        ),
      ),
    );
  }
}
