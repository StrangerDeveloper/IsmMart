import 'package:get/get.dart';
import 'package:ism_mart/api_helper/export_api_helper.dart';
import 'package:ism_mart/exports/exports_ui.dart';

import 'export_controllers.dart';

AuthController authController = Get.find<AuthController>();
BaseController baseController = Get.find<BaseController>();

ThemesController themeController = Get.put(ThemesController());

LanguageController languageController = Get.put(LanguageController());

CurrencyController currencyController = Get.put(CurrencyController(Get.find()));

ProductController get productControllerFindOrInit {
  try {
    return Get.find();
  } catch (e) {
    Get.put<ApiRepository>(ApiRepository(Get.find()));
    Get.put<ApiProvider>(ApiProvider(Get.find()));
    Get.put<ProductController>(ProductController(Get.find()));
    return Get.find();
  }
}
