import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ism_mart/helper/api_base_helper.dart';
import 'package:ism_mart/helper/global_variables.dart';
import 'package:ism_mart/helper/urls.dart';
import 'package:ism_mart/exports/export_controllers.dart';
import 'package:ism_mart/exports/exports_model.dart';
import 'package:ism_mart/exports/exports_utils.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:ism_mart/helper/languages/translations_key.dart' as langKey;

import '../vendor_profile/vendor_profile_viewmodel.dart';

class UpdateVendorProfileViewModel extends GetxController {

  bool isRegisterScreen = false;
  Rx<File?> profileImageFile = File('').obs;
  Rx<File?> coverImageFile = File('').obs;
  Rx<UserModel?> userModel = UserModel().obs;
  GlobalKey<FormState> updateVendorFormKey = GlobalKey<FormState>();
  TextEditingController ownerNameController = TextEditingController();
  TextEditingController storeNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController bankNameController = TextEditingController();
  TextEditingController accountTitleController = TextEditingController();
  TextEditingController accountNumberController = TextEditingController();

  @override
  void onInit() {
    isRegisterScreen = Get.arguments['isRegisterScreen'];
    super.onInit();
  }

  @override
  void onReady() {
    getData();
    super.onReady();
  }

  @override
  void onClose() {
    ownerNameController.dispose();
    storeNameController.dispose();
    phoneController.dispose();
    descriptionController.dispose();
    bankNameController.dispose();
    accountTitleController.dispose();
    accountNumberController.dispose();
    GlobalVariable.showLoader.value = false;
    super.onClose();
  }

  getData() {
    userModel.value = GlobalVariable.userModel;
    if (userModel.value != null) {
      ownerNameController.text = userModel.value?.vendor?.ownerName ?? '';
      storeNameController.text = userModel.value?.vendor?.storeName ?? '';
      phoneController.text = userModel.value?.vendor?.phone ?? '';
      descriptionController.text = userModel.value?.vendor?.storeDesc ?? '';
      bankNameController.text = userModel.value?.vendor?.bankName ?? '';
      accountTitleController.text = userModel.value?.vendor?.accountTitle ?? '';
      accountNumberController.text =
          userModel.value?.vendor?.accountNumber ?? '';
      log(userModel.value!.toJson().toString());

      if (userModel.value?.city?.id != null)
        cityViewModel.authController.selectedCity.value =
            userModel.value!.city!;

      if (userModel.value?.country?.id != null)
        cityViewModel.authController.selectedCountry.value =
            userModel.value!.country!;
    }
  }

  updateData() async {
    if (updateVendorFormKey.currentState?.validate() ?? false) {
      if (cityViewModel.authController.selectedCity.value.id == null) {
        AppConstant.displaySnackBar(langKey.errorTitle.tr, langKey.plzSelectCountry.tr);
        return;
      }
      GlobalVariable.showLoader.value = true;

      Map<String, String> param = {
        'storeName': storeNameController.text,
        'storeDesc': descriptionController.text,
        'phone': phoneController.text,
        'ownerName': ownerNameController.text,
        'premium': 'false',
        'membership': 'Free',
        'accountTitle': accountTitleController.text,
        'accountNumber': accountNumberController.text,
        'bankName': bankNameController.text,
        'cityId':
            cityViewModel.authController.selectedCity.value.id?.toString() ??
                '',
      };

      print(param);

      List<http.MultipartFile> fileList = [];
      if (profileImageFile.value?.path != '') {
        fileList.add(
          await http.MultipartFile.fromPath(
            'storeImage',
            profileImageFile.value!.path,
            contentType: MediaType.parse('image/jpeg'),
          ),
        );
      }
      if (coverImageFile.value?.path != '') {
        fileList.add(
          await http.MultipartFile.fromPath(
            'coverImage',
            coverImageFile.value!.path,
            contentType: MediaType.parse('image/jpeg'),
          ),
        );
      }

      ApiBaseHelper()
          .postMethodForImage(
              url: Urls.updateVendor,
              withAuthorization: true,
              files: fileList,
              fields: param)
          .then((parsedJson) async {
        GlobalVariable.showLoader.value = false;
        if (parsedJson['message'] == "Vendor profile created successfully") {
          AuthController controller = Get.find();
          await controller.getCurrentUser();
          if(!isRegisterScreen){
            VendorProfileViewModel vendorDetailViewModel = Get.find();
            vendorDetailViewModel.getData();
          }
          Get.back();
          AppConstant.displaySnackBar(langKey.success.tr, parsedJson['message']);
        } else {
          AppConstant.displaySnackBar(langKey.errorTitle.tr, parsedJson['message']);
        }
      }).catchError((e) {
        GlobalVariable.showLoader.value = false;
        print(e);
      });
    }
  }
}