import 'package:get/get.dart';
import 'package:ism_mart/api_helper/export_api_helper.dart';
import 'package:ism_mart/exports/exports_ui.dart';
import 'package:ism_mart/screens/top_vendors/top_vendors_viewmodel.dart';

import '../screens/register_seller/city_viewmodel.dart';
import 'export_controllers.dart';

AuthController authController = Get.find<AuthController>();
BaseController baseController = Get.find<BaseController>();
SellersController sellersController = Get.find<SellersController>();
TopVendorsViewModel topVendorsViewModel = Get.put(TopVendorsViewModel());
ThemesController themeController = Get.put(ThemesController());
CityViewModel cityViewModel = Get.put(CityViewModel(Get.find()));

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

CategoryController get categoryControllerFindOrInit{
  try{
    return Get.find();
  } catch (e){
    Get.put<ApiRepository>(ApiRepository(Get.find()));
    Get.put<ApiProvider>(ApiProvider(Get.find()));
    Get.put<CategoryController>(CategoryController(Get.find()));
    return Get.find();
  }
}