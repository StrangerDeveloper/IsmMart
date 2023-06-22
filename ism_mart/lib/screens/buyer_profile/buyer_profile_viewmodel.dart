import 'package:get/get.dart';
import 'package:ism_mart/helper/global_variables.dart';
import 'package:ism_mart/helper/languages/translations_key.dart' as langKey;
import 'package:ism_mart/screens/buyer_profile/buyer_profile_model.dart';
import '../../exports/exports_utils.dart';
import '../../helper/api_base_helper.dart';
import '../../helper/urls.dart';

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
        .getMethod(url: Urls.getVendorAccountData, withAuthorization: true)
        .then((parsedJson) {
      GlobalVariable.showLoader.value = false;
      GlobalVariable.internetErr(false);
      if (parsedJson['success'] == true && parsedJson['data'] != null) {
        buyerProfileModel.value = BuyerProfileModel.fromJson(parsedJson['data']);
      } else {
        AppConstant.displaySnackBar(
            langKey.errorTitle.tr, langKey.recordDoNotExist.tr);
      }
    }).catchError((e) {
      GlobalVariable.internetErr(true);
      print(e);
      GlobalVariable.showLoader.value = false;
    });
  }

}
