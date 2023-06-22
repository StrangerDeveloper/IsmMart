import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http_parser/http_parser.dart';
import 'package:ism_mart/helper/api_base_helper.dart';
import 'package:ism_mart/exports/export_api_helper.dart';
import 'package:ism_mart/helper/global_variables.dart';
import 'package:ism_mart/helper/urls.dart';
import 'package:ism_mart/exports/exports_utils.dart';
import 'package:http/http.dart' as http;
import 'package:ism_mart/helper/languages/translations_key.dart' as langKey;
import 'package:ism_mart/screens/buyer_profile/buyer_profile_model.dart';

import '../../helper/errors.dart';
import '../../widgets/getx_helper.dart';
import '../buyer_profile/buyer_profile_viewmodel.dart';

class UpdateBuyerProfileViewModel extends GetxController {
  GlobalKey<FormState> buyerProfileFormKey = GlobalKey<FormState>();
  Rx<BuyerProfileModel> buyerProfileNewModel = BuyerProfileModel().obs;
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  Rx<File?> imageFile = File('').obs;

  @override
  void onInit() {
    setData();
    super.onInit();
  }

  @override
  void onClose() {
    GlobalVariable.showLoader.value = false;
    firstNameController.dispose();
    lastNameController.dispose();
    phoneController.dispose();
    addressController.dispose();
    super.onClose();
  }

  setData() {
    buyerProfileNewModel.value = Get.arguments['model'];
    firstNameController.text = buyerProfileNewModel.value.firstName ?? '';
    lastNameController.text = buyerProfileNewModel.value.lastName ?? '';
    phoneController.text = buyerProfileNewModel.value.phone ?? '';
    addressController.text = buyerProfileNewModel.value.address ?? '';
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
        Get.back();
        LocalStorageHelper.deleteUserData();
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

  updateData() async {
    if (buyerProfileFormKey.currentState?.validate() ?? false) {
      GlobalVariable.showLoader.value = true;

      Map<String, String> param = {
        "firstName": firstNameController.text,
        "lastName": lastNameController.text,
        "address": addressController.text,
        "phone": phoneController.text,
      };

      List<http.MultipartFile> fileList = [];
      if (imageFile.value?.path != '') {
        fileList.add(
          await http.MultipartFile.fromPath(
            'image',
            imageFile.value!.path,
            contentType: MediaType.parse('image/jpeg'),
          ),
        );
      }

      ApiBaseHelper()
          .patchMethodForImage(
          url: Urls.updateVendorData,
          withAuthorization: true,
          files: fileList,
          fields: param)
          .then((parsedJson) {
        GlobalVariable.showLoader.value = false;
        if (parsedJson['message'] == "User updated successfully") {
          Get.back();
          BuyerProfileViewModel viewModel = Get.find();
          viewModel.getData();
          AppConstant.displaySnackBar(
              langKey.success.tr, parsedJson['message']);
        } else {
          AppConstant.displaySnackBar(
              langKey.errorTitle.tr, parsedJson['message']);
        }
      }).catchError((e) {
        if (e == Errors.noInternetError) {
          GetxHelper.showSnackBar(
              title: 'Error', message: Errors.noInternetError);
        }
        GlobalVariable.showLoader.value = false;
        print(e);
      });
    }
  }
}
