import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ism_mart/helper/api_base_helper.dart';
import 'package:ism_mart/api_helper/global_variables.dart';
import 'package:ism_mart/helper/urls.dart';
import 'package:ism_mart/utils/exports_utils.dart';
import 'package:ism_mart/utils/languages/translations_key.dart' as langKey;

import '../forgot_password2/forgot_password2_view.dart';

class ForgotPassword1ViewModel extends GetxController {
  GlobalKey<FormState> forgotPasswordFormKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();

  @override
  void onInit() {
    emailController.text = Get.arguments['email'];
    super.onInit();
  }

  @override
  void onClose() {
    emailController.dispose();
    GlobalVariable.showLoader.value = false;
    super.onClose();
  }

  void sendBtn() {
    if (forgotPasswordFormKey.currentState?.validate() ?? false) {
      Map<String, dynamic> param = {"email": emailController.text};

      GlobalVariable.showLoader.value = true;

      ApiBaseHelper()
          .postMethod(url: Urls.forgetPassword, body: param)
          .then((parsedJson) async {
        GlobalVariable.showLoader.value = false;

        if (parsedJson['success'] == true) {
          Get.off(() => ForgotPassword2View(), arguments: {'email' : emailController.text});
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
