import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ism_mart/helper/global_variables.dart';
import 'package:ism_mart/helper/languages/translations_key.dart' as langKey;

import '../../../helper/api_base_helper.dart';
import '../../../helper/routes.dart';
import '../../../widgets/pick_image.dart';
import '../../categories/model/category_model.dart';

class VendorSignUp2ViewModel extends GetxController{
  GlobalKey<FormState> vendorSignUp2FormKey = GlobalKey<FormState>();
  TextEditingController shopNameController = TextEditingController();
  TextEditingController shopAddressController = TextEditingController();
  TextEditingController ownerNameController = TextEditingController();
  TextEditingController ownerCnicController = TextEditingController();
  TextEditingController ntnController = TextEditingController();
  TextEditingController shopDescController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  List<CategoryModel> categoriesList = <CategoryModel>[].obs;
  RxInt countryID = 0.obs;
  RxString cnicFrontImage = ''.obs;
  RxString cnicBackImage = ''.obs;
  RxString shopLogoImage = ''.obs;
  RxBool cnicFrontErrorVisibility = false.obs;
  RxBool cnicBackErrorVisibility = false.obs;
  RxBool shopImageErrorVisibility = false.obs;
  RxBool countryErrorVisibility = false.obs;
  RxInt cityID = 0.obs;
  RxBool cityErrorVisibility = false.obs;
  RxInt shopCategoryId = 0.obs;
  Rxn phoneErrorText = Rxn<String>();
  RxString countryCode = '+92'.obs;
  Rx<CategoryModel> selectedCategory = CategoryModel().obs;
  RxBool categoryErrorVisibility = false.obs;

  @override
  void onInit() {
    fetchCategories();
    super.onInit();
  }

  void fetchCategories() async {
    categoriesList.clear();
    categoriesList.insert(0, CategoryModel(name: 'Select Category', id: 0));
    await ApiBaseHelper().getMethod(url: 'category/all').then((parsedJson) {
      if (parsedJson['success'] == true) {
        GlobalVariable.internetErr(false);
        var parsedJsonData = parsedJson['data'] as List;
        categoriesList
            .addAll(parsedJsonData.map((e) => CategoryModel.fromJson(e)));
      }
    }).catchError((e) {
      GlobalVariable.internetErr(true);
      print(e);
    });
  }

  selectImage(RxString imageVar, RxBool imageVisibilityVar)async{
    final image = await PickImage().pickSingleImage();
    if(image != null){
      imageVar.value = image.path;
      imageVisibilityVar.value = false;
    }
  }

  validatorPhoneNumber(String? value) {
    if (GetUtils.isBlank(value)!) {
      phoneErrorText.value = langKey.fieldIsRequired.tr;
    } else if (value!.length > 16 || value.length < 7) {
      phoneErrorText.value = langKey.phoneValidate.tr;
    } else {
      phoneErrorText.value = null;
    }
  }

  Future<void> proceed() async{
    if (vendorSignUp2FormKey.currentState?.validate() ?? false) {
      if(checkImages() == true && checkDropDowns() == true){
          GlobalVariable.showLoader.value = false;

          Map<String, String> details = {
            "storeName": shopNameController.text,
            "category": "${shopCategoryId.value}",
            "phone": countryCode.value + phoneNumberController.text,
            "country": "${countryID.value}",
            "city": "${cityID.value}",
            "ownerName": ownerNameController.text,
            "ownerCnic": ownerCnicController.text,
            "storeDesc": shopDescController.text,
            'cnicFront': cnicFrontImage.value,
            'cnicBack': cnicBackImage.value,
            'storeImage': shopLogoImage.value,
            'address': shopAddressController.text,
          };

          if(ntnController.text.isEmpty){
            details.addAll({
              'storeNtn': ntnController.text,
            });
          }
          Get.toNamed(Routes.vendorSignUp3, arguments: {
            'shopDetails': details
          });
      }
    } else{
      checkImages();
      checkDropDowns();
    }
  }

  checkDropDowns(){
    bool proceed1 = true;
    if(countryID.value == 0){
      countryErrorVisibility.value = true;
      proceed1 = false;
    }
    if(cityID.value == 0){
      cityErrorVisibility.value = true;
      proceed1 = false;
    }
    if(shopCategoryId.value == 0){
      categoryErrorVisibility.value = true;
      proceed1 = false;
    }
    return proceed1;
  }

  bool checkImages(){
    bool proceed2 = true;
    if(cnicFrontImage.value == ''){
      cnicFrontErrorVisibility.value = true;
      proceed2 = false;
    }
    if(cnicBackImage.value == ''){
      cnicBackErrorVisibility.value = true;
      proceed2 = false;
    }
    if(shopLogoImage.value == ''){
      shopImageErrorVisibility.value = true;
      proceed2 = false;
    }
    return proceed2;
  }
}