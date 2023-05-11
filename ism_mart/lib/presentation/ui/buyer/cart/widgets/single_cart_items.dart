import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ism_mart/api_helper/export_api_helper.dart';
import 'package:ism_mart/controllers/export_controllers.dart';
import 'package:ism_mart/models/exports_model.dart';
import 'package:ism_mart/presentation/widgets/export_widgets.dart';
import 'package:ism_mart/utils/exports_utils.dart';
import 'package:ism_mart/utils/languages/translations_key.dart' as langKey;

class SingleCartItems extends StatelessWidget {
  const SingleCartItems(
      {Key? key, this.cartModel, this.index, this.calledFromCheckout = false})
      : super(key: key);
  final CartModel? cartModel;
  final int? index;
  final bool? calledFromCheckout;

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();
    return InkWell(
      onTap: () {
        Get.toNamed('/product/${cartModel!.productId!}',
            arguments: {"calledFor": "seller"});
      },
      child: _singleCartItem(
          cartModel: cartModel, index: index, controller: controller),
    );
  }

  Widget _singleCartItem(
      {CartModel? cartModel, index, CartController? controller}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          CustomGreyBorderContainer(
            //elevation: 0,
            borderColor: kWhiteColor,
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              children: [
                Row(
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
                      flex: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              width: AppResponsiveness.width * 0.6,
                              child: CustomText(
                                title: cartModel.productModel!.name,
                                style: headline3,
                                maxLines: 3,
                              ),
                            ),
                            AppConstant.spaceWidget(height: 2),
                            CustomText(
                              title:
                                  "${langKey.availableStock.tr}: ${cartModel.productModel!.stock}",
                              size: 10,
                            ),
                            AppConstant.spaceWidget(height: 2),
                            Row(
                              children: [
                                CustomText(
                                  title: "${langKey.itemPrice.tr}: ",
                                  style: bodyText2.copyWith(color: kLightColor),
                                ),
                                CustomPriceWidget(
                                  title:
                                      "${cartModel.productModel!.discountPrice}",
                                  style: bodyText2.copyWith(color: kLightColor),
                                ),
                              ],
                            ),
                            AppConstant.spaceWidget(height: 4),
                            CustomPriceWidget(
                              title: "${cartModel.itemPrice}",
                              style: bodyText1,
                            ),

                            ///Product selected Features
                            if (cartModel.featuresName!.isNotEmpty)
                              Row(
                                children: [
                                  CustomText(
                                    title: "${langKey.features.tr}:",
                                    style: bodyText2,
                                  ),
                                  SizedBox(
                                    width: AppResponsiveness.width * 0.5,
                                    height: 30,
                                    child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        shrinkWrap: true,
                                        itemCount:
                                            cartModel.featuresName?.length,
                                        itemBuilder: (_, index) {
                                          String name =
                                              cartModel.featuresName![index];
                                          return Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 3.0, vertical: 5),
                                            child: CustomGreyBorderContainer(
                                                hasShadow: false,
                                                //borderColor: kWhiteColor,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 5,
                                                        vertical: 2),
                                                child: CustomText(
                                                  title: name,
                                                  style: caption.copyWith(
                                                      color: kPrimaryColor),
                                                )),
                                          );
                                        }),
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                ///Qty widget
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    calledFromCheckout!
                        ? Align(
                            alignment: Alignment.bottomRight,
                            child: InkWell(
                              onTap: () {
                                cartModel.onQuantityClicked =
                                    !cartModel.onQuantityClicked!;
                                controller!.cartItemsList.refresh();
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
                                child: CustomText(
                                  title: cartModel.quantity!,
                                  size: 16,
                                  color: kDarkColor,
                                  weight: FontWeight.bold,
                                ),
                              ),
                            ),
                          )
                        : ProductQuantityCounter(
                            //width: 140,
                            height: 30,
                            margin: const EdgeInsets.symmetric(
                                vertical: 2, horizontal: 2),
                            padding: const EdgeInsets.symmetric(
                                vertical: 2, horizontal: 2),
                            quantity: cartModel.quantity,
                            onIncrementPress: () async {
                              int quantity = int.parse(cartModel.quantity!);
                              if (quantity >= cartModel.productModel!.stock!)
                                return;
                              cartModel.quantity = "${quantity + 1}";
                              cartModel.productModel!.totalPrice =
                                  controller!.totalCartAmount.value;
                              cartModel.itemPrice = (quantity + 1) *
                                  cartModel.productModel!.discountPrice!;
                              await LocalStorageHelper.updateCartItems(
                                  cartModel: cartModel);
                              controller.update();
                            },
                            onDecrementPress: () async {
                              int quantity = int.parse(cartModel.quantity!);
                              if (quantity <= 1) return;
                              cartModel.quantity = "${quantity - 1}";
                              cartModel.productModel!.totalPrice =
                                  controller!.totalCartAmount.value;
                              cartModel.itemPrice = ((quantity - 1) *
                                  cartModel.productModel!.discountPrice!);

                              await LocalStorageHelper.updateCartItems(
                                  cartModel: cartModel);
                              controller.update();
                            },
                          ),
                  ],
                ),
                AppConstant.spaceWidget(height: 5),
              ],
            ),
          ),
          if (!calledFromCheckout!)
            Positioned(
              right: 5,
              top: 5,
              child: CustomActionIcon(
                onTap: () {
                  controller!.cartItemsList.removeAt(index);
                  LocalStorageHelper.removeSingleItem(
                      cartList: controller.cartItemsList);

                  //controller!.deleteCartItem(cartItemId: cartModel.id);
                },
                height: 20,
                hasShadow: false,
                icon: Icons.close_rounded,
                bgColor: kRedColor.withOpacity(0.2),
                iconColor: kRedColor,
              ),
            ),
        ],
      ),
    );
  }
}
