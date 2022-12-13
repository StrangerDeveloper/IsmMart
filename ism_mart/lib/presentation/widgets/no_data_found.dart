import 'package:flutter/material.dart';
import 'package:ism_mart/presentation/widgets/custom_text.dart';

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
        title: text ?? "No Data Found!",
        maxLines: maxLines ?? 4,
        textAlign: textAlign ?? TextAlign.center,
        weight: FontWeight.w600,
        size: fontSize ?? 17,
      ),
    );
  }
}
