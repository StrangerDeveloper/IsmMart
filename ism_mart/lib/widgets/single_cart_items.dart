import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ism_mart/screens/cart/cart_viewmodel.dart';
import 'package:ism_mart/exports/export_widgets.dart';
import 'package:ism_mart/exports/exports_utils.dart';
import 'package:ism_mart/helper/languages/translations_key.dart' as langKey;

class SingleCartItems extends StatelessWidget {
  SingleCartItems({
    this.index,
    this.calledFromCheckout = false
  });

  final int? index;
  final bool? calledFromCheckout;

  final CartViewModel viewModel = Get.find();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(Routes.singleProductDetails, arguments: [{
          "calledFor": "seller",
          "productID": "${viewModel.cartItemsList[index!].productId}"
        }]);
      },
      child: _singleCartItem(),
    );
  }

  Padding _singleCartItem() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          CustomGreyBorderContainer(
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
                                viewModel.cartItemsList[index!].productModel!.thumbnail
                                    ?? AppConstant.defaultImgUrl)),
                      ),
                      AppConstant.spaceWidget(width: 5),
                      productDetailsAndPrice(),
                    ],
                  ),
                  productQuantityWidget(),
                  AppConstant.spaceWidget(height: 5),
                ],
              ),
            ),
          if (!calledFromCheckout!)
            deleteItemIcon(),
        ],
      ),
    );
  }

  Expanded productDetailsAndPrice(){
    return Expanded(
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
                title: viewModel.cartItemsList[index!].productModel?.name ?? '',
                style: headline3,
                maxLines: 3,
              ),
            ),
            AppConstant.spaceWidget(height: 2),
            CustomText(
              title: "${langKey.availableStock.tr}: ${viewModel.cartItemsList[index!].productModel!.stock}",
              size: 10,
            ),
            itemPriceText(),
            productTotalPriceText(),

            ///Product Features
            if (viewModel.cartItemsList[index!].featuresName!.isNotEmpty)
              productFeaturesList(),
          ],
        ),
      ),
    );
  }

  Row productFeaturesList(){
    return Row(
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
              itemCount: viewModel.cartItemsList[index!].featuresName?.length,
              itemBuilder: (_, index) {
                String name = viewModel.cartItemsList[index].featuresName![index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 3.0, vertical: 5),
                  child: CustomGreyBorderContainer(
                      hasShadow: false,
                      //borderColor: kWhiteColor,
                      padding: const EdgeInsets.symmetric(
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
    );
  }

  productQuantityWidget(){
    return Obx(() => Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        calledFromCheckout!
            ? Align(
          alignment: Alignment.bottomRight,
          child: InkWell(
            onTap: () {
              viewModel.cartItemsList[index!].onQuantityClicked =
              !viewModel.cartItemsList[index!].onQuantityClicked!;
              viewModel.cartItemsList.refresh();
            },
            child: Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 12.0, vertical: 5),
              decoration: BoxDecoration(
                color: kWhiteColor,
                border: Border.all(
                    color: viewModel.cartItemsList[index!].onQuantityClicked!
                        ? kDarkColor
                        : kLightColor),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: CustomText(
                title: viewModel.cartItemsList[index!].quantity!,
                size: 16,
                color: kDarkColor,
                weight: FontWeight.bold,
              ),
            ),
          ),
        )
            : ProductQuantityCounter(
          quantity: viewModel.cartItemsList[index!].quantity,
          onIncrementPress: () async {
            await viewModel.incrementQuantity(index!);
          },
          onDecrementPress: () async {
            await viewModel.decrementQuantity(index!);
          },
        ),
      ],
    ),
    );
  }

  Positioned deleteItemIcon(){
    return Positioned(
      right: 5,
      top: 5,
      child: CustomActionIcon(
        onTap: () {
          viewModel.deleteItem(index!);
        },
        height: 20,
        hasShadow: false,
        icon: Icons.close_rounded,
        bgColor: kRedColor.withOpacity(0.2),
        iconColor: kRedColor,
      ),
    );
  }

  Padding itemPriceText(){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          CustomText(
            title: "${langKey.itemPrice.tr}: ",
            style: bodyText2.copyWith(color: kLightColor),
          ),
          CustomPriceWidget(
            title: "${viewModel.cartItemsList[index!].productModel!.discountPrice}",
            style: bodyText2.copyWith(color: kLightColor),
          ),
        ],
      ),
    );
  }

  Row productTotalPriceText(){
    return Row(
      children: [
        CustomText(
            title: 'Total: ',
          style: bodyText1,
        ),
        CustomPriceWidget(
          title: "${viewModel.cartItemsList[index!].itemPrice}",
          style: bodyText1,
        ),
      ],
    );
  }
}