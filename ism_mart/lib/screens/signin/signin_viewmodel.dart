import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ism_mart/helper/api_base_helper.dart';
import 'package:ism_mart/api_helper/export_api_helper.dart';
import 'package:ism_mart/helper/global_variables.dart';
import 'package:ism_mart/helper/urls.dart';
import 'package:ism_mart/controllers/export_controllers.dart';
import 'package:ism_mart/models/exports_model.dart';
import 'package:ism_mart/screens/setting/settings_viewmodel.dart';
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
    GlobalVariable.internetErr(false);
    if (signInFormKey.currentState?.validate() ?? false) {
      Map<String, dynamic> param = {
        "email": emailController.text,
        "password": passwordController.text,
      };

      GlobalVariable.showLoader.value = true;

      ApiBaseHelper()
          .postMethod(url: Urls.login, body: param)
          .then((parsedJson) async {
        if (parsedJson['success'] == true) {
          GlobalVariable.internetErr(false);

          authController.currUserToken.value = parsedJson['data']['token'];
          getCurrentUser(parsedJson);
        } else if (parsedJson['message'] == 'Invalid credentials') {
          AppConstant.displaySnackBar(
            langKey.errorTitle.tr,
            langKey.wrongWithCredentials.tr,
          );

          GlobalVariable.showLoader.value = false;
        } else {
          AppConstant.displaySnackBar(
            langKey.errorTitle.tr,
            parsedJson['message'],
          );

          GlobalVariable.showLoader.value = false;
        }
      }).catchError((e) {
        GlobalVariable.internetErr(true);
        print(e);
        GlobalVariable.showLoader.value = false;
      });
    }
  }

  void getCurrentUser(Map<String, dynamic> json) async {
    await ApiBaseHelper()
        .getMethod(url: 'user/profile', withAuthorization: true)
        .then((value) async {
      if (value['success'] == true) {
        UserResponse userResponse = UserResponse.fromResponse(value);
        userResponse.userModel!.token = json['data']['token'];
        GlobalVariable.userModel = userResponse.userModel;
        SettingViewModel settingViewModel = Get.find();
        settingViewModel.setUserModel(userResponse.userModel);
        Get.back();
        baseController.changePage(0);
        await LocalStorageHelper.storeUser(userModel: userResponse.userModel)
            .then((value) {});
        // print('>>User Model: ${userResponse.userModel}');
        AppConstant.displaySnackBar(
          langKey.successTitle.tr,
          json['message'],
        );
      }
    });
  }
}
