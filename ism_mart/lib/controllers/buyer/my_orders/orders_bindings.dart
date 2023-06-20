import 'package:get/get.dart';
import 'package:ism_mart/exports/export_api_helper.dart';
import 'package:ism_mart/exports/export_controllers.dart';

class OrdersBindings extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<OrderRepository>(()=>OrderRepository(Get.find()));
    Get.lazyPut<OrderProvider>(()=>OrderProvider(Get.find()));
    Get.lazyPut<OrderController>(() => OrderController(Get.find()));
  }

}