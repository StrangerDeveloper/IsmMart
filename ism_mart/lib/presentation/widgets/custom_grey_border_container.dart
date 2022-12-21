import 'package:flutter/material.dart';
import 'package:ism_mart/utils/constants.dart';

class CustomGreyBorderContainer extends StatelessWidget {
  const CustomGreyBorderContainer({Key? key, this.borderColor, required this.child})
      : super(key: key);
  final Color? borderColor;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kWhiteColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: borderColor ?? Colors.grey),
        boxShadow: [
          BoxShadow(
            color: kPrimaryColor.withOpacity(0.2),
            offset: Offset(0, 1),
            blurRadius: 8,
          )
        ],
      ),
      child: child,
    );
  }
}
