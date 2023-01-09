import 'package:flutter/material.dart';
import 'package:ism_mart/presentation/widgets/export_widgets.dart';
import 'package:ism_mart/utils/exports_utils.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.onTap,
    required this.text,
    this.textStyle,
    this.width = double.maxFinite,
    this.height = 60,
    this.color,
  }) : super(key: key);

  final GestureTapCallback? onTap;
  final String? text;
  final TextStyle? textStyle;
  final double? width, height;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap!,
      child: Container(
        decoration: BoxDecoration(
            color: color ?? kPrimaryColor,
            borderRadius: BorderRadius.circular(5)),
        alignment: Alignment.center,
        width: width,
        height: height,
        //padding: const EdgeInsets.symmetric(vertical: 16),
        child: CustomText(
          title: text!,
          color: Colors.white,
          style:
              textStyle ?? headline3.copyWith(color: kWhiteColor),
        ),
      ),
    );
  }
}
