import 'package:get/get.dart';
import 'package:ism_mart/exports/export_api_helper.dart';

class BaseProvider extends GetConnect implements GetxService {
  @override
  void onInit() {
    super.onInit();
    httpClient.baseUrl = ApiConstant.baseUrl;
    httpClient.addRequestModifier(requestInterceptor);
    httpClient.addResponseModifier(responseInterceptor);
  }

  @override
  void onClose() {
    super.onClose();
    httpClient.close();
  }
}
