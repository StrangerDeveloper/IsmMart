import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ism_mart/presentation/widgets/export_widgets.dart';
import 'package:ism_mart/utils/exports_utils.dart';

class StickyLabelWithViewMoreOption extends StatelessWidget {
  final String? title;
  final Color? textColor;
  final double? textSize;
  final GestureTapCallback? onTap;

  const StickyLabelWithViewMoreOption({
    Key? key,
    required this.title,
    this.textColor,
    this.textSize = 17,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        StickyLabel(
          text: title!,
          style: headline3,
        ),
        GestureDetector(
          onTap: onTap,
          child:  Padding(
            padding: EdgeInsets.only(right: kDefaultPadding),
            child: StickyLabel(
              text: "see_all".tr,
              style: bodyText1,
            ),
          ),
        ),
      ],
    );
  }
}
