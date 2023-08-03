import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ism_mart/screens/splash/splash_viewmodel.dart';

class SplashView extends StatelessWidget {
  SplashView({Key? key}) : super(key: key);
  final SplashViewModel viewModel = Get.put(SplashViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          alignment: Alignment.center,
          children: [
            RotationTransition(
              turns: Tween(begin: 0.0, end: 1.0)
                  .animate(viewModel.animationController),
              child: SvgPicture.asset(
                'assets/svg/logo_circle.svg',
                width: Get.width * 0.5,
              ),
            ),
            SvgPicture.asset(
              'assets/svg/logo_wolf.svg',
              width: Get.width * 0.3,
            ),
          ],
        ),
      ),
    );
  }
}
