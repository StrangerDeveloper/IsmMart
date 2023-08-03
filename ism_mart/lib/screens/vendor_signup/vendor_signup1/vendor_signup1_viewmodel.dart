import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ism_mart/api_helper/local_storage/local_storage_helper.dart';
import 'package:ism_mart/helper/global_variables.dart';
import 'package:ism_mart/helper/languages/translations_key.dart' as langKey;

import '../../../controllers/controllers.dart';
import '../../../helper/api_base_helper.dart';
import '../../../helper/constants.dart';
import '../../../helper/routes.dart';
import '../../../helper/urls.dart';
import '../../../models/user/country_city_model.dart';
import '../../../models/user/user_model.dart';
import '../vendor_signup2/vendor_signup2_view.dart';

class VendorSignUp1ViewModel extends GetxController{
  GlobalKey<FormState> vendorSignUpFormKey = GlobalKey<FormState>();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
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
    confirmPasswordController.dispose();
    lastNameController.dispose();
    GlobalVariable.showLoader.value = false;
    super.onClose();
  }

  void signUp() {
    if (vendorSignUpFormKey.currentState!.validate()) {
      if (countryID.value != 0 && cityID.value != 0) {
        if (termAndCondition.value == true) {
          Map<String, String> param = {
            'firstName': firstNameController.text,
            'lastName': lastNameController.text,
            'email': emailController.text,
            'phoneNumber': countryCode.value + phoneNumberController.text,
            'password': passwordController.text,
            'countryId': '${countryID.value}',
            'cityId': '${cityID.value}'
          };
          GlobalVariable.showLoader.value = true;
          ApiBaseHelper()
              .postMethod(url: Urls.signUp, body: param)
              .then((parsedJson) async {
            GlobalVariable.showLoader.value = false;

            if (parsedJson['message'] == 'User registered successfully.') {
              Get.offNamed(Routes.vendorSignUp1);
                  AppConstant.displaySnackBar(
                langKey.successTitle.tr,
                parsedJson['message'],
              );
                  final data = parsedJson['data'];
                  print(UserModel.fromJson(data).emailVerified);
                  // LocalStorageHelper.storeUser(userModel: UserModel.fromJson(data));
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
        } else{
          AppConstant.showToast('Accept Terms and Conditions to proceed', Color.fromRGBO(252, 236, 239, 1), Color.fromRGBO(254, 58, 48, 1));
          GlobalVariable.showLoader.value = false;
        }
      } else if (countryID.value == 0) {
        countryErrorVisibility.value = true;
      } else if (cityID.value == 0) {
        cityErrorVisibility.value = true;
      }
    }
  }
}