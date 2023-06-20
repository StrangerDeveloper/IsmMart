import 'package:get/get.dart';
import 'package:ism_mart/exports/exports_model.dart';

class GlobalVariable {
  static RxBool showLoader = false.obs;
  static RxBool internetErr = false.obs;
  static RxBool btnPress = false.obs;

  static UserModel? userModel;
}
