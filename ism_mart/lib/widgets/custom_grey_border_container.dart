import 'package:flutter/material.dart';
import 'package:ism_mart/exports/export_presentation.dart';
import 'package:ism_mart/utils/constants.dart';

class CustomGreyBorderContainer extends StatelessWidget {
  const CustomGreyBorderContainer(
      {Key? key,
      this.borderColor,
      this.bgColor,
      required this.child,
      this.width,
      this.hasShadow = true,
      this.isSelected = false,
      this.activeColor,
      this.padding,
      this.height})
      : super(key: key);
  final Color? borderColor, bgColor, activeColor;
  final Widget? child;
  final double? width, height;
  final EdgeInsetsGeometry? padding;
  final bool? hasShadow, isSelected;

  @override
  Widget build(BuildContext context) {
    if (isSelected!) {
      return Stack(
        children: [
          _buildContainer(borderColor: activeColor ?? borderColor),
          Positioned(
            top: 0.5,
            left: 0.5,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 6),
              decoration: BoxDecoration(
                color: activeColor,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(8)),
              ),
              child: CustomText(
                title: "Selected address",
                color: kWhiteColor,
                size: 12,
                weight: FontWeight.w600,
              ),
            ),
          ),
        ],
      );
    }
    return _buildContainer(borderColor: borderColor);
  }

  _buildContainer({borderColor}) {
    return Container(
      width: width,
      height: height,
      padding: padding,
      decoration: BoxDecoration(
        color: bgColor ?? kWhiteColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: borderColor ?? Colors.grey),
        boxShadow: [
          if (hasShadow!)
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
