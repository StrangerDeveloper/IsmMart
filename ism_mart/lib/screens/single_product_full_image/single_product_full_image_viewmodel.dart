import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SingleProductFullImageViewModel extends GetxController{

  var imageController;
  RxInt imageIndex = 0.obs;

  initalizeImageController(int? initialImageIndex){
    imageController = PageController(initialPage: initialImageIndex!);
    imageIndex.value = initialImageIndex;
  }

  void changeImage(int index) {
    imageIndex.value = index;
    imageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOutCubicEmphasized,
    );
  }

  popProductImageView() {
    imageIndex(0);
    Get.back();
  }
}