import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
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
    getCountries();

    getCurrentUser();
    getToken();
  }

  @override
  void onReady() {
    super.onReady();

    LocalStorageHelper.localStorage.listenKey(LocalStorageHelper.currentUserKey,
        (value) {
      getToken();
      getCurrentUser();
    });

    fetchUserCoins();
  }

  var _coinsModel = CoinsModel().obs;

  CoinsModel? get coinsModel => _coinsModel.value;

  fetchUserCoins() async {
    await authProvider
        .getUserCoins(token: userToken)
        .then((CoinsResponse? coinsResponse) {
      if (coinsResponse != null) {
        if (coinsResponse.success!) {
          _coinsModel(coinsResponse.coinsModel!);
        }
      }
    }).catchError((error) {
      print(">>>FetchUserCoins: $error");
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

  Future<void> forgotPasswordWithEmail() async {
    isLoading(false);
    String email = emailController.text.trim();
    await authProvider
        .forgotPassword(data: {"email": email}).then((UserResponse? response) {
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
    }).then((UserResponse? response) async {
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
    SellerModel model = SellerModel(
      storeName: storeNameController.text.trim(),
      storeDesc: storeDescController.text,
      ownerName: ownerNameController.text.trim(),
      storeImage: profileImgPath.value,
      coverImage: coverImgPath.value,
      phone: phoneController.text.trim(),
      membership: "Free",
      premium: false,
      bankName: bankNameController.text.trim(),
      accountTitle: bankHolderTitleController.text.trim(),
      accountNumber: bankAccController.text.trim(),
    );
    if (userToken!.isNotEmpty) {
      await authProvider
          .postStoreRegister(token: userToken!, sellerModel: model)
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
                  showSnackBar(message: 'Image must be up to 2MB');
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
    }).catchError((e) {
      isLoading(false);
      print(">>>GetCurrentUser $e");
    });
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

  String? get userToken => _currUserToken.value;

  getToken() async {
    await LocalStorageHelper.getStoredUser().then((user) {
      print("Auth Token: ${user.token}");
      _currUserToken(user.token);
      isLoading(false);
    }).onError((error, stackTrace) {
      isLoading(false);
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

  deActivateAccount() async {
    if (userToken != null) {
      isLoading(true);
      await authProvider
          .deActivateUser(token: userToken)
          .then((UserResponse? response) {
        //isLoading(false);
        if (response != null) {
          if (response.success!) {
            Get.back();
            LocalStorageHelper.deleteUserData();
            AppConstant.displaySnackBar("error", response.message);
          } else
            AppConstant.displaySnackBar("error", response.message);
        } else
          AppConstant.displaySnackBar('error', "something went wrong!");
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
    var data = {
      "name": "${firstNameController.text}",
      "email": "${emailController.text.trim()}",
      "subject": "${subjectController.text}",
      "message": "${storeDescController.text}"
    };

    await authProvider.contactUs(data: data).then((UserResponse? userResponse) {
      if (userResponse != null) {
        if (userResponse.success!) {
          // Get.back();
          AppConstant.displaySnackBar("success", userResponse.message);
          clearContactUsControllers();
        } else
          AppConstant.displaySnackBar('error', userResponse.message);
      } else
        AppConstant.displaySnackBar('error', "something went wrong!");
    }).catchError((e) {
      AppConstant.displaySnackBar('error', "$e");
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
