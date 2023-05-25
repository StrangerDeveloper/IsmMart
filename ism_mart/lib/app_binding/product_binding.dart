import 'package:get/get.dart';
import 'package:ism_mart/presentation/export_product.dart';

class ProductBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductController>(() => ProductController(Get.find()));
  }
}
