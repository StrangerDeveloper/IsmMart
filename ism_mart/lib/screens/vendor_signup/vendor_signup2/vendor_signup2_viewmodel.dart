import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ism_mart/helper/global_variables.dart';
import 'package:ism_mart/helper/languages/translations_key.dart' as langKey;

class VendorSignUp2ViewModel extends GetxController{
  GlobalKey<FormState> vendorSignUp2FormKey = GlobalKey<FormState>();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  RxBool obscurePassword = true.obs;
  RxBool obscureConfirmPassword = true.obs;
  Rxn phoneErrorText = Rxn<String>();
  RxString countryCode = '+92'.obs;
  RxBool termAndCondition = false.obs;

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
    firstNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    phoneNumberController.dispose();
    GlobalVariable.showLoader.value = false;
    super.onClose();
  }

  void signUp() {
    // GlobalVariable.internetErr(false);
    // if (signUpFormKey.currentState?.validate() ?? false) {
    //   GlobalVariable.showLoader.value = true;
    //   String? phoneNumber = countryCode.value + phoneNumberController.text;
    //
    //   Map<String, dynamic> param = {
    //     "firstName": firstNameController.text,
    //     "email": emailController.text,
    //     "phone": phoneNumber,
    //     "password": passwordController.text,
    //   };
    //
    //   ApiBaseHelper()
    //       .postMethod(url: Urls.signUp, body: param)
    //       .then((parsedJson) async {
    //     GlobalVariable.showLoader.value = false;
    //
    //     if (parsedJson['message'] == 'User registered successfully.') {
    //       Get.offNamed(Routes.loginRoute);
    //       AppConstant.displaySnackBar(
    //         langKey.successTitle.tr,
    //         parsedJson['message'],
    //       );
    //     } else {
    //       AppConstant.displaySnackBar(
    //         langKey.errorTitle.tr,
    //         parsedJson['message'],
    //       );
    //     }
    //   }).catchError((e) {
    //     GlobalVariable.internetErr(true);
    //     print(e);
    //     GlobalVariable.showLoader.value = false;
    //   });
    // }
  }

}