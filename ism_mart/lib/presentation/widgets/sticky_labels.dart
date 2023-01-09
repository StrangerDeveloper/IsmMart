import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ism_mart/utils/constants.dart';


class StickyLabel extends StatelessWidget {
  final String? text;
  final TextStyle? style;
  const StickyLabel({
    Key? key,
    this.text, this.style,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.only(
        left: kDefaultPadding,
        top: kFixPadding,
      ),
      child: Text(
        text!.tr,
        style: style??headline3,


        /*TextStyle(
          color: textColor ?? kDarkColor,
          fontWeight: FontWeight.bold,
          fontSize: textSize,
        ),*/
      ),
    );
  }
}
