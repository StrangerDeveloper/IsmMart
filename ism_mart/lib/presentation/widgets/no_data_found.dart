import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ism_mart/presentation/widgets/custom_text.dart';
import 'package:ism_mart/utils/constants.dart';

import '../../utils/languages/translations_key.dart' as langKey;

class NoDataFound extends StatelessWidget {
  const NoDataFound(
      {Key? key, this.text, this.maxLines, this.textAlign, this.fontSize})
      : super(key: key);

  final String? text;
  final int? maxLines;
  final TextAlign? textAlign;
  final double? fontSize;


  @override
  Widget build(BuildContext context) {

    return Center(
      child: CustomText(
        title: text ?? langKey.noDataFound.tr,
        maxLines: maxLines ?? 4,
        textAlign: textAlign ?? TextAlign.center,
        style: headline3,
        weight: FontWeight.w600,
        size: fontSize ?? 17,
      ),
    );
  }
}
