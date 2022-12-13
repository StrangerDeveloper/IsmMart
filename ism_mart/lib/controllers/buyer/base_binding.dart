import 'package:get/get.dart';
import 'package:ism_mart/api_helper/export_api_helper.dart';
import 'package:ism_mart/controllers/export_controllers.dart';

class BaseBindings extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies



    Get.lazyPut<BaseController>(() => BaseController(Get.find()));


    //Get.lazyPut<OrderProvider>(() => OrderProvider(Get.find()));

    //Get.put<AuthController>(AuthController(Get.find()));

    Get.put<CartController>(CartController(Get.find()));
    Get.lazyPut<CategoryController>(() => CategoryController(Get.find()));
    Get.lazyPut<SearchController>(() => SearchController(Get.find()));

    Get.put<OrderRepository>(OrderRepository(Get.find()));
  }
}
