import 'package:get/get.dart';
import 'package:ism_mart/exports/export_api_helper.dart';
import 'package:ism_mart/exports/export_controllers.dart';
import 'package:ism_mart/screens/top_vendors/top_vendors_viewmodel.dart';

import '../controllers/city_viewmodel.dart';

class AppInitBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(BaseProvider(), permanent: true);

    Get.put(ApiService(Get.find()), permanent: true);

    Get.lazyPut<ApiRepository>(() => ApiRepository(Get.find()));
    Get.lazyPut<ApiProvider>(() => ApiProvider(Get.find()));

    Get.put<AuthRepository>(AuthRepository(Get.find()));
    Get.put<AuthProvider>(AuthProvider(Get.find()));
    Get.put<AuthController>(AuthController(Get.find()));

    LocalStorageHelper.initUserStorage();

    Get.put<CurrencyController>(CurrencyController(Get.find()));
    Get.put(TopVendorsViewModel());
    Get.put(CityViewModel(Get.find()));
  }
}

class A extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
  }

}
