import 'package:flutter/material.dart';

class CustomBackButton extends StatelessWidget {
  final void Function() onTap;

  CustomBackButton({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              offset: const Offset(-3, 0),
              blurRadius: 2,
              spreadRadius: 1,
            )
          ],
        ),
        child: Icon(
          Icons.arrow_back_ios_new_rounded,
          size: 15,
        ),
      ),
    );
  }
}
