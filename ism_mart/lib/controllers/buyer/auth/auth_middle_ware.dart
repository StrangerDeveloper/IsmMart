import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ism_mart/exports/export_api_helper.dart';
import 'package:ism_mart/exports/export_controllers.dart';
import 'package:ism_mart/exports/exports_utils.dart';

class AuthMiddleWare extends GetMiddleware {
  AuthMiddleWare({int? priority}) : super(priority: priority!);

  @override
  RouteSettings? redirect(String? route) {
    return (findOrInit.userModel!.email != null &&
                !findOrInit.isSessionExpired! &&
                findOrInit.userToken != null) ||
            route == Routes.loginRoute
        ? null
        : RouteSettings(name: Routes.loginRoute);
  }

  @override
  GetPageBuilder? onPageBuildStart(GetPageBuilder? page) {
    findOrInit.getToken();

    return super.onPageBuildStart(page);
  }

  AuthController get findOrInit {
    try {
      return Get.find();
    } catch (e) {
      Get.put<AuthRepository>(AuthRepository(Get.find()));
      Get.put<AuthProvider>(AuthProvider(Get.find()));
      Get.put<AuthController>(AuthController(Get.find()));

      return Get.find();
    }
  }
}
