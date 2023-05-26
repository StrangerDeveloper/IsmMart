import 'package:get/get.dart';
import 'package:ism_mart/controllers/product_controller.dart';

class ProductBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductController>(() => ProductController(Get.find()));
  }
}
