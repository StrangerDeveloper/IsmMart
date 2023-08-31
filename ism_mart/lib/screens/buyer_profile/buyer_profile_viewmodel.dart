import 'package:get/get.dart';
import 'package:ism_mart/helper/global_variables.dart';
import 'package:ism_mart/helper/languages/translations_key.dart' as langKey;
import 'package:ism_mart/screens/buyer_profile/buyer_profile_model.dart';

import '../../api_helper/local_storage/local_storage_helper.dart';
import '../../exports/exports_utils.dart';
import '../../helper/api_base_helper.dart';
import '../../helper/urls.dart';
import '../../models/user/user_model.dart';
import '../setting/settings_viewmodel.dart';

class BuyerProfileViewModel extends GetxController {
  Rx<BuyerProfileModel> buyerProfileModel = BuyerProfileModel().obs;

  @override
  void onReady() {
    getData();
    super.onReady();
  }

  getData() {
    GlobalVariable.showLoader.value = true;

    ApiBaseHelper()
        .getMethod(url: Urls.getAccountData, withAuthorization: true)
        .then((parsedJson) {
      GlobalVariable.internetErr(false);
      GlobalVariable.showLoader.value = false;
      if (parsedJson['success'] == true && parsedJson['data'] != null) {
        buyerProfileModel.value =
            BuyerProfileModel.fromJson(parsedJson['data']);
      } else {
        AppConstant.displaySnackBar(
            langKey.errorTitle.tr, langKey.recordDoNotExist.tr);
      }
    }).catchError((e) {
     // GlobalVariable.internetErr(true);
      print(e);
      GlobalVariable.showLoader.value = false;
    });
  }

  deleteAccount() {
    GlobalVariable.showLoader.value = true;

    ApiBaseHelper()
        .getMethod(
            url: Urls.deleteAccount, withAuthorization: true, withBearer: false)
        .then((parsedJson) {
      GlobalVariable.showLoader.value = false;
      if (parsedJson['success'] == true && parsedJson['data'] != null) {
        Get.back();
        LocalStorageHelper.deleteUserData();
        SettingViewModel settingViewModel = Get.find();
        settingViewModel.userDetails.value = UserModel();
        AppConstant.displaySnackBar(
            langKey.successTitle.tr, langKey.recordDoNotExist.tr);
      } else {
        AppConstant.displaySnackBar(
            langKey.errorTitle.tr, langKey.recordDoNotExist.tr);
      }
    }).catchError((e) {
      print(e);
      GlobalVariable.showLoader.value = false;
    });
  }
}
