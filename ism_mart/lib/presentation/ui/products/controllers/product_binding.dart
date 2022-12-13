import 'package:get/get.dart';
import 'package:ism_mart/presentation/ui/products/export_product.dart';
import 'package:ism_mart/api_helper/export_api_helper.dart';


class ProductBinding extends Bindings{
  @override
  void dependencies() {

    Get.lazyPut<ProductController>(() => ProductController(Get.find()));
  }

}