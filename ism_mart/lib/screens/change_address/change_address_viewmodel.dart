import 'package:get/get.dart';
import 'package:ism_mart/helper/api_base_helper.dart';
import 'package:ism_mart/helper/global_variables.dart';
import 'package:ism_mart/helper/urls.dart';
import 'package:ism_mart/models/exports_model.dart';
import 'package:ism_mart/utils/exports_utils.dart';
import 'package:ism_mart/utils/languages/translations_key.dart' as langKey;

import '../checkout/checkout_viewmodel.dart';

class ChangeAddressViewModel extends GetxController {
  List<UserModel> shippingAddressList = <UserModel>[].obs;

  @override
  void onReady() {
    getAllAddress();
    super.onReady();
  }

  @override
  void onClose() {
    GlobalVariable.showLoader.value = false;
    super.onClose();
  }

  getAllAddress() {
    GlobalVariable.showLoader.value = true;

    ApiBaseHelper()
        .getMethod(url: Urls.getShippingDetails, withAuthorization: true)
        .then((parsedJson) {
      GlobalVariable.showLoader.value = false;
      if (parsedJson['success'] == true) {
        shippingAddressList.clear();
        var data = parsedJson['data'] as List;
        shippingAddressList.addAll(data.map((e) => UserModel.fromJson(e)));
      }
    }).catchError((e) {
      print(e);
      GlobalVariable.showLoader.value = false;
    });
  }

  changeDefaultShippingAddress(String addressId) {
    GlobalVariable.showLoader.value = true;

    ApiBaseHelper()
        .getMethod(
            url: Urls.changeDefaultAddress + addressId, withAuthorization: true)
        .then((parsedJson) {
      GlobalVariable.showLoader.value = false;
      if (parsedJson['success'] == true) {
        AppConstant.displaySnackBar(langKey.success.tr, parsedJson['message']);
        getAllAddress();
        CheckoutViewModel checkoutController = Get.find();
        checkoutController.getDefaultShippingAddress();
      } else {
        AppConstant.displaySnackBar(
            langKey.errorTitle.tr, parsedJson['message']);
      }
    }).catchError((e) {
      print(e);
      GlobalVariable.showLoader.value = false;
    });
  }

  deleteShippingDetails(int? addressId) {
    GlobalVariable.showLoader.value = true;

    ApiBaseHelper()
        .patchMethod(
            url: Urls.deleteShippingDetails + addressId.toString(),
            withAuthorization: true)
        .then((parsedJson) {
      GlobalVariable.showLoader.value = false;
      if (parsedJson['success'] == true) {
        AppConstant.displaySnackBar(langKey.success.tr, parsedJson['message']);
        getAllAddress();
      } else {
        AppConstant.displaySnackBar(
            langKey.errorTitle.tr, parsedJson['message']);
      }
    }).catchError((e) {
      print(e);
      GlobalVariable.showLoader.value = false;
    });
  }
}
