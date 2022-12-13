import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ism_mart/api_helper/export_api_helper.dart';
import 'package:ism_mart/controllers/export_controllers.dart';
import 'package:ism_mart/utils/exports_utils.dart';

class AuthMiddleWare extends GetMiddleware {
 // final authController = findOrInit;

  AuthMiddleWare({int? priority}):super(priority: priority!);

  @override
  RouteSettings? redirect(String? route) {
    return (findOrInit.userModel!.email != null ) ||
            route == Routes.loginRoute
        ? null
        : RouteSettings(name: Routes.loginRoute);
  }


 AuthController get findOrInit{
    try {
      return Get.find();
    }catch(e){
      debugPrint(">>>>AuthMiddleWare: $e");

      Get.put<AuthRepository>(AuthRepository(Get.find()));
      Get.put<AuthProvider>( AuthProvider(Get.find()));
      Get.put<AuthController>(AuthController(Get.find()));


      return Get.find();
    }
  }

}
