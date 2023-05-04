import 'package:flutter/material.dart';
import 'package:ism_mart/presentation/export_presentation.dart';
import 'package:ism_mart/utils/exports_utils.dart';

class CustomOrderStatsItem extends StatelessWidget {
  const CustomOrderStatsItem(
      {Key? key,
      this.onTap,
      this.iconColor,
      this.icon,
      this.title,
      this.value,
      this.isPriceWidget = false})
      : super(key: key);
  final GestureTapCallback? onTap;
  final Color? iconColor;
  final IconData? icon;
  final String? title;
  final num? value;
  final bool? isPriceWidget;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        decoration: BoxDecoration(
          color: kWhiteColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: kLightGreyColor),
          boxShadow: [
            BoxShadow(
              color: kPrimaryColor.withOpacity(0.2),
              offset: Offset(0, 1),
              blurRadius: 8,
            )
          ],
        ),
        child: Row(
          children: [
            /// icon with colorful bg
            Container(
              width: 45,
              height: 45,
              decoration: BoxDecoration(
                  color: iconColor!.withOpacity(0.15), shape: BoxShape.circle),
              child: Icon(
                icon,
                size: 25,
                color: iconColor,
              ),
            ),

            AppConstant.spaceWidget(width: 10),
            Flexible(
                //flex: 4,
                child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomText(
                    title: title,
                    weight: FontWeight.w600,
                    textAlign: TextAlign.start,
                    size: 13,
                  ),
                  isPriceWidget!
                      ? CustomPriceWidget(title: "$value")
                      : CustomText(
                          title: "$value",
                          weight: FontWeight.bold,
                          textAlign: TextAlign.center,
                          size: 16,
                        ),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}
