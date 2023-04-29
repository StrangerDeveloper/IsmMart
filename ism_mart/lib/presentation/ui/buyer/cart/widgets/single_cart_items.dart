import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ism_mart/api_helper/export_api_helper.dart';
import 'package:ism_mart/controllers/export_controllers.dart';
import 'package:ism_mart/models/exports_model.dart';
import 'package:ism_mart/presentation/widgets/export_widgets.dart';
import 'package:ism_mart/utils/exports_utils.dart';

class SingleCartItems extends StatelessWidget {
  const SingleCartItems({Key? key, this.cartModel, this.index})
      : super(key: key);
  final CartModel? cartModel;
  final int? index;

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();
    return _singleCartItem(
        cartModel: cartModel, index: index, controller: controller);
  }

  Widget _singleCartItem(
      {CartModel? cartModel, index, CartController? controller}) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  //mainAxisAlignment: MainAxisAlignment.center,
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
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomText(
                              title: cartModel.productModel!.name,
                              style: headline3,
                            ),
                            AppConstant.spaceWidget(height: 4),
                            CustomPriceWidget(
                                title:
                                    "${cartModel.productModel!.discountPrice}"),
                            (cartModel.productModel!.discount != null &&
                                    cartModel.productModel!.discount! > 0)
                                ? Row(
                                    children: [
                                      CustomPriceWidget(
                                        title:
                                            "${cartModel.productModel!.price}",
                                        style: bodyText1.copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: kLightColor,
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
                                  )
                                : Container(),

                            ///Product selected Features
                            if (cartModel.featuresName!.isNotEmpty)
                              Row(
                                children: [
                                  CustomText(
                                    title: "Features:",
                                    style: bodyText2,
                                  ),
                                  SizedBox(
                                    width: 170,
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
                    Align(
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
                            itemCount: controller!.moq,
                            itemBuilder: (_, index) {
                              return InkWell(
                                onTap: () async {
                                  // cartModel.quantity = "${(index + 1)}";
                                  /* await controller.updateCart(
                                      cartItemId: cartModel.id,
                                      quantity: (index + 1));*/
                                  cartModel.quantity = "${(index + 1)}";
                                  cartModel.productModel!.totalPrice =
                                      controller.totalCartAmount.value;
                                  await LocalStorageHelper.updateCartItems(
                                      cartModel: cartModel);
                                  controller.update();
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
                                    textAlign: TextAlign.center,
                                    color: int.parse(cartModel.quantity!) ==
                                            (index + 1)
                                        ? kWhiteColor
                                        : kPrimaryColor,
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
                  controller!.cartItemsList.removeAt(index);
                  LocalStorageHelper.removeSingleItem(
                      cartList: controller.cartItemsList);

                  //controller!.deleteCartItem(cartItemId: cartModel.id);
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
}


  // ProductQuantityCounter(
  //                         h: 30.0,
  //                         w: 10.0,
  //                         horiz: 0.0,
  //                         verti: 3.0,
  //                         margin: 0.0,
  //                         spaceW: 0.0,
  //                         bottomP: 15.0,
  //                         onDecrementPress: () => productController.decrement(),
  //                         onIncrementPress: () => productController.increment(),
  //                         textEditingController:
  //                             productController.quantityController,
  //                         bgColor: kPrimaryColor,
  //                         textColor: kWhiteColor,
  //                       ),
                    
