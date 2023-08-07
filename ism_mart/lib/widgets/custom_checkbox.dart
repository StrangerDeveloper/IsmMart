import 'package:flutter/material.dart';
import 'package:ism_mart/helper/constants.dart';

class CustomCheckBox extends StatelessWidget {
  final String title;
  final bool? value;
  final ValueChanged? onChanged;

  // final Color? activeColor;
  // final Color? checkColor;

  CustomCheckBox({
    required this.title,
    required this.value,
    this.onChanged,
    // this.activeColor = Colors.yellow,
    // this.checkColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Transform.scale(
          scale: 0.87,
          child: Checkbox(
            value: value,
            onChanged: onChanged,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            visualDensity: VisualDensity.compact,
            fillColor: MaterialStateProperty.all(newColorLightGrey2),
            shape: RoundedRectangleBorder(
              side: BorderSide(width: 2, color: newColorLightGrey2),
              borderRadius: BorderRadius.circular(4.5),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Text(
              title,
              style: newFontStyle0.copyWith(
                color: newColorLightGrey2,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class CustomCheckBox2 extends StatelessWidget {
  final Widget text;
  final bool? value;
  final ValueChanged? onChanged;

  // final Color? activeColor;
  // final Color? checkColor;

  CustomCheckBox2({
    required this.text,
    required this.value,
    this.onChanged,
    // this.activeColor = Colors.yellow,
    // this.checkColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Transform.scale(
          scale: 0.87,
          child: Checkbox(
            value: value,
            onChanged: onChanged,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            visualDensity: VisualDensity.compact,
            fillColor: MaterialStateProperty.all(newColorLightGrey2),
            shape: RoundedRectangleBorder(
              side: BorderSide(width: 2, color: newColorLightGrey2),
              borderRadius: BorderRadius.circular(4.5),
            ),
          ),
        ),
        Expanded(child: text),
      ],
    );
  }
}
