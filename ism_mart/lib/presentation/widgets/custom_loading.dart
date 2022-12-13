import 'package:flutter/material.dart';

class CustomLoading extends StatelessWidget {
  const CustomLoading(
      {Key? key,
      this.isDarkMode,
      this.isItForWidget = false,
      this.color = Colors.white})
      : super(key: key);
  final bool? isDarkMode;
  final bool? isItForWidget;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    if (isItForWidget!) {
      return Center(
        child: CircularProgressIndicator(
          strokeWidth: 2,
          color: color!,
        ),
      );
    }

    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          strokeWidth: 2,
          //color: Colors.white,
        ),
      ),
    );
  }
}
