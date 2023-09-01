import 'package:get/get.dart';
import 'package:ism_mart/helper/global_variables.dart';
import 'package:ism_mart/exports/exports_model.dart';

class VendorProfileViewModel extends GetxController {
  Rx<UserModel?> userModel = UserModel().obs;

  @override
  void onReady() {
    getData();
    super.onReady();
  }

  getData() {
    userModel.value = GlobalVariable.userModel ?? null;
  }
}
