import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ism_mart/api_helper/api_base_helper.dart';
import 'package:ism_mart/api_helper/global_variables.dart';
import 'package:ism_mart/api_helper/urls.dart';
import 'package:ism_mart/utils/exports_utils.dart';
import '../../api_helper/local_storage/local_storage_helper.dart';
import '../../models/user/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:ism_mart/utils/languages/translations_key.dart' as langKey;

class ChangePasswordViewModel extends GetxController {
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  GlobalKey<FormState> changePasswordFormKey = GlobalKey<FormState>();

  RxBool obscureNewPassword = false.obs;
  RxBool obscureConfirmPassword = false.obs;

  String? validateNewPassTxtField(String? value) {
    if (GetUtils.isBlank(value)!) {
      return langKey.fieldIsRequired.tr;
    } else if (GetUtils.isLengthLessThan(value, 8)) {
      return langKey.passwordLengthReq.tr;
    } else {
      return null;
    }
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

  updatePassword() async {
    if (changePasswordFormKey.currentState?.validate() ?? false) {
      final UserModel userDetails = await LocalStorageHelper.getStoredUser();

      GlobalVariable.showLoader.value = true;

      Map<String, dynamic> param = {
        "email": "${userDetails.email}",
        "password": newPasswordController.text,
        "confirmPassword": confirmPasswordController.text,
      };

      ApiBaseHelper()
          .patchMethod(
              url: Urls.updatePassword, body: param, withAuthorization: true)
          .then((parsedJson) {
        GlobalVariable.showLoader.value = false;
        if (parsedJson['message'] == "Password updated successfully") {
          newPasswordController.text = "";
          confirmPasswordController.text = "";
          Get.back();
          AppConstant.displaySnackBar(success.tr, parsedJson['message']);
        } else {
          AppConstant.displaySnackBar(errorTitle.tr, parsedJson['message']);
        }
      }).catchError((e) {
        GlobalVariable.showLoader.value = false;
        print(e);
      });
    }
  }
}
