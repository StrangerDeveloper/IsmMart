import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ism_mart/helper/api_base_helper.dart';
import 'package:ism_mart/helper/global_variables.dart';
import 'package:ism_mart/exports/export_controllers.dart';
import 'package:ism_mart/exports/exports_model.dart';
import 'package:ism_mart/exports/exports_utils.dart';
import 'package:http/http.dart' as http;
import 'package:ism_mart/helper/languages/translations_key.dart' as langKey;
import 'package:ism_mart/screens/vendor_profile/vendor_profile_viewmodel.dart';
import '../../api_helper/api_constant.dart';
import '../../api_helper/providers/auth_provider.dart';
import '../../helper/urls.dart';

class UpdateVendorProfileViewModel extends GetxController {
  final AuthProvider authProvider;

  UpdateVendorProfileViewModel(this.authProvider);

  Rx<UserModel> userModel1 = UserModel().obs;
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

  // RxString countryCode = '+92'.obs;
  RxInt cnic = 0.obs;
  RxString phone = "".obs;
  RxString shopCategoryName = ''.obs;
  RxBool clickOnPhoneField = false.obs;
  Rx<CategoryModel> selectedCategory = CategoryModel().obs;
  RxBool categoryErrorVisibility = false.obs;

  //TOO: getCountries and Cities
  var countries = <CountryModel>[].obs;
  var cities = <CountryModel>[].obs;
  var selectedCountry = CountryModel().obs;
  var selectedCity = CountryModel().obs;

  @override
  void onInit() async {
    await fetchCategories();
    await getCountries();
    getData();
    super.onInit();
  }

  //
  // //current user
  // getCurrentUser() async {
  //   GlobalVariable.showLoader.value=true;
  //   await ApiBaseHelper()
  //       .getMethod(url: 'user/profile', withAuthorization: true)
  //       .then((value) async {
  //     GlobalVariable.showLoader.value=false;
  //     if (value['success'] == true) {
  //       UserResponse userResponse = UserResponse.fromResponse(value);
  //       userResponse.userModel!.token = GlobalVariable.userModel!.token;
  //       shopAddressController.text=  value['data']['Vendor']['storeAddress'];
  //       shopDescController.text=  value['data']['Vendor']['storeDesc'];
  //       shopCategoryName.value=  value['data']['Vendor']['Category']['name'];
  //       print('Category Name: ${shopCategoryName.value}');
  //       final index = categoriesList.indexWhere((element) => element.name == shopCategoryName.value);
  //       print("Index: $index");
  //       selectedCategory.value = categoriesList[index];
  //
  //       print(selectedCategory.value.name);
  //       // cnic.value=  value['data']['Vendor']['ownerCnic'].toString();
  //       phoneNumberController.text=  value['data']['Vendor']['phone'];
  //       phone.value=value['data']['Vendor']['phone'];
  //       countryID.value=value['data']['Vendor']['country'];
  //       cityID.value=  value['data']['Vendor']['city'];
  //
  //
  //       GlobalVariable.userModel = userResponse.userModel;
  //       authController.setUserModel(userResponse.userModel);
  //       SettingViewModel settingViewModel = Get.find();
  //       settingViewModel.setUserModel(userResponse.userModel);
  //       baseController.changePage(0);
  //
  //       await LocalStorageHelper.storeUser(userModel: userResponse.userModel)
  //           .then((value) {});
  //     }
  //   });
  // }

  getData() async {
    userModel1.value = Get.arguments['model'];
    final index = categoriesList.indexWhere((element) =>
    element.name == userModel1.value.vendor?.categoryName?.name);
    shopNameController.text =
        userModel1.value.vendor!.storeName.toString();
    selectedCategory.value = categoriesList[index];
    shopAddressController.text = userModel1.value.vendor?.address ?? "";
    shopDescController.text = userModel1.value.vendor?.storeDesc ?? "";
    cnic.value = userModel1.value.vendor?.ownerCnic ?? 0;
    countryID.value = userModel1.value.vendor?.countryId ?? 0;
    cityID.value = userModel1.value.vendor?.cityId ?? 0;
    final countryIndex = countries.indexWhere((element) =>
    element.id == countryID.value);
    selectedCountry.value.id = countries[countryIndex].id;
    selectedCountry.value.name = countries[countryIndex].name;
    await getCitiesByCountry(countryId: countryID.value);
    final cityIndex = cities.indexWhere((element) =>
    element.id == cityID.value);
    selectedCity.value.id = cities[cityIndex].id;
    selectedCity.value.name = cities[cityIndex].name;
    phoneNumberController.text = userModel1.value.vendor?.phone ?? "";
    GlobalVariable.showLoader.value = false;
  }

  fetchCategories() async {
    GlobalVariable.showLoader.value = true;
    categoriesList.clear();
    categoriesList.insert(0, CategoryModel(name: 'Select Category', id: 0));
    await ApiBaseHelper().getMethod(url: 'category/all').then((parsedJson) {
      if (parsedJson['success'] == true) {
        GlobalVariable.internetErr(false);
        var parsedJsonData = parsedJson['data'] as List;
        categoriesList.addAll(
            parsedJsonData.map((e) => CategoryModel.fromJson(e)));
      }
    }).catchError((e) {
      GlobalVariable.showLoader.value = false;
      AppConstant.displaySnackBar(langKey.errorTitle.tr, e);
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
    }).catchError((e) {
      GlobalVariable.showLoader.value = false;
      AppConstant.displaySnackBar(langKey.errorTitle.tr, e);
      debugPrint(">>>>Countries: $e");
    });
  }

  getCitiesByCountry({required countryId}) async {
    cities.clear();
    authController.isLoading.value = true;
    cities.insert(0, CountryModel(name: "Select City", id: 0));
    await authProvider.getCities(countryId: countryId).then((data) {
      cities.addAll(data);
      authController.isLoading.value = false;
    }).catchError((e) {
      authController.isLoading.value = false;
      GlobalVariable.showLoader.value = false;
      AppConstant.displaySnackBar(langKey.errorTitle.tr, e);
      debugPrint(">>>>Cities: $e");
    });
  }

  updateData() async {
    if (vendorUpdateProfileFormKey.currentState?.validate() ?? false) {
      GlobalVariable.showLoader.value = true;

      Map<String, String> param = {
        "storeName": shopNameController.text,
        "category": "${shopCategoryId.value}",
        "phone": phoneNumberController.text,
        "country": "${countryID.value}",
        "city": "${cityID.value}",
        "storeDesc": shopDescController.text,
        'storeAddress': shopAddressController.text.toString(),
      };

      var headers = {
        'authorization': '${GlobalVariable.userModel!.token}',
        'Cookie': 'XSRF-token=${GlobalVariable.userModel!.token}'
      };
      var request = http.MultipartRequest(
          'POST', Uri.parse('${ApiConstant.baseUrl}/auth/vendor/register'));
      request.fields.addAll(param);
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();

      if (response.statusCode < 201 && response.statusCode > 199) {
        AppConstant.displaySnackBar(
          langKey.successTitle.tr,
          "Data Updated",
        );
        await getCurrentUser();
      }
      else {
        AppConstant.displaySnackBar(
          langKey.errorMsg.tr,
          "Data Failed To Update",
        );
        GlobalVariable.showLoader.value = false;
      }
    }
  }

  getCurrentUser()async{
    await ApiBaseHelper().getMethod(url: Urls.getAccountData, withAuthorization: true).then((value) {
      if(value['success'] == true && value['data'] != null){
        userModel1.value = UserModel.fromJson(value['data']);
        GlobalVariable.userModel = userModel1.value;
        VendorProfileViewModel vendorProfileViewModel = Get.find();
        vendorProfileViewModel.userModel.value = userModel1.value;
        GlobalVariable.showLoader.value = false;
        Get.back();
      }
    }).catchError((e){
      GlobalVariable.showLoader.value = false;
      AppConstant.displaySnackBar(langKey.errorTitle.tr, e);
    });
  }
}

