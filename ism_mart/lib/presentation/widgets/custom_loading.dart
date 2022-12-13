import 'package:flutter/material.dart';
import 'package:ism_mart/utils/constants.dart';

class CustomLoading extends StatelessWidget {
  const CustomLoading(
      {Key? key,
      this.isDarkMode,
      this.isItForWidget = false,
        this.isItBtn = false,
      this.color = Colors.white})
      : super(key: key);
  final bool? isDarkMode;
  final bool? isItForWidget, isItBtn;
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
    if(isItBtn!){
      return Center(
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: kPrimaryColor
          ),
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: kWhiteColor,
          ),
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
