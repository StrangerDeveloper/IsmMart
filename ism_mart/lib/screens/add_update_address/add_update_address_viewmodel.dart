import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ism_mart/helper/languages/translations_key.dart' as langKey;
import 'package:ism_mart/helper/urls.dart';

import '../../controllers/controllers.dart';
import '../../exports/exports_utils.dart';
import '../../helper/api_base_helper.dart';
import '../../helper/global_variables.dart';
import '../../models/user/user_model.dart';
import '../change_address/change_address_viewmodel.dart';
import '../checkout/checkout_viewmodel.dart';

class AddUpdateAddressViewModel extends GetxController {
  bool isUpdateScreen = false;
  UserModel userModel = UserModel();
  GlobalKey<FormState> shippingAddressFormKey = GlobalKey<FormState>();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController zipCodeController = TextEditingController();

  @override
  void onInit() {
    isUpdateScreen = Get.arguments['isUpdateScreen'];
    if (isUpdateScreen) {
      setData();
    } else {
      cityViewModel.authController.resetValues();
    }
    super.onInit();
  }

  @override
  void onClose() {
    fullNameController.dispose();
    phoneController.dispose();
    addressController.dispose();
    zipCodeController.dispose();
    super.onClose();
  }

  setData() {
    userModel = Get.arguments['model'];
    fullNameController.text = userModel.name ?? '';
    phoneController.text = userModel.phone ?? '';
    addressController.text = userModel.address ?? '';
    zipCodeController.text = userModel.zipCode ?? '';

    if (userModel.city?.id != null) {
      cityViewModel.authController.selectedCity.value = userModel.city!;
    }
    if (userModel.country?.id != null) {
      cityViewModel.authController.selectedCountry.value = userModel.country!;
    }
  }

  void addShippingAddress() {
    if (shippingAddressFormKey.currentState?.validate() ?? false) {
      if (cityViewModel.authController.selectedCity.value.id == null &&
          cityViewModel.authController.selectedCity.value.id == null) {
        AppConstant.displaySnackBar(
            langKey.errorTitle.tr, langKey.plzSelectCountry.tr);
        return;
      }

      Map<String, dynamic> param = {
        "name": fullNameController.text,
        "address": addressController.text,
        "phoneNumber": phoneController.text,
        "zipCode": zipCodeController.text,
        "countryId":
            cityViewModel.authController.selectedCountry.value.id?.toString() ??
                '',
        "cityId":
            cityViewModel.authController.selectedCity.value.id?.toString() ?? ''
      };

      GlobalVariable.showLoader.value = true;

      ApiBaseHelper()
          .postMethod(
              url: Urls.addShippingDetails,
              body: param,
              withAuthorization: true)
          .then((parsedJson) {
        GlobalVariable.showLoader.value = false;

        if (parsedJson['success'] == true &&
            parsedJson['message'] == 'Shipping details added successfully') {
          Get.back();
          ChangeAddressViewModel changeAddressViewModel = Get.find();
          changeAddressViewModel.getAllAddress();
          CheckoutViewModel checkoutController = Get.find();
          checkoutController.getDefaultShippingAddress();
          AppConstant.displaySnackBar(
              langKey.success.tr, parsedJson['message']);
        } else {
          AppConstant.displaySnackBar(
            langKey.errorTitle.tr,
            parsedJson['message'],
          );
        }
      }).catchError((e) {
        print(e);
        GlobalVariable.showLoader.value = false;
      });
    }
  }

  void updateShippingAddress() {
    if (shippingAddressFormKey.currentState?.validate() ?? false) {
      Map<String, dynamic> param = {
        "id": userModel.id,
        "name": fullNameController.text,
        "address": addressController.text,
        "phoneNumber": phoneController.text,
        "zipCode": zipCodeController.text,
        "countryId":
            cityViewModel.authController.selectedCountry.value.id?.toString() ??
                '',
        "cityId":
            cityViewModel.authController.selectedCity.value.id?.toString() ?? ''
      };
      GlobalVariable.showLoader.value = true;

      ApiBaseHelper()
          .putMethod(
              url: Urls.updateShippingDetails,
              body: param,
              withAuthorization: true)
          .then((parsedJson) {
        GlobalVariable.showLoader.value = false;
        if (parsedJson['success'] == true &&
            parsedJson['message'] == 'Shipping details updated successfully') {
          Get.back();
          ChangeAddressViewModel changeAddressViewModel = Get.find();
          changeAddressViewModel.getAllAddress();
          CheckoutViewModel checkoutController = Get.find();
          checkoutController.getDefaultShippingAddress();
          AppConstant.displaySnackBar(
              langKey.success.tr, parsedJson['message']);
        } else {
          AppConstant.displaySnackBar(
            langKey.errorTitle.tr,
            parsedJson['message'],
          );
        }
      }).catchError((e) {
        print(e);
        GlobalVariable.showLoader.value = false;
      });
    }
  }
}
