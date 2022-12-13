import 'package:flutter/material.dart';
import 'package:ism_mart/utils/constants.dart';


class StickyLabel extends StatelessWidget {
  final String? text;
  final Color? textColor;
  final double? textSize;
  const StickyLabel({
    Key? key,
    this.text,
    this.textColor,
    this.textSize = 17,
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
        text!,
        style: TextStyle(
          color: textColor ?? kDarkColor,
          fontWeight: FontWeight.bold,
          fontSize: textSize,
        ),
      ),
    );
  }
}
