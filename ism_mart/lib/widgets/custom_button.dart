import 'package:flutter/material.dart';
import 'package:ism_mart/widgets/export_widgets.dart';
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
          style: textStyle ?? headline3.copyWith(color: kWhiteColor),
        ),
      ),
    );
  }
}

class CustomTextBtn extends StatelessWidget {
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double height;
  final double width;
  final Widget child;
  final double? radius;
  final EdgeInsetsGeometry? padding;
  final MaterialTapTargetSize? tapTargetSize;
  final BorderSide? side;
  final OutlinedBorder? shape;

  const CustomTextBtn({
    Key? key,
    this.height = 40,
    this.width = double.infinity,
    this.onPressed,
    this.backgroundColor = kPrimaryColor,
    this.foregroundColor = Colors.white,
    required this.child,
    this.radius,
    this.padding,
    this.tapTargetSize,
    this.side,
    this.shape,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        padding: padding,
        tapTargetSize: tapTargetSize,
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        minimumSize: Size(width, height),
        side: side,
        shape: (radius == null)
            ? shape
            : RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius!),
        ),
      ),
      child: child,
    );
  }
}
