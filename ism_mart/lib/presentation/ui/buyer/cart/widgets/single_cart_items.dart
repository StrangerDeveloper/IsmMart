import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ism_mart/api_helper/export_api_helper.dart';
import 'package:ism_mart/controllers/export_controllers.dart';
import 'package:ism_mart/models/exports_model.dart';
import 'package:ism_mart/presentation/widgets/export_widgets.dart';
import 'package:ism_mart/utils/exports_utils.dart';

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
    return _singleCartItem(
        cartModel: cartModel, index: index, controller: controller);
  }

  Widget _singleCartItem(
      {CartModel? cartModel, index, CartController? controller}) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Stack(
          children: [
            Row(
              //crossAxisAlignment: CrossAxisAlignment.end,
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
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CustomText(
                              title: cartModel.productModel!.name,
                              style: headline3,
                            ),
                            AppConstant.spaceWidget(width: 4),
                            CustomText(
                              title:
                                  "Available Stock: ${cartModel.productModel!.stock}",
                              size: 10,
                            ),
                          ],
                        ),

                        AppConstant.spaceWidget(height: 4),
                        Row(
                          children: [
                            CustomText(
                              title: "Item Price: ",
                              style: bodyText2.copyWith(color: kLightColor),
                            ),
                            CustomPriceWidget(
                              title: "${cartModel.productModel!.discountPrice}",
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
                                title: "Features:",
                                style: bodyText2,
                              ),
                              SizedBox(
                                width: 170,
                                height: 30,
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    itemCount: cartModel.featuresName?.length,
                                    itemBuilder: (_, index) {
                                      String name =
                                          cartModel.featuresName![index];
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 3.0, vertical: 5),
                                        child: CustomGreyBorderContainer(
                                            hasShadow: false,
                                            //borderColor: kWhiteColor,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 5, vertical: 2),
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
            Positioned(
              right: 0,
              bottom: 30,
              child: calledFromCheckout!
                  ? Container(
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
                        if (quantity >= cartModel.productModel!.stock!) return;
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
            ),
          ],
        ),
      ),
    );
  }
}
