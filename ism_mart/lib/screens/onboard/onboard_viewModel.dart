import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../helper/routes.dart';
import 'onboard_model.dart';

class OnBoardViewModel extends GetxController {
  PageController _pageController = PageController();
  int _currentPage = 0;
  final List<OnBoardModel> list = OnBoardModel.list;

  PageController get pageController => _pageController;
  int get currentPage => _currentPage;

  @override
  void onInit() {
    super.onInit();
  }

  void onPageChanged(int value) {
    _currentPage = value;
    update(); // Notifying the GetX system that the state has changed
  }

  void goToNextPage() {
    if (_currentPage < OnBoardModel.list.length - 1) {
      _currentPage++;
      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 400),
        curve: Curves.linear,
      );
    }
  }

  Future<void> completeOnboarding() async {
    GetStorage().write('onboarding_completed', true);
  }

  void goToDashboard() {
    Get.offNamed(Routes.shopifyWebView);
  }
}
