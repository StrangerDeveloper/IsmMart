import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:ism_mart/exports/exports_utils.dart';
import 'package:ism_mart/helper/api_base_helper.dart';
import 'package:ism_mart/helper/global_variables.dart';
import 'package:ism_mart/helper/languages/translations_key.dart' as langKey;
import 'package:ism_mart/helper/urls.dart';
import 'package:ism_mart/screens/buyer_profile/buyer_profile_model.dart';
import '../../controllers/controllers.dart';
import '../../helper/errors.dart';
import '../../models/user/country_city_model.dart';
import '../../widgets/getx_helper.dart';
import '../buyer_profile/buyer_profile_viewmodel.dart';

class UpdateBuyerProfileViewModel extends GetxController {
  GlobalKey<FormState> buyerProfileFormKey = GlobalKey<FormState>();
  Rx<BuyerProfileModel> buyerProfileNewModel = BuyerProfileModel().obs;
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  RxInt countryID = 0.obs;
  RxInt cityID = 0.obs;
  var selectedCountry = CountryModel().obs;
  var selectedCity = CountryModel().obs;
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

  setData() async {
    buyerProfileNewModel.value = Get.arguments['model'];
    firstNameController.text = buyerProfileNewModel.value.firstName ?? '';
    lastNameController.text = buyerProfileNewModel.value.lastName ?? '';
    phoneController.text = buyerProfileNewModel.value.phone ?? '';
    addressController.text = buyerProfileNewModel.value.address ?? '';
    if(buyerProfileNewModel.value.country != null){
      selectedCountry.value = buyerProfileNewModel.value.country!;
      countryID.value = buyerProfileNewModel.value.country!.id!;
      await cityViewModel.authController.getCitiesByCountry(countryId: countryID.value);
    }
    if(buyerProfileNewModel.value.city != null){
      selectedCity.value = buyerProfileNewModel.value.city!;
      cityID.value = buyerProfileNewModel.value.city!.id!;
    }
  }

  updateData() async {
    if (buyerProfileFormKey.currentState?.validate() ?? false) {
      GlobalVariable.showLoader.value = true;

      Map<String, String> param = {
        "firstName": firstNameController.text,
        "lastName": lastNameController.text,
        "address": addressController.text,
        "phone": phoneController.text,
        "country": "${countryID.value}",
        "city": "${cityID.value}",
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

      await ApiBaseHelper().patchMethodForImage(
              url: Urls.updateVendorData,
              withAuthorization: true,
              files: fileList,
              fields: param)
          .then((parsedJson) {
        GlobalVariable.showLoader.value = false;
        if (parsedJson['message'] == "User updated successfully") {
          cityViewModel.selectedCountry.value = CountryModel();
          cityViewModel.countryId.value = 0;
          cityViewModel.selectedCity.value = CountryModel();
          cityViewModel.cityId.value = 0;
          cityViewModel.authController.selectedCity.value = CountryModel();
          cityViewModel.authController.selectedCountry.value = CountryModel();
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
