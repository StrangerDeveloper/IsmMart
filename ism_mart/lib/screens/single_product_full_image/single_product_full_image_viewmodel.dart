import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/product/product_model.dart';

class SingleProductFullImageViewModel extends GetxController{

  var imageController;
  RxInt imageIndex = 0.obs;
  var productImages = <ProductImages>[].obs;
  var imagesToUpdate = [].obs;

  @override
  void onInit() {
    imageController = PageController(initialPage: Get.arguments[0]['initialImage']);
    imageIndex.value = Get.arguments[0]['initialImage'];

    if(Get.arguments[0]['productImages'] != null){
      productImages.addAll(Get.arguments[0]['productImages']);
    }
    if(Get.arguments[0]['imagesToUpdate'] != null){
      imagesToUpdate.addAll(Get.arguments[0]['imagesToUpdate']);
    }

    super.onInit();
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