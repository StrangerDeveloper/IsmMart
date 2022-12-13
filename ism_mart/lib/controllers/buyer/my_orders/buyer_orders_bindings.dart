import 'package:get/get.dart';
import 'package:ism_mart/api_helper/export_api_helper.dart';
import 'package:ism_mart/controllers/export_controllers.dart';

class BuyerOrdersBindings extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<OrderRepository>(()=>OrderRepository(Get.find()));
    Get.lazyPut<OrderProvider>(()=>OrderProvider(Get.find()));

    Get.lazyPut<BuyerOrderController>(() => BuyerOrderController(Get.find()));
  }

}