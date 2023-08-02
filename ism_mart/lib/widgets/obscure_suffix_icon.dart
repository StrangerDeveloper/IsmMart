import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ism_mart/helper/constants.dart';

class ObscureSuffixIcon extends StatelessWidget {
  final bool isObscured;
  final VoidCallback? onPressed;

  const ObscureSuffixIcon({
    super.key,
    this.isObscured = false,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: IconButton(
        visualDensity: VisualDensity.compact,
        icon: Icon(
          isObscured ? CupertinoIcons.eye_slash : CupertinoIcons.eye,
          size: 20,
          color: newColorLightGrey2,
        ),
        onPressed: onPressed,
      ),
    );
  }
}
