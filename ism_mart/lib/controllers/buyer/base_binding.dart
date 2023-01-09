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
    Get.put<CategoryController>(CategoryController(Get.find()));



    Get.put<OrderRepository>(OrderRepository(Get.find()));
    Get.put<MembershipController>(MembershipController());
    Get.put<SearchController>(SearchController(Get.find()));
  }
}
