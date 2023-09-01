import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ism_mart/helper/api_base_helper.dart';
import 'package:ism_mart/helper/global_variables.dart';
import 'package:ism_mart/exports/export_controllers.dart';
import 'package:ism_mart/exports/exports_model.dart';
import 'package:ism_mart/exports/exports_utils.dart';
import 'package:http/http.dart' as http;
import 'package:ism_mart/helper/languages/translations_key.dart' as langKey;
import '../../api_helper/api_constant.dart';
import '../../api_helper/local_storage/local_storage_helper.dart';
import '../../api_helper/providers/auth_provider.dart';
import '../setting/settings_viewmodel.dart';

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
  RxString phone = "".obs;
  RxBool clickOnPhoneField = false.obs;
  Rx<CategoryModel> selectedCategory = CategoryModel().obs;
  RxBool categoryErrorVisibility = false.obs;

  getData1() async {
    userModel1.value = GlobalVariable.userModel;
    await getCurrentUser();

    GlobalVariable.showLoader.value = false;
    await fetchCategories();
    await getCountries();
    shopNameController.text = userModel1.value!.vendor!.storeName.toString();
    //we will call api of categories and assign this list to current index by get current user category
    int _catid = shopCategoryId.value;
    selectedCategory.value.id = shopCategoryId.value;
    selectedCategory.value.name = categoriesList[_catid].name;
    cnic.value = userModel1.value!.vendor!.ownerCnic.toString();

    //country value assign
    int _cid = countryID.value;
    selectedCountry.value.id = countryID.value;
    selectedCountry.value.name = countries[_cid].name;

    int _cityid = countryID.value;
    await getCitiesByCountry(countryId: _cityid);
    var cityNameById = cities.where((id) => (id.id == cityID.value)).toList();
    selectedCity.value.id = cityNameById[0].id;
    selectedCity.value.name = cityNameById[0].name;
    print(
        "city id ===== $_cityid   ${selectedCity.value.id} ${selectedCity.value.name}");

    //cityViewModel.selectedCity.value = CountryModel();

    print("curent user cityyy ----- ${selectedCity.value.name} ");
    print("curent user cityyy   ${cityID.value}----- ${selectedCity.value.id}");
  }

  @override
  void onInit() async {
    //  GlobalVariable.showLoader(true);
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

  validatorPhoneNumber(String? value) {
    if (GetUtils.isBlank(value)!) {
      phoneErrorText.value = langKey.fieldIsRequired.tr;
    } else if (value!.length > 16 || value.length < 7) {
      phoneErrorText.value = langKey.phoneValidate.tr;
    } else {
      phoneErrorText.value = null;
    }
  }

  updateData() async {
    GlobalVariable.showLoader(true);
    print("${GlobalVariable.userModel?.token}");
    if (vendorUpdateProfileFormKey.currentState?.validate() ?? false) {
      GlobalVariable.showLoader.value = true;

      Map<String, String> param = {
        "storeName": shopNameController.text,
        "category": "${shopCategoryId.value}",
        "phone": countryCode.value + phoneNumberController.text,
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

      if (response.statusCode < 201) {
        AppConstant.displaySnackBar(
          langKey.successTitle.tr,
          "Data Updated",
        );
        //var data =await http.Response.fromStream(response);
        //var a = jsonDecode(data.body);
        GlobalVariable.showLoader.value = false;
        print(await response.stream.bytesToString());
      } else {
        AppConstant.displaySnackBar(
          langKey.errorMsg.tr,
          "Data Failed To Update",
        );
        GlobalVariable.showLoader.value = false;
        print(response.reasonPhrase);
      }
    }
  }

//current user
  getCurrentUser() async {
    GlobalVariable.showLoader.value = true;
    await ApiBaseHelper()
        .getMethod(url: 'user/profile', withAuthorization: true)
        .then((value) async {
      GlobalVariable.showLoader.value = false;
      if (value['success'] == true) {
        UserResponse userResponse = UserResponse.fromResponse(value);
        userResponse.userModel!.token = GlobalVariable.userModel!.token;
        shopAddressController.text = value['data']['Vendor']['storeAddress'];
        shopDescController.text = value['data']['Vendor']['storeDesc'];
        shopCategoryId.value = value['data']['Vendor']['category'];
        cnic.value = value['data']['Vendor']['ownerCnic'].toString();
        phoneNumberController.text = value['data']['Vendor']['phone'];
        phone.value = value['data']['Vendor']['phone'];
        countryID.value = value['data']['Vendor']['country'];
        cityID.value = value['data']['Vendor']['city'];
        print(
            "cat id------------ ${cityID.value} ==  ${value['data']['Vendor']['city']}");

        GlobalVariable.userModel = userResponse.userModel;
        authController.setUserModel(userResponse.userModel);
        SettingViewModel settingViewModel = Get.find();
        settingViewModel.setUserModel(userResponse.userModel);
        baseController.changePage(0);

        await LocalStorageHelper.storeUser(userModel: userResponse.userModel)
            .then((value) {});
      }
    });
  }
}
