import 'package:get/get.dart';
import 'package:ism_mart/api_helper/global_variables.dart';
import 'package:ism_mart/models/exports_model.dart';

class VendorDetailViewModel extends GetxController {
  Rx<UserModel?> userModel = UserModel().obs;

  @override
  void onReady() {
    getData();
    super.onReady();
  }

  getData() {
    userModel.value = GlobalVariable.userModel;
    print(userModel.value?.toJson());
  }
}
