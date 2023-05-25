import 'package:flutter/material.dart';
import 'package:ism_mart/presentation/export_presentation.dart';
import 'package:ism_mart/utils/exports_utils.dart';

class CustomHeader extends StatelessWidget {
  const CustomHeader({Key? key, this.title, this.style}) : super(key: key);
  final String? title;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: const EdgeInsets.all(8),
      color: kLightBlueColor,
      child: Center(child: CustomText(title: title!, style: style ?? headline2)),
    );
  }
}
