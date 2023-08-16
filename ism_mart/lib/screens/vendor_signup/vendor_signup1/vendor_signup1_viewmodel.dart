import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ism_mart/controllers/buyer/auth/auth_controller.dart';
import 'package:ism_mart/helper/global_variables.dart';
import 'package:ism_mart/helper/languages/translations_key.dart' as langKey;
import '../../../api_helper/local_storage/local_storage_helper.dart';
import '../../../controllers/controllers.dart';
import '../../../helper/api_base_helper.dart';
import '../../../helper/constants.dart';
import '../../../helper/routes.dart';
import '../../../helper/urls.dart';
import '../../../models/user/country_city_model.dart';
import '../../../models/user/user_model.dart';
import '../../setting/settings_viewmodel.dart';

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

  signUp() {
    if (vendorSignUpFormKey.currentState!.validate()) {
      if (countryID.value != 0 && cityID.value != 0) {
        if (termAndCondition.value == true) {
          Map<String, dynamic> param = {
            'firstName': firstNameController.text,
            'lastName': lastNameController.text,
            'email': emailController.text,
            'phone': countryCode.value + phoneNumberController.text,
            'password': passwordController.text,
            'countryId': countryID.value,
            'cityId': cityID.value,
          };
          GlobalVariable.showLoader.value = true;

          ApiBaseHelper().postMethod(url: Urls.signUp, body: param)
              .then((parsedJson) async {

            if (parsedJson['success'] == true) {
              authController.currUserToken.value = parsedJson['data']['token'];
              await getCurrentUser(parsedJson);
              cityViewModel.cityId.value = 0;
              cityViewModel.countryId.value = 0;
              cityViewModel.authController.selectedCountry.value =
                  CountryModel();
              cityViewModel.authController.selectedCity.value = CountryModel();
              Get.offNamed(Routes.vendorSignUp2);
            } else {
              GlobalVariable.showLoader.value = false;
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
          AppConstant.displaySnackBar(
            langKey.errorTitle.tr,
              'Accept Terms and Conditions to proceed',
          );
          GlobalVariable.showLoader.value = false;
        }
      } else {
        if (countryID.value == 0) {
          countryErrorVisibility.value = true;
        } if (cityID.value == 0) {
          cityErrorVisibility.value = true;
        }
      }
    } else{
      if (countryID.value == 0) {
        countryErrorVisibility.value = true;
      }
      if (cityID.value == 0) {
        cityErrorVisibility.value = true;
      }
    }
  }

  Future<void> getCurrentUser(Map<String, dynamic> json) async {
    await ApiBaseHelper()
        .getMethod(url: 'user/profile', withAuthorization: true)
        .then((value) async {
      if (value['success'] == true) {
        UserResponse userResponse = UserResponse.fromResponse(value);
        userResponse.userModel!.token = json['data']['token'];
        GlobalVariable.userModel = userResponse.userModel;
        SettingViewModel settingViewModel = Get.find();
        settingViewModel.setUserModel(userResponse.userModel);
        AuthController authController = Get.find();
        authController.setCurrUserToken(json['data']['token']);
        // baseController.changePage(0);
        await LocalStorageHelper.storeUser(userModel: userResponse.userModel)
            .then((value) {});
      }
    });
  }

  List getTermConditionData() {
    return [
      {'header': langKey.vendorHeader0.tr, 'body': langKey.vendorBody0.tr},
      {'header': langKey.vendorHeader1.tr, 'body': langKey.vendorBody1.tr},
      {'header': langKey.vendorHeader2.tr, 'body': langKey.vendorBody2.tr},
      {'header': langKey.vendorHeader3.tr, 'body': langKey.vendorBody3.tr},
      {'header': langKey.vendorHeader4.tr, 'body': langKey.vendorBody4.tr},
      {'header': langKey.vendorHeader5.tr, 'body': langKey.vendorBody5.tr},
      {'header': langKey.vendorHeader6.tr, 'body': langKey.vendorBody6.tr},
      {'header': langKey.vendorHeader7.tr, 'body': langKey.vendorBody7.tr},
      {'header': langKey.vendorHeader8.tr, 'body': langKey.vendorBody8.tr},
      {'header': langKey.vendorHeader9.tr, 'body': langKey.vendorBody9.tr},
      {'header': langKey.vendorHeader10.tr, 'body': langKey.vendorBody10.tr},
      {'header': langKey.vendorHeader11.tr, 'body': langKey.vendorBody11.tr},
      {'header': langKey.vendorHeader12.tr, 'body': langKey.vendorBody12.tr},
      {'header': langKey.vendorHeader13.tr, 'body': langKey.vendorBody13.tr},
      {'header': langKey.vendorHeader14.tr, 'body': langKey.vendorBody14.tr},
      {'header': langKey.vendorHeader15.tr, 'body': langKey.vendorBody15.tr},
      {'header': langKey.vendorHeader16.tr, 'body': langKey.vendorBody16.tr},
      {'header': langKey.vendorHeader17.tr, 'body': langKey.vendorBody17.tr},
      {'header': langKey.vendorHeader18.tr, 'body': langKey.vendorBody18.tr},
      {'header': langKey.vendorHeader19.tr, 'body': langKey.vendorBody19.tr},
      {'header': langKey.vendorHeader20.tr, 'body': langKey.vendorBody20.tr},
      {'header': langKey.vendorHeader21.tr, 'body': langKey.vendorBody21.tr},
      {'header': langKey.vendorHeader22.tr, 'body': langKey.vendorBody22.tr},
      {'header': langKey.vendorHeader23.tr, 'body': langKey.vendorBody23.tr},
      {'header': langKey.vendorHeader24.tr, 'body': langKey.vendorBody24.tr},
      {'header': langKey.vendorHeader25.tr, 'body': langKey.vendorBody25.tr},
      {'header': langKey.vendorHeader26.tr, 'body': langKey.vendorBody26.tr},
      {'header': langKey.vendorHeader27.tr, 'body': langKey.vendorBody27.tr},
    ];
  }
}