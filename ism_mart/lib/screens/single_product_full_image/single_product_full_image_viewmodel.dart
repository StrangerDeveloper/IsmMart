import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SingleProductFullImageViewModel extends GetxController{

  var imageController;

  initalizedImageController(int? initialImageIndex){
    imageController = PageController(initialPage: initialImageIndex!);
  }

  void changeImage(int index) {
    // controller.imageIndex(index);
    imageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOutCubicEmphasized,
    );
  }
}