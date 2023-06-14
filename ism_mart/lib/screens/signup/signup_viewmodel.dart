import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ism_mart/helper/api_base_helper.dart';
import 'package:ism_mart/api_helper/global_variables.dart';
import 'package:ism_mart/helper/urls.dart';
import 'package:ism_mart/utils/exports_utils.dart';
import 'package:ism_mart/utils/languages/translations_key.dart' as langKey;

class SignUpViewModel extends GetxController {
  GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  RxBool obscurePassword = false.obs;
  Rxn phoneErrorText = Rxn<String>();
  RxString countryCode = '+92'.obs;

  validatorPhoneNumber(String? value) {
    if (GetUtils.isBlank(value)!) {
      phoneErrorText.value = langKey.fieldIsRequired.tr;
    } else if (value!.length > 16 || value.length < 7) {
      phoneErrorText.value = langKey.phoneValidate.tr;
    } else {
      phoneErrorText.value = null;
    }
  }

  @override
  void onClose() {
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    phoneNumberController.dispose();
    GlobalVariable.showLoader.value = false;
    super.onClose();
  }

  void signUp() {
    GlobalVariable.internetErr(false);
    if (signUpFormKey.currentState?.validate() ?? false) {
      GlobalVariable.showLoader.value = true;
      String? phoneNumber = countryCode.value + phoneNumberController.text;

      Map<String, dynamic> param = {
        "firstName": fullNameController.text,
        "email": emailController.text,
        "phone": phoneNumber,
        "password": passwordController.text,
      };

      ApiBaseHelper()
          .postMethod(url: Urls.signUp, body: param)
          .then((parsedJson) async {
        GlobalVariable.showLoader.value = false;

        if (parsedJson['message'] == 'User registered successfully.') {
          Get.offNamed(Routes.loginRoute);
          AppConstant.displaySnackBar(
            langKey.successTitle.tr,
            parsedJson['message'],
          );
        } else {
          AppConstant.displaySnackBar(
            langKey.errorTitle.tr,
            parsedJson['message'],
          );
        }
      }).catchError((e) {
        GlobalVariable.internetErr(true);
        print(e);
        GlobalVariable.showLoader.value = false;
      });
    }
  }
}
