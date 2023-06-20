import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:ism_mart/exports/exports_utils.dart';

class NoDataFoundWithIcon extends StatelessWidget {
  const NoDataFoundWithIcon({Key? key, this.icon, this.title, this.subTitle, this.iconColor = kPrimaryColor})
      : super(key: key);
  final IconData? icon;
  final Color? iconColor;
  final String? title, subTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 90,
          height: 90,
          decoration: BoxDecoration(
              color: iconColor!.withOpacity(0.22), shape: BoxShape.circle),
          child: Icon(
            icon ?? IconlyLight.bag_2,
            size: 50,
            color: iconColor,
          ),
        ),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(children: [
            TextSpan(text: '\n${"$title"}\n', style: headline2),
            if (subTitle != null)
              TextSpan(text: "$subTitle", style: bodyText2)
          ]),
        ),
      ],
    );
  }
}
