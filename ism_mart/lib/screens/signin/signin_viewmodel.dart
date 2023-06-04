import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ism_mart/api_helper/api_base_helper.dart';
import 'package:ism_mart/api_helper/export_api_helper.dart';
import 'package:ism_mart/api_helper/global_variables.dart';
import 'package:ism_mart/api_helper/urls.dart';
import 'package:ism_mart/controllers/export_controllers.dart';
import 'package:ism_mart/models/exports_model.dart';
import 'package:ism_mart/utils/exports_utils.dart';
import 'package:ism_mart/utils/languages/translations_key.dart' as langKey;

class SignInViewModel extends GetxController {
  GlobalKey<FormState> signInFormKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  RxBool obscurePassword = false.obs;

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    GlobalVariable.showLoader.value = false;
    super.onClose();
  }

  void signIn() {
    if (signInFormKey.currentState?.validate() ?? false) {
      Map<String, dynamic> param = {
        "email": emailController.text,
        "password": passwordController.text,
      };

      GlobalVariable.showLoader.value = true;

      ApiBaseHelper()
          .postMethod(url: Urls.login, body: param)
          .then((parsedJson) async {
        UserResponse userResponse = UserResponse.fromResponse(parsedJson);
        GlobalVariable.showLoader.value = false;

        if (parsedJson['success'] == true) {
          Get.back();
          baseController.changePage(0);
          GlobalVariable.userModel = userResponse.userModel;
          await LocalStorageHelper.storeUser(userModel: userResponse.userModel)
              .then((value) {});
          AppConstant.displaySnackBar(
            langKey.successTitle.tr,
            parsedJson['message'],
          );
        } else if (parsedJson['message'] == 'Invalid credentials') {
          AppConstant.displaySnackBar(
            langKey.errorTitle.tr,
            langKey.wrongWithCredentials.tr,
          );
        } else {
          AppConstant.displaySnackBar(
            langKey.errorTitle.tr,
            parsedJson['message'],
          );
        }
      }).catchError((e) {
        print(e);
        GlobalVariable.showLoader.value = false;
      });
    }
  }
}
