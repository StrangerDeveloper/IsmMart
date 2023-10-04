import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../helper/api_base_helper.dart';
import '../../helper/global_variables.dart';
import '../../helper/routes.dart';
import '../../helper/urls.dart';

class SplashViewModel extends GetxController
    with GetSingleTickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void onInit() {
    // getData();
    animationController = AnimationController(
      duration: const Duration(milliseconds: 7000),
      vsync: this,
    );
    animationController.repeat();
    super.onInit();
  }

  @override
  void onReady() {
    loadScreen();
    super.onReady();
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }

  //Get screen view check Shopify or Custom
  //RxBool isChangeView = false.obs;
  // getData() async {
  //   GlobalVariable.showLoader.value = true;
  //   await ApiBaseHelper()
  //       .getMethod(url: "admin/getView", withAuthorization: true)
  //       .then((parsedJson) {
  //     GlobalVariable.showLoader.value = false;
  //     print("shopify view ---- $parsedJson");
  //     if (parsedJson['success'] == true) {
  //       isChangeView.value = parsedJson['data']['view'];
  //       print("shopify view ---- ${isChangeView.value}");
  //       // allDisputeList.addAll(data.map((e) => AllDisputeModel.fromJson(e)));
  //     }
  //   }).catchError((e) {
  //     print(e);
  //     GlobalVariable.showLoader.value = false;
  //   });
  // }

  loadScreen() {
    Future.delayed(const Duration(seconds: 3), () {
      bool onboardingCompleted =
          GetStorage().read('onboarding_completed') ?? false;
      if (onboardingCompleted) {
        Get.offNamed(Routes.shopifyWebView);
        // if (isChangeView.value == false) {
        //   Get.offNamed(Routes.shopifyWebView);
        // } else {
        //   Get.offNamed(Routes.bottomNavigation);
        // }
      } else
        Get.offNamed(Routes.onBoard);
    });
  }
}
