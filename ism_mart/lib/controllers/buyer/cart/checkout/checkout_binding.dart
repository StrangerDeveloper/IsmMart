import 'package:get/get.dart';
import 'package:ism_mart/api_helper/export_api_helper.dart';
import 'package:ism_mart/controllers/export_controllers.dart';

class CheckoutBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<OrderRepository>(()=>OrderRepository(Get.find()));

    Get.lazyPut<CartController>(() => CartController(Get.find()));
    //Get.lazyPut<OrderProvider>(()=>OrderProvider(Get.find()));
    Get.lazyPut<OrderProvider>(() => OrderProvider(Get.find()));


    Get.lazyPut<CheckoutController>(() => CheckoutController(
        Get.find(),
        Get.find<ApiProvider>(),
        Get.find<AuthController>(),
        Get.find<CartController>()));
  }
}
