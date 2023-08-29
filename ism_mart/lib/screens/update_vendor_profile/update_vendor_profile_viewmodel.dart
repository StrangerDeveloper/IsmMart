
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ism_mart/helper/api_base_helper.dart';
import 'package:ism_mart/helper/global_variables.dart';
import 'package:ism_mart/helper/urls.dart';
import 'package:ism_mart/exports/export_controllers.dart';
import 'package:ism_mart/exports/exports_model.dart';
import 'package:ism_mart/exports/exports_utils.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:ism_mart/helper/languages/translations_key.dart' as langKey;

import '../../api_helper/providers/auth_provider.dart';
import '../../widgets/pick_image.dart';
import '../vendor_profile/vendor_profile_viewmodel.dart';

class UpdateVendorProfileViewModel extends GetxController {
  final AuthProvider authProvider;
  UpdateVendorProfileViewModel(this.authProvider);
  Rx<UserModel?> userModel1 = UserModel().obs;
  RxInt shopCategoryId = 0.obs;
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
  Rxn phoneErrorText = Rxn<String>();
  RxString countryCode = '+92'.obs;
  Rx<CategoryModel> selectedCategory = CategoryModel().obs;
  RxBool categoryErrorVisibility = false.obs;




  getData1() async{
    userModel1.value = GlobalVariable.userModel;
   await fetchCategories();
   await getCountries();
    shopNameController.text =
        userModel1.value!.vendor!.storeName.toString() ?? "";
    shopCategoryId.value =
        int.parse(userModel1.value!.vendor!.category.toString() ?? "");


    //we will call api of categories and assign this list to current index by get current user category
   // selectedCategory.value.id=shopCategoryId.value;
    selectedCategory.value.id=shopCategoryId.value;
    selectedCategory.value.name=categoriesList[shopCategoryId.value].name;
    shopAddressController.text =
        userModel1.value!.vendor!.address.toString() ?? "Empity";
    shopDescController.text =
        userModel1.value!.vendor!.storeDesc.toString() ?? "";
    phoneNumberController.text =
        userModel1.value!.vendor!.phone.toString() ?? "";
    ownerCnicController.text =
        userModel1.value!.vendor!.ownerCnic.toString() ?? "";

    //country value assign
    countryID.value= userModel1.value!.vendor!.countryId?? 0;
    selectedCountry.value.id=countryID.value;
    selectedCountry.value.name=countries[countryID.value].name;
    await  getCitiesByCountry(countryId: countryID.value);
    cityID.value= userModel1.value!.vendor!.cityId?? 0;
    selectedCity.value.id=userModel1.value!.vendor!.cityId;
var cityNameById =cities.where((id) => (id.id  == cityID.value)).toList();
    selectedCity.value.name=cityNameById[0].name;
    cityViewModel.selectedCity.value = CountryModel();

    print("curent user cityyy ----- ${    selectedCity.value.name} ");
    print("curent user cityyy   ${cityID.value}----- ${selectedCity.value.id}");



  }



  @override
  void onInit() async{
    getData1();
    await authController.getCountries();
    super.onInit();
  }




   fetchCategories() async {
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
      //  GlobalVariable.internetErr(true);
      print(e);
    });
  }

  //TOO: getCountries and Cities
  var countries = <CountryModel>[].obs;
  var cities = <CountryModel>[].obs;
  var selectedCountry = CountryModel().obs;
  var selectedCity = CountryModel().obs;


  getCountries() async {
    countries.clear();
    countries.insert(0, CountryModel(name: "Select Country", id: 0));
    await authProvider.getCountries().then((data) {
      countries.addAll(data);
      cities.insert(0, CountryModel(name: "Select City", id: 0));
    }).catchError((error) {
      debugPrint(">>>>Countries: $error");
    });
  }

  getCitiesByCountry({required countryId}) async {
    cities.clear();
    cities.insert(0, CountryModel(name: "Select City", id: 0));
    await authProvider.getCities(countryId: countryId).then((data) {
      cities.addAll(data);
    }).catchError((error) {
      debugPrint(">>>>Cities: $error");
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
          "ownerCnic": ownerCnicController.text,
          "storeDesc": shopDescController.text,
          'cnicFront': cnicFrontImage.value,
          'cnicBack': cnicBackImage.value,
          'storeImage': shopLogoImage.value,
          'address': shopAddressController.text,
        };

        if(ntnController.text.isNotEmpty){
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