import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardViewModel extends GetxController with GetTickerProviderStateMixin {

  late AnimationController animationController1 = AnimationController(vsync: this, duration: Duration(seconds: 1));
  late AnimationController animationController2 = AnimationController(vsync: this, duration: Duration(milliseconds: 500));
  late AnimationController animationController3 = AnimationController(vsync: this, duration: Duration(milliseconds: 600));
  late AnimationController animationController4 = AnimationController(vsync: this, duration: Duration(milliseconds: 600));
  late AnimationController animationController5 = AnimationController(vsync: this, duration: Duration(milliseconds: 600));
  late AnimationController animationController6 = AnimationController(vsync: this, duration: Duration(milliseconds: 600));
  late AnimationController animationController7 = AnimationController(vsync: this, duration: Duration(milliseconds: 600));
  late Animation<Offset> animation1 = Tween<Offset>(begin: Offset(0, 1.5), end: Offset(0, 0)).animate(CurvedAnimation(parent: animationController1, curve: Curves.easeInOut));
  late Animation<double> animation2 = CurvedAnimation(parent: animationController2, curve: Curves.easeOutQuart);
  late Animation<double> animation3 = CurvedAnimation(parent: animationController3, curve: Curves.easeOutCubic);
  late Animation<double> animation4 = CurvedAnimation(parent: animationController4, curve: Curves.ease);
  late Animation<double> animation5 = CurvedAnimation(parent: animationController5, curve: Curves.ease);
  late Animation<Offset> animation6 = Tween<Offset>(begin: Offset(0, 0), end: Offset(0, -0.2)).animate(CurvedAnimation(parent: animationController6, curve: Curves.easeInBack));
  late Animation<double> animation7 = CurvedAnimation(parent: animationController7, curve: Curves.ease);
  RxDouble containerWidth = 50.0.obs;
  RxBool bannerVisibility = true.obs;
  RxBool changeTransition = false.obs;

  @override
  void onReady(){
    initializeAnimations();
    super.onReady();

  }

  initializeAnimations() {
    Future.delayed(Duration(seconds: 1), () {
      animationController5.forward();
      animationController5.addListener(() {
        animation5.value;
        if (animationController5.isCompleted) {
              animationController1.forward();
              animationController1.addListener(() {
                animation1.value;
                if(animationController1.isCompleted){
                  animationController2.forward();
                  animationController2.addListener(() {
                    containerWidth.value = 60 + (animation2.value * 80);
                    if(animationController2.isCompleted){
                      animationController3.forward();
                      animationController3.addListener(() {
                        animation3.value;
                        if(animationController3.isCompleted){
                          animationController4.forward();
                          animationController4.addListener(() {
                            if(animationController4.isCompleted){
                              animationController4.reverse();
                            }
                            if(animationController4.isDismissed){
                              animationController4.forward();
                            }
                          });
                        }
                      });
                    }
                  });
                }
              });
            }
          });
    });
  }

  disposeAnimations(){
    animationController1.dispose();
    animationController2.dispose();
    animationController3.dispose();
    animationController5.dispose();
    animationController6.dispose();
    animationController7.dispose();
  }
}