import 'package:flutter/material.dart';
import 'package:ism_mart/exports/export_presentation.dart';
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
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
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
                    size: 15,
                  ),
                  isPriceWidget!
                      ? CustomPriceWidget(title: "$value")
                      : CustomText(
                          title: "$value",
                          weight: FontWeight.bold,
                          textAlign: TextAlign.center,
                          size: 20,
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

class CustomOrderStatsItem2 extends StatelessWidget {
  final GestureTapCallback? onTap;
  final Color? iconColor;
  final IconData? icon;
  final String? title;
  final num? value;
  final bool? isPriceWidget;

  const CustomOrderStatsItem2(
      {Key? key,
      this.onTap,
      this.iconColor,
      this.icon,
      this.title,
      this.value,
      this.isPriceWidget = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 70,
          padding: const EdgeInsets.fromLTRB(8, 4, 4, 4),
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                    color: iconColor!.withOpacity(0.15),
                    shape: BoxShape.circle),
                child: Icon(
                  icon,
                  size: 22,
                  color: iconColor,
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText(
                      title: title,
                      weight: FontWeight.w600,
                      textAlign: TextAlign.center,
                      size: 15,
                    ),
                    isPriceWidget!
                        ? CustomPriceWidget(title: "$value")
                        : CustomText(
                            title: "$value",
                            weight: FontWeight.bold,
                            textAlign: TextAlign.center,
                            size: 20,
                          ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
