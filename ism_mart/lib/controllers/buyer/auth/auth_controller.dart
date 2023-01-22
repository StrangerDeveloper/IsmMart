import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ism_mart/api_helper/export_api_helper.dart';
import 'package:ism_mart/models/exports_model.dart';
import 'package:ism_mart/utils/exports_utils.dart';

class AuthController extends GetxController {
  final AuthProvider authProvider;

  AuthController(this.authProvider);

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPassController = TextEditingController();

  var firstNameController = TextEditingController();
  var otpController = TextEditingController();
  var phoneController = TextEditingController();

  var ownerNameController = TextEditingController();
  var storeNameController = TextEditingController();
  var storeDescController = TextEditingController();

  var editingTextController = TextEditingController();

  var isPasswordMatched = false.obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    //getCurrentUser();
    //getToken();
    getCountries();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();

    getCurrentUser();
    getToken();

    LocalStorageHelper.localStorage.listenKey(LocalStorageHelper.currentUserKey,
        (value) {
      getCurrentUser();
      getToken();
    });
  }

  var isLoading = false.obs;

  login() async {
    isLoading(true);
    await authProvider
        .postLogin(
            email: emailController.text.toString(),
            password: passwordController.text.trim())
        .then((UserResponse? userResponse) async {
      isLoading(false);
      if (userResponse != null) {
        if (userResponse.success!) {
          Get.back();
          AppConstant.displaySnackBar("success", userResponse.message);
          await LocalStorageHelper.storeUser(userModel: userResponse.userModel)
              .then((value) {
            clearLoginController();
          });
        } else {
          AppConstant.displaySnackBar("error", userResponse.message);
        }
      } else {
        AppConstant.displaySnackBar(
            "error", "Something went wrong with credentials");
      }
    }).catchError((error) {
      isLoading(false);
      debugPrint("Error: $error");
    });
    //isLoading(false);
  }
  Future<void> forgotPasswordWithEmail()async{
    isLoading(false);
    String email = emailController.text.trim();
    await authProvider.forgotPassword(data: {"email": email})
    .then((UserResponse? response){
      if (response != null) {
        if (response.success!) {
          Get.back();
          debugPrint("Email: ${response.toString()}");
          AppConstant.displaySnackBar("success", response.message);
        } else {
          AppConstant.displaySnackBar("error", response.message);
        }
      } else
        AppConstant.displaySnackBar(
            "error", "Something went wrong with credentials");
    }).catchError((onError) {
      debugPrint("resetPassword: $onError");
    });
  }

   forgotPasswordOtp() async{
    isLoading(true);
    String email = emailController.text;
    String password = passwordController.text;
    String confirmPass = confirmPassController.text;
    String otp = otpController.text;
    await authProvider.forgotPasswordOtp(data: {
      "email": email, "token": otp, "password": password, "confirmPassword": confirmPass
    }).then((UserResponse? response) async{
      isLoading(false);
      if (response != null) {
        if (response.success!) {
          Get.back();
          debugPrint("Email: ${response.toString()}");
          AppConstant.displaySnackBar("success", response.message);
        } else {
          AppConstant.displaySnackBar("error", response.message);
        }
      } else
        AppConstant.displaySnackBar(
            "error", "Something went wrong with credentials");
    }).catchError((onError) {
      isLoading(false);
      debugPrint("resetPassword: $onError");
    });
  }

  resendEmailVerificationLink() async {
    isLoading(false);
    String email = emailController.text.trim();

    await authProvider
        .resendVerificationLink(email: email)
        .then((UserResponse? response) {
      if (response != null) {
        if (response.success!) {
          Get.back();
          debugPrint("Email: ${response.toString()}");
          AppConstant.displaySnackBar("success", response.message);
        } else {
          AppConstant.displaySnackBar("error", response.message);
        }
      } else
        AppConstant.displaySnackBar(
            "error", "Something went wrong with credentials");
    }).catchError((onError) {
      debugPrint("Verification Link Error: $onError");
    });
  }

  register() async {
    isLoading(true);

    UserModel newUser = UserModel(
        //firstName: firstNameController.text.trim(),
        //lastName: lastNameController.text.trim(),
        firstName: firstNameController.text.trim(),
        email: emailController.text.trim(),
        phone: phoneController.text.trim(),
        password: passwordController.text.trim());

    await authProvider
        .postRegister(userModel: newUser)
        .then((UserResponse? response) {
      isLoading(false);
      if (response != null) {
        if (response.success!) {
          Get.back();
          AppConstant.displaySnackBar("success", response.message);
          clearControllers();
        } else
          AppConstant.displaySnackBar('error', response.message);
      } else
        AppConstant.displaySnackBar('error', 'Something went wrong!');
    }).catchError((error) {
      isLoading(false);
      AppConstant.displaySnackBar('error', "something went wrong!");
    });
  }

  registerStore() async {
    isLoading(true);
    String storeName = storeNameController.text.trim();
    String storeDesc = storeDescController.text;
    String ownerName = ownerNameController.text.trim();
    if (userToken!.isNotEmpty) {
      await authProvider
          .postStoreRegister(
              token: userToken!,
              storeName: storeName,
              storeDesc: storeDesc,
              ownerName: ownerName,
              phone: userModel?.phone,
              websiteUrl: 'www.google.com')
          .then((UserResponse? userResponse) {
        isLoading(false);
        if (userResponse != null) {
          if (userResponse.success!) {
            Get.back();
            AppConstant.displaySnackBar("success", userResponse.message);
            clearStoreController();
            getCurrentUser();
          } else
            AppConstant.displaySnackBar('error', userResponse.message);
        } else
          AppConstant.displaySnackBar('error', "something went wrong!");
      }).catchError((error) {
        isLoading(false);
        debugPrint("RegisterStore: Error $error");
      });
    } else {
      isLoading(false);
      AppConstant.displaySnackBar('error', "Current User not found!");
    }
  }

//TODO: Current User Info
  var _userModel = UserModel().obs;

  setUserModel(UserModel? userModel) => _userModel(userModel);

  UserModel? get userModel => _userModel.value;

  var _isSessionExpired = true.obs;

  bool? get isSessionExpired => _isSessionExpired.value;

  void setSession(bool? value) {
    _isSessionExpired.value = value!;
  }

  getCurrentUser() async {
    await LocalStorageHelper.getStoredUser().then((user) async {
      if (user.token != null) {
        isLoading(true);
        await authProvider
            .getCurrentUser(token: user.token!)
            .then((userResponse) {
          isLoading(false);
          if (userResponse.message != null &&
              userResponse.message!.contains(ApiConstant.SESSION_EXPIRED)) {
            setSession(true);
          } else
            setSession(false);

          if (userResponse.errors != null && userResponse.errors!.isNotEmpty) {
            setUserModel(UserModel(error: userResponse.errors!.first));
          } else
            setUserModel(userResponse.userModel!);
        }).catchError((error) {
          isLoading(false);
          setSession(true);
          debugPrint(">>>GetCurrentUser: $error");
        });
      } else
        setSession(true);
    });

    debugPrint(
        ">>>GetCurrentUser: ${ApiConstant.SESSION_EXPIRED}: $isSessionExpired");
  }

  List getProfileData() {
    var profileData = [
      {
        "title": firstName.tr,
        "subtitle": userModel!.firstName ?? '',
        "icon": Icons.person_rounded,
      },
      {
        "title": lastName.tr,
        "subtitle": userModel!.lastName ?? '',
        "icon": Icons.person_rounded,
      },
      {
        "title": phone.tr,
        "subtitle": userModel!.phone ?? '',
        "icon": Icons.phone_iphone_rounded,
      },
      {
        "title": address.tr,
        "subtitle": userModel!.address ?? '',
        "icon": Icons.location_on_rounded
      },
    ];
    return profileData;
  }

  var _currUserToken = "".obs;

  String? get userToken => _currUserToken.value;

  getToken() async {
    await LocalStorageHelper.getStoredUser().then((user) {
      print("Auth Token: ${user.token}");
      _currUserToken(user.token);
    });
    update();
  }

  updateUser({title, value}) async {
    if (userToken != null) {
      isLoading(true);
      await authProvider
          .updateUser(token: userToken, title: title, value: value)
          .then((UserResponse? userResponse) {
        isLoading(false);
        if (userResponse != null) {
          if (userResponse.success!) {
            Get.back();
            AppConstant.displaySnackBar("success", userResponse.message);
            editingTextController.clear();
            getCurrentUser();
          } else
            AppConstant.displaySnackBar('error', userResponse.message);
        } else
          AppConstant.displaySnackBar('error', "something went wrong!");
      }).catchError((error) {
        isLoading(false);
        debugPrint("RegisterStore: Error $error");
      });
    }
  }

  //TODO: getCountries and Cities
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

  //END Current User

  clearControllers() {
    firstNameController.clear();
    otpController.clear();
    phoneController.clear();
  }

  clearLoginController() {
    passwordController.clear();
    emailController.clear();
  }

  clearStoreController() {
    ownerNameController.clear();
    storeNameController.clear();
    storeDescController.clear();
    phoneController.clear();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    clearControllers();
    clearLoginController();
    clearStoreController();
  }
}
