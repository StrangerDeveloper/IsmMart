import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashViewModel extends GetxController
    with GetSingleTickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void onInit() {
    animationController = AnimationController(
      duration: const Duration(milliseconds: 7000),
      vsync: this,
    );
    animationController.repeat();
    super.onInit();
  }

  @override
  void onReady() {
    //loadScreen();
    super.onReady();
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }

  loadScreen() {
    Future.delayed(const Duration(seconds: 3), () {});
  }
}
