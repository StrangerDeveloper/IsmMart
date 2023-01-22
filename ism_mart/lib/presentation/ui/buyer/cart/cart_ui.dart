import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:ism_mart/api_helper/export_api_helper.dart';
import 'package:ism_mart/controllers/export_controllers.dart';
import 'package:ism_mart/models/exports_model.dart';
import 'package:ism_mart/presentation/widgets/export_widgets.dart';
import 'package:ism_mart/utils/exports_utils.dart';
import 'package:ism_mart/utils/languages/translations_key.dart' as langKey;

//final cartController = Get.find<CartController>();
class CartUI extends GetView<CartController> {
  const CartUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (authController.isSessionExpired!) {
      controller.fetchCartItemsFromLocal();
    } else {
      controller.fetchCartItems();
    }

    return controller.obx((state) {
      if (state == null) {
        return noDataFound();
      }
      if (state is List<CartModel> && state.isEmpty) {
        //controller.fetchCartItemsFromLocal();
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
          backgroundColor: kAppBarColor,
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              buildSvgLogo(),
              AppConstant.spaceWidget(width: 10),
              CustomText(
                title: langKey.myCart.tr,
                style: appBarTitleSize,
                //style: textTheme.headline6!.copyWith(color: kWhiteColor),
              ),
            ],
          ),
        ),
        body: NoDataFoundWithIcon(
          icon: IconlyLight.buy,
          title: langKey.emptyCart.tr,
          subTitle: langKey.emptyCartMsg.tr,
        ),
      ),
    );
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
      backgroundColor: kAppBarColor,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: false,
        titlePadding: const EdgeInsets.symmetric(horizontal: 16),
        title: Row(
          children: [
            buildSvgLogo(),
            AppConstant.spaceWidget(width: 10),
            Obx(
              () => CustomText(
                  title: 'My Cart (${controller.totalQtyCart.value} items)',
                  style: appBarTitleSize,),
            ),
          ],
        ),
      ),
    );
  }


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
  }

  Widget _singleCartItem({CartModel? cartModel, index}) {
    return InkWell(
      onTap: () {
        Get.toNamed('/product/${cartModel.productId}',
            preventDuplicates: false, arguments: {"calledFor": "seller"});
      },
      child: Card(
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
                                cartModel!.productModel!.thumbnail ??
                                    AppConstant.defaultImgUrl)),
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
                                style: headline3,
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
                                          decoration:
                                              TextDecoration.lineThrough),
                                    ),
                                    AppConstant.spaceWidget(width: 5),
                                    CustomText(
                                        title:
                                            "${cartModel.productModel!.discount!}% OFF",
                                        style: bodyText2.copyWith(
                                            fontWeight: FontWeight.w700,
                                            color: Colors.red))
                                  ],
                                ),
                            ],
                          ),
                        ),
                      ),
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
                                horizontal: 11.0, vertical: 5),
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
                                  style: headline3
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
                          duration: const Duration(milliseconds: 400),
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
                                      debugPrint(
                                          ">>>Sessions: ${authController.isSessionExpired!}");
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
                                    alignment: Alignment.center,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 5, vertical: 3),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12.0, vertical: 5),
                                    decoration: int.parse(
                                                cartModel.quantity!) ==
                                            (index + 1)
                                        ? BoxDecoration(
                                            color: kPrimaryColor,
                                            border:
                                                Border.all(color: kDarkColor),
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          )
                                        : BoxDecoration(
                                            color: kWhiteColor,
                                            border:
                                                Border.all(color: kDarkColor),
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                    child: CustomText(
                                      title: "${index + 1}",
                                      textAlign: TextAlign.center,
                                      color: int.parse(cartModel.quantity!) ==
                                              (index + 1)
                                          ? kWhiteColor
                                          : kDarkColor,
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
                    controller.update();
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
      ),
    );
  }

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
                    style: headline3,
                  ),
                  CustomPriceWidget(
                      title: "${controller.totalCartAmount.value}"),
                ],
              ),
            ),
            AppConstant.spaceWidget(height: 10),
            CustomButton(
              onTap: () => Get.toNamed(Routes.checkOutRoute),
              text: "Proceed To Checkout",
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
