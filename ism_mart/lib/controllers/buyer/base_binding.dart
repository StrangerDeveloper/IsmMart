import 'package:get/get.dart';
import 'package:ism_mart/exports/export_api_helper.dart';
import 'package:ism_mart/exports/export_controllers.dart';
import 'package:ism_mart/controllers/product_controller.dart';

class BaseBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<CustomSearchController>(CustomSearchController(Get.find()));
    Get.lazyPut<BaseController>(() => BaseController(Get.find()));
    Get.put<CartController>(CartController(Get.find()));
    Get.put<CategoryController>(CategoryController(Get.find()));
    Get.put<OrderRepository>(OrderRepository(Get.find()));
    Get.put<ProductController>(ProductController(Get.find()));
  }
}
