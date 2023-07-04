import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ism_mart/exports/exports_utils.dart';
import 'package:ism_mart/helper/api_base_helper.dart';
import 'package:ism_mart/helper/global_variables.dart';
import 'package:ism_mart/helper/languages/translations_key.dart' as langKey;
import 'package:ism_mart/helper/urls.dart';

class VerifyPasswordViewModel extends GetxController {
  GlobalKey<FormState> forgotPassword2FormKey = GlobalKey<FormState>();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  RxBool obscureNewPassword = false.obs;
  RxBool obscureConfirmPassword = false.obs;
  String email = '';

  @override
  void onInit() {
    email = Get.arguments['email'];
    super.onInit();
  }

  @override
  void onClose() {
    GlobalVariable.showLoader.value = false;
    super.onClose();
  }

  String? validateConfirmPassTxtField(String? value) {
    if (GetUtils.isBlank(value)!) {
      return langKey.fieldIsRequired.tr;
    } else if (GetUtils.isLengthLessThan(value, 8)) {
      return langKey.passwordLengthReq.tr;
    } else if (newPasswordController.text != confirmPasswordController.text) {
      return langKey.passwordNotMatched.tr;
    } else {
      return null;
    }
  }

  submitBtn() async {
    if (forgotPassword2FormKey.currentState?.validate() ?? false) {
      GlobalVariable.showLoader.value = true;

      Map<String, dynamic> param = {
        "email": email,
        "token": otpController.text,
        "password": newPasswordController.text,
        "confirmPassword": confirmPasswordController.text,
      };

      ApiBaseHelper()
          .postMethod(url: Urls.forgetPasswordOtp, body: param)
          .then((parsedJson) {
        GlobalVariable.showLoader.value = false;
        if (parsedJson['message'] == "Password updated successfully") {
          Get.back();
          AppConstant.displaySnackBar(langKey.success.tr, parsedJson['message']);
        } else {
          AppConstant.displaySnackBar(langKey.errorTitle.tr, parsedJson['message']);
        }
      }).catchError((e) {
        GlobalVariable.showLoader.value = false;
        print(e);
      });
    }
  }
}
