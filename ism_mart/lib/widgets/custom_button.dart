import 'package:flutter/material.dart';
import 'package:ism_mart/exports/exports_utils.dart';

class CustomTextBtn extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double height;
  final double width;
  final Widget? child;
  final double radius;
  final EdgeInsetsGeometry? padding;
  final MaterialTapTargetSize? tapTargetSize;
  final BorderSide? side;
  final OutlinedBorder? shape;

  const CustomTextBtn({
    Key? key,
    this.height = 44,
    this.title = "",
    this.width = double.infinity,
    required this.onPressed,
    this.backgroundColor = kPrimaryColor,
    this.foregroundColor = Colors.white,
    this.child,
    this.radius = 6,
    this.padding,
    this.tapTargetSize,
    this.side,
    this.shape,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        padding: padding,
        tapTargetSize: tapTargetSize,
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        minimumSize: Size(width, height),
        side: side,
        shape: (shape != null)
            ? shape
            : RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(radius),
              ),
      ),
      child: child ?? Text(title),
    );
  }
}
