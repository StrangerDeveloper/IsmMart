import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http_parser/http_parser.dart';
import 'package:ism_mart/api_helper/api_base_helper.dart';
import 'package:ism_mart/api_helper/export_api_helper.dart';
import 'package:ism_mart/api_helper/global_variables.dart';
import 'package:ism_mart/api_helper/urls.dart';
import 'package:ism_mart/screens/buyer_profile_new/buyer_profile_new_model.dart';
import 'package:ism_mart/utils/exports_utils.dart';
import 'package:http/http.dart' as http;

class BuyerProfileViewModel extends GetxController {
  GlobalKey<FormState> buyerProfileFormKey = GlobalKey<FormState>();
  Rx<BuyerProfileNewModel> buyerProfileNewModel = BuyerProfileNewModel().obs;
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  Rx<File?> imageFile = File('').obs;

  @override
  void onClose() {
    GlobalVariable.showLoader.value = false;
    firstNameController.dispose();
    lastNameController.dispose();
    phoneController.dispose();
    addressController.dispose();
    super.onClose();
  }

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
      if (parsedJson['success'] == true && parsedJson['data'] != null) {
        buyerProfileNewModel.value =
            BuyerProfileNewModel.fromJson(parsedJson['data']);
        firstNameController.text = buyerProfileNewModel.value.firstName ?? '';
        lastNameController.text = buyerProfileNewModel.value.lastName ?? '';
        phoneController.text = buyerProfileNewModel.value.phone ?? '';
        addressController.text = buyerProfileNewModel.value.address ?? '';
      } else {
        AppConstant.displaySnackBar(errorTitle.tr, recordDoNotExist.tr);
      }
    }).catchError((e) {
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
      Get.back();
      LocalStorageHelper.deleteUserData();
      GlobalVariable.showLoader.value = false;
      if (parsedJson['success'] == true && parsedJson['data'] != null) {
        AppConstant.displaySnackBar(successTitle.tr, recordDoNotExist.tr);
      } else {
        AppConstant.displaySnackBar(errorTitle.tr, recordDoNotExist.tr);
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
