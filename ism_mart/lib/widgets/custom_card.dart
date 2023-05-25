import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({Key? key, this.child, this.color, this.margin, this.elevation}) : super(key: key);
  final Widget? child;
  final Color? color;
  final EdgeInsetsGeometry? margin;
  final double? elevation;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: elevation,
      color: color,
      margin: margin,
      child: child,
    );
  }
}
