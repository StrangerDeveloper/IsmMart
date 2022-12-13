import 'package:get/get.dart';
import 'package:ism_mart/api_helper/export_api_helper.dart';
import 'package:ism_mart/controllers/export_controllers.dart';

class SellerBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthRepository>(() => AuthRepository(Get.find()));
    Get.lazyPut<AuthProvider>(() => AuthProvider(Get.find()));
    Get.lazyPut<AuthController>(() => AuthController(Get.find()));

    Get.lazyPut<CategoryController>(() => CategoryController(Get.find()));

    Get.lazyPut<SellersApiRepo>(() => SellersApiRepo(Get.find()));
    Get.lazyPut<SellersApiProvider>(() => SellersApiProvider(Get.find()));

    Get.lazyPut<SellersController>(() => SellersController(Get.find(), Get.find(), Get.find()));
  }
}
