import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GetxHelper {
  static void showSnackBar({required String title, required String message}) {
    Get.snackbar(
      title,
      message,
      colorText: Colors.white,
      backgroundColor: Colors.green,
      animationDuration: Duration(milliseconds: 500),
      duration: Duration(milliseconds: 1800),
    );
  }
}
