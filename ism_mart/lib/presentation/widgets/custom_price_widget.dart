import 'package:flutter/material.dart';
import 'package:ism_mart/presentation/export_presentation.dart';
import 'package:ism_mart/utils/exports_utils.dart';

class CustomPriceWidget extends StatelessWidget {
  const CustomPriceWidget({Key? key, this.title, this.style}) : super(key: key);
 final String? title;
  final TextStyle? style;
  @override
  Widget build(BuildContext context) {
    return CustomText(
      title: "${AppConstant.getCurrencySymbol()}$title",
      style: style ?? headline6,
    );
  }
}
