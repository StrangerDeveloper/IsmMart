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
  final OutlinedBorder? shape;
  final BorderSide borderSide;

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
    this.borderSide = BorderSide.none,
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
        side: borderSide,
        shape: (shape != null)
            ? shape
            : RoundedRectangleBorder(
                side: borderSide,
                borderRadius: BorderRadius.circular(radius),
              ),
      ),
      child: child ?? Text(title),
    );
  }
}

class CustomRoundedTextBtn extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double height;
  final double width;
  final Widget? child;
  final EdgeInsetsGeometry? padding;
  final MaterialTapTargetSize? tapTargetSize;
  final OutlinedBorder? shape;
  final BorderSide borderSide;

  const CustomRoundedTextBtn({
    Key? key,
    this.height = 50,
    this.title = "",
    this.width = double.infinity,
    required this.onPressed,
    this.backgroundColor = newColorDarkBlack,
    this.foregroundColor = Colors.white,
    this.child,
    this.padding,
    this.tapTargetSize,
    this.borderSide = BorderSide.none,
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
        side: borderSide,
        shape: (shape != null)
            ? shape
            : RoundedRectangleBorder(
                side: borderSide,
                borderRadius: BorderRadius.circular(30),
              ),
      ),
      child: child ?? Text(title),
    );
  }
}
