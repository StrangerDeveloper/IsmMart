import 'package:flutter/material.dart';
import 'package:ism_mart/helper/constants.dart';

class CustomCheckBox extends StatelessWidget {
  final String title;
  final bool? value;
  final ValueChanged? onChanged;
  final Color? activeColor;
  final Color? checkColor;

  CustomCheckBox({
    required this.title,
    required this.value,
    this.onChanged,
    this.activeColor = Colors.yellow,
    this.checkColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Checkbox(
            value: value,
            onChanged: onChanged,
            activeColor: activeColor,
            checkColor: checkColor,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            visualDensity: VisualDensity.compact,
            shape: RoundedRectangleBorder(
              side: BorderSide(width: 2, color: newColorLightGrey2),
              borderRadius: BorderRadius.circular(4.5),
            ),
          ),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 14,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
