import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ism_mart/api_helper/export_api_helper.dart';
import 'package:ism_mart/models/exports_model.dart';
import 'package:ism_mart/utils/exports_utils.dart';
import 'package:ism_mart/utils/languages/translations_key.dart' as langKey;

class AuthController extends GetxController {
  final AuthProvider authProvider;

  AuthController(this.authProvider);

  var forgotPasswordEmailController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPassController = TextEditingController();

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

  var isPasswordMatched = false.obs;

  @override
  void onInit() {
    super.onInit();
    //getCurrentUser();
    //getToken();

    //getCurrentUser();
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
      //getCurrentUser();
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
        print(">>>FetchUserCoins: $error");
      });
    }
  }

  var isLoading = false.obs;

  login() async {
    print("email ${emailController.text} pass  ${passwordController.text}");
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
          AppConstant.displaySnackBar(
              langKey.successTitle.tr, userResponse.message);
          await LocalStorageHelper.storeUser(userModel: userResponse.userModel)
              .then((value) {
            clearLoginController();
          });
        } else {
          AppConstant.displaySnackBar(
              langKey.errorTitle.tr, userResponse.message);
        }
      } else {
        AppConstant.displaySnackBar(
          langKey.errorTitle.tr,
          langKey.wrongWithCredentials.tr,
        );
      }
    }).catchError((error) {
      isLoading(false);
      debugPrint("Error: $error");
    });
    //isLoading(false);
  }

  Future<bool?> forgotPasswordWithEmail() async {
    isLoading(false);
    String email = forgotPasswordEmailController.text.trim();

    await authProvider
        .forgotPassword(data: {"email": email}).then((ApiResponse? response) {
      isLoading(false);
      if (response != null) {
        if (response.success!) {
          //Get.back();
          AppConstant.displaySnackBar(
              langKey.successTitle.tr, response.message);
          return true;
        } else {
          AppConstant.displaySnackBar(langKey.errorTitle.tr, response.message);
        }
      } else
        AppConstant.displaySnackBar(
            langKey.errorTitle.tr, langKey.wrongWithCredentials.tr);
      return false;
    }).catchError((onError) {
      isLoading(false);
      debugPrint("resetPassword: $onError");
      return false;
    });
    return false;
  }

  forgotPasswordOtp() async {
    isLoading(true);
    String email = emailController.text;
    String password = passwordController.text;
    String confirmPass = confirmPassController.text;
    String otp = otpController.text;
    await authProvider.forgotPasswordOtp(data: {
      "email": email,
      "token": otp,
      "password": password,
      "confirmPassword": confirmPass
    }).then((ApiResponse? response) async {
      isLoading(false);
      if (response != null) {
        if (response.success!) {
          Get.back();
          debugPrint("Email: ${response.toString()}");
          AppConstant.displaySnackBar(
              langKey.successTitle.tr, response.message);
          passwordController.clear();
        } else {
          AppConstant.displaySnackBar(langKey.errorTitle.tr, response.message);
        }
      } else
        AppConstant.displaySnackBar(
            langKey.errorTitle.tr, langKey.wrongWithCredentials.tr);
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
        .then((ApiResponse? response) {
      if (response != null) {
        if (response.success!) {
          Get.back();
          clearLoginController();
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

  register() async {
    isLoading(true);

    UserModel newUser = UserModel(
      //firstName: firstNameController.text.trim(),
      //lastName: lastNameController.text.trim(),
      firstName: firstNameController.text.trim(),
      email: emailController.text.trim(),
      phone: phoneController.text.trim(),
      password: passwordController.text.trim(),
    );

    await authProvider
        .postRegister(userModel: newUser)
        .then((UserResponse? response) {
      isLoading(false);
      if (response != null) {
        if (response.success!) {
          //Get.back();
          AppConstant.displaySnackBar(
              langKey.successTitle.tr, response.message);
          //clearControllers();
        } else
          AppConstant.displaySnackBar(langKey.errorTitle.tr, response.message);
      } else
        AppConstant.displaySnackBar(
            langKey.errorTitle.tr, langKey.someThingWentWrong.tr);
    }).catchError((error) {
      isLoading(false);
      AppConstant.displaySnackBar(
          langKey.errorTitle.tr, langKey.someThingWentWrong.tr);
    });
  }

  registerStore(
      {SellerModel? updatedModel, bool? isCalledForUpdate = false}) async {
    isLoading(true);

    print(
        "!!!!controller profile ${updatedModel!.storeImage}  \n cover= ${coverImgPath.value}");

    SellerModel model = SellerModel(
      storeName: storeNameController.text,
      storeDesc: storeDescController.text,
      ownerName: ownerNameController.text,
      //storeImage: profileImgPath.value,
      //coverImage: coverImgPath.value,
      phone: phoneController.text,
      membership: "Free",
      premium: false,
      bankName: bankNameController.text,
      accountTitle: bankHolderTitleController.text,
      accountNumber: bankAccController.text,
    );

    model.storeImage =
        updatedModel.storeImage != null ? updatedModel.storeImage : "";

    // profileImgPath.value.isNotEmpty
    //     ? profileImgPath.value
    //     : updatedModel.storeImage;
    model.coverImage =
        updatedModel.coverImage != null ? updatedModel.coverImage : "";

    //  coverImgPath.value.isNotEmpty
    //     ? coverImgPath.value
    //     : updatedModel.coverImage;

    if (userToken!.isNotEmpty) {
      // UserModel user = UserModel(vendor: model);
      await authProvider
          .postStoreRegister(
              token: userToken!,
              calledForUpdate: isCalledForUpdate!,
              sellerModel: model,
              coverImagePath: coverImgPath.value,
              storeImagePath: profileImgPath.value)
          .then((UserResponse? apiResponse) {
        isLoading(false);
        if (apiResponse != null) {
          if (apiResponse.success!) {
            Get.back();
            AppConstant.displaySnackBar(
                langKey.successTitle.tr, apiResponse.message);
            clearStoreController();
            getCurrentUser();
          } else
            AppConstant.displaySnackBar(
                langKey.errorTitle.tr, apiResponse.message);
        } else
          AppConstant.displaySnackBar(
              langKey.errorTitle.tr, langKey.someThingWentWrong.tr);
      }).catchError((error) {
        isLoading(false);
        debugPrint("RegisterStore: Error $error");
      });
    } else {
      isLoading(false);
      AppConstant.displaySnackBar(
        langKey.errorTitle.tr,
        langKey.currentUserNotFound.tr,
      );
    }
  }

  var coverImgPath = "".obs;
  var profileImgPath = "".obs;
  var _picker = ImagePicker();

  pickOrCaptureImageGallery(int? imageSource, {calledForProfile = true}) async {
    await PermissionsHandler().checkPermissions().then((isGranted) async {
      if (isGranted) {
        try {
          XFile? imgFile = await _picker.pickImage(
              source:
                  imageSource == 0 ? ImageSource.camera : ImageSource.gallery);
          if (imgFile != null) {
            await imgFile.length().then((length) async {
              await AppConstant.compressImage(imgFile.path, fileLength: length)
                  .then((compressedFile) {
                var lengthInMb = compressedFile.lengthSync() * 0.000001;
                if (lengthInMb > 2) {
                  showSnackBar(message: langKey.imageSizeDesc.tr + ' 2MB');
                } else {
                  if (calledForProfile) {
                    profileImgPath(compressedFile.path);
                  } else
                    coverImgPath(compressedFile.path);
                }
                Get.back();
              });
            });
          }
        } catch (e) {
          print("UploadImage: $e");
        }
      } else
        await PermissionsHandler().requestPermissions();
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
          setSession(true);
        } else
          setSession(false);

        if (apiResponse.errors != null && apiResponse.errors!.isNotEmpty) {
          setUserModel(UserModel(error: apiResponse.errors!.first));
        } else
          setUserModel(apiResponse.userModel!);
      }).catchError((error) {
        isLoading(false);
        setSession(true);
      });
    } else
      setSession(true);
  }

  updateUserEmailVerification({UserModel? fromApi, UserModel? stored}) async {
    if (fromApi!.emailVerified != stored!.emailVerified) {
      await LocalStorageHelper.deleteUserData();
      await LocalStorageHelper.storeUser(userModel: fromApi);
    }
    setUserModel(fromApi);
  }

  List getProfileData() {
    var profileData = [
      {
        "title": firstName.tr,
        "subtitle": userModel!.firstName ?? '',
        "icon": Icons.person_rounded,
        "field": "firstName",
      },
      {
        "title": lastName.tr,
        "subtitle": userModel!.lastName ?? '',
        "icon": Icons.person_rounded,
        "field": "lastName"
      },
      {
        "title": phone.tr,
        "subtitle": userModel!.phone ?? '',
        "icon": Icons.phone_iphone_rounded,
        "field": "phone",
      },
      {
        "title": address.tr,
        "subtitle": userModel!.address ?? '',
        "icon": Icons.location_on_rounded,
        "field": "address",
      },
      {
        "title": country.tr,
        "subtitle": userModel!.country?.name ?? '',
        "icon": Icons.language_rounded,
      },
      {
        "title": city.tr,
        "subtitle": userModel!.city?.name ?? '',
        "icon": Icons.villa_rounded,
      },
    ];
    return profileData;
  }

  List getStoreInfo() {
    return [
      {
        "title": storeName.tr,
        "subtitle": userModel!.vendor?.storeName ?? '',
        "icon": Icons.storefront,
      },
      {
        "title": phone.tr,
        "subtitle": userModel!.vendor?.phone ?? '',
        "icon": Icons.phone_iphone_rounded,
      },
      {
        "title": description.tr,
        "subtitle": userModel!.vendor?.storeDesc ?? '',
        "icon": Icons.info_outlined,
      },
    ];
  }

  List getBankDetails() {
    return [
      {
        "title": bankName.tr,
        "subtitle": userModel!.vendor?.bankName ?? '',
        "icon": Icons.account_balance_rounded,
      },
      {
        "title": bankAccountHolder.tr,
        "subtitle": userModel!.vendor?.accountTitle ?? '',
        "icon": Icons.person_rounded,
      },
      {
        "title": bankAccount.tr,
        "subtitle": userModel!.vendor?.accountNumber ?? '',
        "icon": Icons.account_balance_wallet_rounded,
      },
    ];
  }

  var _currUserToken = "".obs;

  setCurrUserToken(token) {
    _currUserToken.value = token;
  }

  String? get userToken => _currUserToken.value;

  //String? get userToken => "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjQ4LCJpYW0iOiJ2ZW5kb3IiLCJ2aWQiOjQzLCJpYXQiOjE2NzgwNzY4MTE2MjcsImV4cCI6MTY3ODI0OTYxMTYyN30.eWj8W9zsP_mDBf81ho08HGmtwz8ufDpKUP2YBghyCN8";

  getToken() async {
    await LocalStorageHelper.getStoredUser().then((user) async {
      _currUserToken.value = user.token ?? '';

      getCurrentUser();
      await fetchUserCoins();
    }).onError((error, stackTrace) {
      print(">>>Token: $error, $stackTrace");
    });

    //update();
  }

  updateUser({title, value, field}) async {
    if (userToken != null) {
      isLoading(true);
      await authProvider
          .updateUser(
              token: userToken, title: title, value: value, field: field)
          .then((UserResponse? userResponse) {
        isLoading(false);
        if (userResponse != null) {
          if (userResponse.success!) {
            Get.back();
            AppConstant.displaySnackBar(
                langKey.successTitle.tr, userResponse.message);
            editingTextController.clear();
            getCurrentUser();
          } else
            AppConstant.displaySnackBar(
                langKey.errorTitle.tr, userResponse.message);
        } else
          AppConstant.displaySnackBar(
              langKey.errorTitle.tr, langKey.someThingWentWrong.tr);
      }).catchError((error) {
        isLoading(false);
        debugPrint("RegisterStore: Error $error");
      });
    }
  }

  deActivateAccount() async {
    if (userToken != null) {
      isLoading(true);
      await authProvider
          .deActivateUser(token: userToken)
          .then((ApiResponse? response) {
        //isLoading(false);
        if (response != null) {
          if (response.success!) {
            Get.back();
            LocalStorageHelper.deleteUserData();
            AppConstant.displaySnackBar(
                langKey.errorTitle.tr, response.message);
          } else
            AppConstant.displaySnackBar(
                langKey.errorTitle.tr, response.message);
        } else
          AppConstant.displaySnackBar(
              langKey.errorTitle.tr, langKey.someThingWentWrong.tr);
      }).catchError((error) {
        isLoading(false);
        debugPrint("deActivateAccount: Error $error");
      });
    }
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

  ///Contact us
  var subjectController = TextEditingController();

  postContactUs() async {
    isLoading(true);
    var data = {
      "name": "${firstNameController.text}",
      "email": "${emailController.text.trim()}",
      "subject": "${subjectController.text}",
      "message": "${storeDescController.text}"
    };
    await authProvider.contactUs(data: data).then((ApiResponse? apiResponse) {
      if (apiResponse != null) {
        if (apiResponse.success!) {
          // Get.back();
          AppConstant.displaySnackBar(
              langKey.successTitle.tr, apiResponse.message);
          clearContactUsControllers();
        } else
          AppConstant.displaySnackBar(
              langKey.errorTitle.tr, apiResponse.message);
      } else
        AppConstant.displaySnackBar(
            langKey.errorTitle.tr, langKey.someThingWentWrong.tr);
    }).catchError((e) {
      isLoading(false);
      AppConstant.displaySnackBar(langKey.errorTitle.tr, "$e");
    });
  }

  void showSnackBar({title = 'error', message = 'Something went wrong'}) {
    AppConstant.displaySnackBar(title, message);
  }

  clearContactUsControllers() {
    firstNameController.clear();
    emailController.clear();
    subjectController.clear();
    storeDescController.clear();
  }

  clearControllers() {
    firstNameController.clear();
    otpController.clear();
    phoneController.clear();
    passwordController.clear();
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
    coverImgPath(null);
    profileImgPath(null);

    clearBankControllers();
  }

  clearBankControllers() {
    bankNameController.clear();
    bankHolderTitleController.clear();
    bankAccController.clear();
  }

  @override
  void onClose() {
    super.onClose();
    clearControllers();
    clearLoginController();
    clearStoreController();
  }
}
