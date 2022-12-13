import 'package:get/get.dart';
import 'package:ism_mart/api_helper/export_api_helper.dart';
import 'package:ism_mart/controllers/export_controllers.dart';

class AppInitBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(BaseProvider(), permanent: true);

    Get.put(ApiService(Get.find()), permanent: true);


    Get.lazyPut<ApiRepository>(() => ApiRepository(Get.find()));
    Get.lazyPut<ApiProvider>(() => ApiProvider(Get.find()));


   /* Get.lazyPut<OrderRepo>(() => OrderRepo(Get.find()));
    Get.lazyPut<OrderProvider>(() => OrderProvider(Get.find()));*/
    // Get.lazyPut<AuthProvider>(() => AuthProvider(Get.find()));
    // Get.lazyPut<AuthController>(() => AuthController(Get.find()));

    Get.put<AuthRepository>(AuthRepository(Get.find()));
    Get.put<AuthProvider>( AuthProvider(Get.find()));
    Get.put<AuthController>(AuthController(Get.find()));

    //Get.lazyPut<AuthController>(() => null)
  }
}
