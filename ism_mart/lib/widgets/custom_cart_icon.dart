import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:ism_mart/exports/export_controllers.dart';
import 'package:ism_mart/exports/export_widgets.dart';
import 'package:ism_mart/exports/exports_utils.dart';

class CartIcon extends StatelessWidget {
  const CartIcon({Key? key,  this.iconWidget, required this.onTap, this.badgeWidth, this.badgeHeight})
      : super(key: key);

  final Widget? iconWidget;
  final GestureTapCallback? onTap;
  final double? badgeWidth;
  final double? badgeHeight;

  @override
  Widget build(BuildContext context) {

    return

      InkWell(
      onTap: onTap,
      child: Stack(
        children: [
         iconWidget?? Icon(
           IconlyLight.buy,
            color: baseController.currentPage == 2 ? kPrimaryColor : kLightColor,
            size: 25,
          ),
          Obx(
            () => baseController.cartCount.value <= 0
                ? Container()
                : Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      alignment: Alignment.center,
                      height: badgeHeight ?? 14,
                      width: badgeWidth ?? 14,
                      //padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                          color: kOrangeColor,
                          borderRadius: BorderRadius.circular(15)),
                      child: CustomText(
                        title: "${baseController.cartCount.value}",
                        size: 10,
                        color: kWhiteColor,
                        maxLines: 1,
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
