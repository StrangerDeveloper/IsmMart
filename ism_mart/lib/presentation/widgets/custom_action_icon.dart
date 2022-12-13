import 'package:flutter/material.dart';
import 'package:ism_mart/utils/exports_utils.dart';

class CustomActionIcon extends StatelessWidget {
  const CustomActionIcon({
    Key? key,
    this.bgColor,
    this.iconColor,
    this.onTap,
    this.icon,
    this.size = 18,
    this.height = 30,
    this.width = 30,
    this.hasShadow = true,
  }) : super(key: key);

  final Color? bgColor, iconColor;
  final GestureTapCallback? onTap;
  final IconData? icon;
  final double? size, height, width;
  final bool? hasShadow;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
            color: bgColor, //?.withOpacity(0.6),
            shape: BoxShape.circle,
            boxShadow: [
              if(hasShadow!)
              BoxShadow(
                  color: kDarkColor.withOpacity(0.2),
                  offset: Offset(0, 1),
                  blurRadius: 10.7)
            ]),
        child: Icon(icon, size: size, color: iconColor ?? kWhiteColor),
      ),
    );
  }
}
