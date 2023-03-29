import 'package:flutter/material.dart';
import 'package:ism_mart/utils/constants.dart';

class CustomGreyBorderContainer extends StatelessWidget {
  const CustomGreyBorderContainer({Key? key,
    this.borderColor,
    this.bgColor,
    required this.child,
    this.width,
    this.hasShadow = true,
    this.padding,
    this.height})
      : super(key: key);
  final Color? borderColor, bgColor;
  final Widget? child;
  final double? width, height;
  final EdgeInsetsGeometry? padding;
  final bool? hasShadow;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: padding,
      decoration: BoxDecoration(
        color: bgColor ?? kWhiteColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: borderColor ?? Colors.grey),
        boxShadow: [
          if(hasShadow!)
          BoxShadow(
            color: kPrimaryColor.withOpacity(0.2),
            offset: Offset(0, 1),
            blurRadius: 8,
          )
        ],
      ),
      child: child,
    );
  }
}
