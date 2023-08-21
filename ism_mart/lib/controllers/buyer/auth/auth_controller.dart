import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ism_mart/exports/export_api_helper.dart';
import 'package:ism_mart/helper/global_variables.dart';
import 'package:ism_mart/exports/exports_model.dart';
import 'package:ism_mart/exports/exports_utils.dart';
import 'package:ism_mart/helper/languages/translations_key.dart' as langKey;

class AuthController extends GetxController {
  final AuthProvider authProvider;

  AuthController(this.authProvider);

  final emailVerificationFormKey = GlobalKey<FormState>();
  var forgotPasswordEmailController = TextEditingController();
  var newPasswordController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPassController = TextEditingController();

  var signUpEmailController = TextEditingController();
  var signUpPasswordController = TextEditingController();

  var firstNameController = TextEditingController();
  var otpController = TextEditingController();
  var phoneController = TextEditingController();

  var ownerNameController = TextEditingController();
  var storeNameController = TextEditingController();
  var storeDescController = TextEditingController();
  var bankNameController = TextEditingController();
  var bankAccController = TextEditingController();
  var bankHolderTitleController = TextEditingController();

  var editingTextController = TextEditingController();

  var showPasswordNotMatched = false.obs;

  @override
  void onInit() {
    super.onInit();
    getCurrentUser();
  }

  @override
  void onReady() {
    super.onReady();

    getCountries();

    getToken();
    LocalStorageHelper.localStorage.listenKey(LocalStorageHelper.currentUserKey,
        (value) {
      print(">>>Listening... currentUserKey");
      getToken();
    });
  }

  var _coinsModel = CoinsModel().obs;

  CoinsModel? get coinsModel => _coinsModel.value;

  fetchUserCoins() async {
    if (userToken!.isNotEmpty) {
      await authProvider
          .getUserCoins(token: userToken)
          .then((ApiResponse? apiResponse) {
        if (apiResponse != null) {
          if (apiResponse.success!) {
            var details = CoinsModel.fromJson(apiResponse.data);
            _coinsModel(details);
          }
        }
      }).catchError((error) {
        GlobalVariable.showLoader.value = false;
        print(">>>FetchUserCoins: $error");
      });
    }
  }

  var isLoading = false.obs;

  resendEmailVerificationLink() async {
    isLoading(false);
    String email = emailController.text;

    await authProvider
        .resendVerificationLink(email: email)
        .then((ApiResponse? response) {
      if (response != null) {
        if (response.success!) {
          Get.back();
          debugPrint("Email: ${response.toString()}");
          AppConstant.displaySnackBar(
              langKey.successTitle.tr, response.message);
        } else {
          AppConstant.displaySnackBar(langKey.errorTitle.tr, response.message);
        }
      } else
        AppConstant.displaySnackBar(
          langKey.errorTitle.tr,
          langKey.wrongWithCredentials.tr,
        );
    }).catchError((onError) {
      debugPrint("Verification Link Error: $onError");
    });
  }

//TO: Current User Info
  var _userModel = UserModel().obs;

  setUserModel(UserModel? userModel) => _userModel(userModel);

  UserModel? get userModel => _userModel.value;

  var _isSessionExpired = true.obs;

  bool? get isSessionExpired => _isSessionExpired.value;

  void setSession(bool? value) {
    _isSessionExpired.value = value!;
  }

  getCurrentUser() async {
    print("Auth Token: ${userToken}");
    if (userToken!.isNotEmpty) {
      isLoading(true);
      await authProvider
          .getCurrentUser(token: userToken)
          .then((apiResponse) async {
        isLoading(false);
        if (apiResponse.message != null &&
            apiResponse.message!
                .toLowerCase()
                .contains(AppConstant.SESSION_EXPIRED)) {
          var a = apiResponse.userModel!.imageUrl;
          print("image from current user $a");
          setSession(true);
        } else
          setSession(false);

        if (apiResponse.errors != null && apiResponse.errors!.isNotEmpty) {
          setUserModel(UserModel(error: apiResponse.errors!.first));
        } else {
          setUserModel(apiResponse.userModel!);
          GlobalVariable.userModel = apiResponse.userModel;
        }
      }).catchError((error) {
        isLoading(false);
        //if invalid users received
        // LocalStorageHelper.storeUser(userModel: userModel);
        setSession(true);
      });
    } else {
      GlobalVariable.internetErr(false);
      setSession(true);
    }
  }

  updateUserEmailVerification({UserModel? fromApi, UserModel? stored}) async {
    if (fromApi!.emailVerified != stored!.emailVerified) {
      await LocalStorageHelper.deleteUserData();
      await LocalStorageHelper.storeUser(userModel: fromApi);
      GlobalVariable.userModel = fromApi;
    }
    setUserModel(fromApi);
  }

  var currUserToken = "".obs;

  setCurrUserToken(token) {
    currUserToken.value = token;
  }

  String? get userToken => currUserToken.value;

  //String? get userToken => "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjQ4LCJpYW0iOiJ2ZW5kb3IiLCJ2aWQiOjQzLCJpYXQiOjE2NzgwNzY4MTE2MjcsImV4cCI6MTY3ODI0OTYxMTYyN30.eWj8W9zsP_mDBf81ho08HGmtwz8ufDpKUP2YBghyCN8";

  getToken() async {
    await LocalStorageHelper.getStoredUser().then((user) async {
      currUserToken.value = user.token ?? '';

      await getCurrentUser();
      await fetchUserCoins();
    }).onError((error, stackTrace) {
      print(">>>Token: $error, $stackTrace");
    });

    //update();
  }

  emailVerificationCheck() async {
    await getToken();
    if (userToken == null || userToken == '') {
      Get.toNamed(Routes.loginRoute);
    } else {
      if (userModel!.emailVerified == null ||
          userModel!.emailVerified == false) {
        String? verificationDetails =
            await LocalStorageHelper.getEmailVerificationDetails();
        if (verificationDetails != null) {
          DateTime linkTime = DateTime.parse(verificationDetails);
          DateTime currentTime = DateTime.now();
          DateTime fiveMinutesCheck =
              currentTime.subtract(Duration(minutes: 5));
          if (fiveMinutesCheck.isAfter(linkTime)) {
            LocalStorageHelper.localStorage.remove('emailVerificationTime');
            Get.toNamed(Routes.emailVerificationLinkRoute);
          } else {
            showSnackBar(
                title: 'Verify Email',
                message:
                    'An Email Verification link has already been sent to your email');
          }
        } else {
          Get.toNamed(Routes.emailVerificationLinkRoute);
        }
      } else {
        Get.toNamed(Routes.checkOutRoute);
      }
    }
  }

  //TOO: getCountries and Cities
  var countries = <CountryModel>[].obs;
  var cities = <CountryModel>[].obs;
  var selectedCountry = CountryModel().obs;
  var selectedCity = CountryModel().obs;
  RxBool newAcc = false.obs;

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
    isLoading(true);
    cities.clear();
    cities.insert(0, CountryModel(name: "Select City", id: 0));
    await authProvider.getCities(countryId: countryId).then((data) {
      cities.addAll(data);
      isLoading(false);
    }).catchError((error) {
      isLoading(false);
      debugPrint(">>>>Cities: $error");
    });
  }

  resetValues() {
    selectedCountry.value = CountryModel(name: "Select Country", id: 0);
    selectedCity.value = CountryModel(name: "Select City", id: 0);
  }

  void showSnackBar({title = 'error', message = 'Something went wrong'}) {
    AppConstant.displaySnackBar(title, message);
  }

  clearContactUsControllers() {
    firstNameController.clear();
    emailController.clear();
  }

  clearForgotPasswordControllers() {
    newPasswordController.clear();
    passwordController.clear();
    forgotPasswordEmailController.clear();
    otpController.clear();
    confirmPassController.clear();
  }

  clearBankControllers() {
    bankNameController.clear();
    bankHolderTitleController.clear();
    bankAccController.clear();
  }

  @override
  void onClose() {
    super.onClose();
    clearForgotPasswordControllers();
  }
}
