
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
  GlobalKey<FormState> vendorUpdateProfileFormKey = GlobalKey<FormState>();
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
  RxString cnic = "".obs;
  Rx<CategoryModel> selectedCategory = CategoryModel().obs;
  RxBool categoryErrorVisibility = false.obs;
  
  //TOO: getCountries and Cities
  var countries = <CountryModel>[].obs;
  var cities = <CountryModel>[].obs;
  var selectedCountry = CountryModel().obs;
  var selectedCity = CountryModel().obs;

  @override
  void onInit() async{
    GlobalVariable.showLoader(true);
    getData();
    await authController.getCountries();
    super.onInit();
  }
  
  getData() async{
    userModel1.value = GlobalVariable.userModel;
    if(userModel1.value ==null || userModel1.value!.vendor!.storeName!.isEmpty){
      GlobalVariable.showLoader.value=true;
    } else {
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
      cnic.value=  userModel1.value!.vendor!.ownerCnic.toString();

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

      GlobalVariable.showLoader.value=false;
    }
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

  Future<void> proceed() async{
    if (vendorUpdateProfileFormKey.currentState?.validate() ?? false) {
      if(checkImages() == true){
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
    }
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





  // updateData() async {
  //   if (buyerProfileFormKey.currentState?.validate() ?? false) {
  //     GlobalVariable.showLoader.value = true;
  //
  //     Map<String, String> param = {
  //       "firstName": firstNameController.text,
  //       "lastName": lastNameController.text,
  //       "address": addressController.text,
  //       "phone": phoneController.text,
  //     };
  //
  //     List<http.MultipartFile> fileList = [];
  //     if (imageFile.value?.path != '') {
  //       fileList.add(
  //         await http.MultipartFile.fromPath(
  //           'image',
  //           imageFile.value!.path,
  //           contentType: MediaType.parse('image/jpeg'),
  //         ),
  //       );
  //     }
  //
  //     ApiBaseHelper()
  //         .patchMethodForImage(
  //         url: Urls.updateVendorData,
  //         withAuthorization: true,
  //         files: fileList,
  //         fields: param)
  //         .then((parsedJson) {
  //       GlobalVariable.showLoader.value = false;
  //       if (parsedJson['message'] == "User updated successfully") {
  //         Get.back();
  //         BuyerProfileViewModel viewModel = Get.find();
  //         viewModel.getData();
  //         AppConstant.displaySnackBar(
  //             langKey.success.tr, parsedJson['message']);
  //       } else {
  //         AppConstant.displaySnackBar(
  //             langKey.errorTitle.tr, parsedJson['message']);
  //       }
  //     }).catchError((e) {
  //       if (e == Errors.noInternetError) {
  //         GetxHelper.showSnackBar(
  //             title: 'Error', message: Errors.noInternetError);
  //       }
  //       GlobalVariable.showLoader.value = false;
  //       print(e);
  //     });
  //   }
  // }
  //

}