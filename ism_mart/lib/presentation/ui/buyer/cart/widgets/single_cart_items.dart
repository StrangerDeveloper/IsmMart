import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: CircleAvatar(
                          radius: 40,
                          backgroundImage: NetworkImage(
                              cartModel!.productModel!.thumbnail!)),
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
                              title: cartModel.productModel!.name,
                              style: headline3,
                            ),
                            AppConstant.spaceWidget(height: 4),
                            CustomPriceWidget(
                                title:
                                    "${cartModel.productModel!.discountPrice}"),
                            if (cartModel.productModel!.discount != null &&
                                cartModel.productModel!.discount! > 0)
                              Row(
                                children: [
                                  CustomPriceWidget(
                                    title:"${cartModel.productModel!.price}",
                                    style: bodyText1.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: kLightColor,
                                        decoration: TextDecoration.lineThrough),
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
                    Align(
                      alignment: Alignment.bottomRight,
                      child: InkWell(
                        onTap: () {
                          cartModel.onQuantityClicked =
                              !cartModel.onQuantityClicked!;
                          controller!.cartItemsList.refresh();
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
                                  await controller.updateCart(
                                      cartItemId: cartModel.id,
                                      quantity: (index + 1));
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
                                        (index + 1) ? kWhiteColor: kPrimaryColor,
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
                  /*controller.cartItemsList.removeAt(index);
                  LocalStorageHelper.removeSingleItem(
                      cartList: controller.cartItemsList);*/

                  controller!.deleteCartItem(cartItemId: cartModel.id);
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
