import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ism_mart/controllers/controllers.dart';
import 'package:ism_mart/exports/exports_model.dart';
import 'package:ism_mart/helper/api_base_helper.dart';
import 'package:ism_mart/helper/global_variables.dart';
import 'package:ism_mart/helper/urls.dart';
import 'package:ism_mart/exports/exports_utils.dart';
import 'package:ism_mart/helper/languages/translations_key.dart' as langKey;

class SignUpViewModel extends GetxController {
  GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  RxInt countryID = 0.obs;
  RxInt cityID = 0.obs;
  RxBool countryErrorVisibility = false.obs;
  RxBool cityErrorVisibility = false.obs;
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
    GlobalVariable.internetErr(false);
    if (signUpFormKey.currentState?.validate() ?? false) {
      if (countryID.value != 0 && cityID.value != 0) {
        if(termAndCondition.value == true) {
          GlobalVariable.showLoader.value = true;
          String? phoneNumber = countryCode.value + phoneNumberController.text;

          Map<String, dynamic> param = {
            "firstName": firstNameController.text,
            "lastName": lastNameController.text,
            "email": emailController.text,
            "phone": phoneNumber,
            "password": passwordController.text,
            'cityId': cityID.value,
            'countryId': countryID.value,
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
              cityViewModel.cityId.value = 0;
              cityViewModel.countryId.value = 0;
              cityViewModel.authController.selectedCountry.value =
                  CountryModel();
              cityViewModel.authController.selectedCity.value = CountryModel();
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
      } else if (countryID.value == 0) {
        countryErrorVisibility.value = true;
      } else if (cityID.value == 0) {
        cityErrorVisibility.value = true;
      }
    }
  }
}