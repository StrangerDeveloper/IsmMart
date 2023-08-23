import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardViewModel extends GetxController with GetTickerProviderStateMixin {

  late AnimationController animationController1 = AnimationController(vsync: this, duration: Duration(seconds: 1));
  late AnimationController animationController2 = AnimationController(vsync: this, duration: Duration(milliseconds: 500));
  late AnimationController animationController3 = AnimationController(vsync: this, duration: Duration(milliseconds: 600));
  late Animation<Offset> animation1 = Tween<Offset>(begin: Offset(0, 1.5), end: Offset(0, 0)).animate(CurvedAnimation(parent: animationController1, curve: Curves.easeInOut));
  late Animation<double> animation2 = CurvedAnimation(parent: animationController2, curve: Curves.easeOutQuart);
  late Animation<double> animation3 = CurvedAnimation(parent: animationController3, curve: Curves.easeOutCubic);
  RxDouble containerWidth = 50.0.obs;

  @override
  void onReady(){
    Future.delayed(Duration(seconds: 2), (){
      animationController1.forward();
      animationController1.addListener(() {
        animation1.value;
        if(animationController1.isCompleted){
          animationController2.forward();
          animationController2.addListener(() {
            containerWidth.value = 100 + (animation2.value * 80);
            if(animationController2.isCompleted){
              animationController3.forward();
              animationController3.addListener(() {
                animation3.value;
                if(animationController3.isCompleted){
                  animationController1.dispose();
                  animationController2.dispose();
                  animationController3.dispose();
                }
              });
            }
          });
        }
      });
    });
    super.onReady();

  }

}