import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ism_mart/controllers/controllers.dart';
import 'package:ism_mart/exports/exports_model.dart';
import 'package:ism_mart/helper/api_base_helper.dart';
import 'package:ism_mart/helper/global_variables.dart';
import 'package:ism_mart/helper/urls.dart';
import 'package:ism_mart/exports/exports_utils.dart';
import 'package:ism_mart/helper/languages/translations_key.dart' as langKey;
import 'package:firebase_auth/firebase_auth.dart';

class SignUpViewModel extends GetxController {
  GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  RxInt countryID = 0.obs;
  RxInt cityID = 0.obs;
  RxBool countryErrorVisibility = false.obs;
  RxBool cityErrorVisibility = false.obs;
  RxBool obscurePassword = true.obs;
  RxBool obscureConfirmPassword = true.obs;
  Rxn phoneErrorText = Rxn<String>();
  RxString countryCode = '+92'.obs;
  RxBool termAndCondition = false.obs;

  validatorPhoneNumber(String? value) {
    if (GetUtils.isBlank(value)!) {
      phoneErrorText.value = langKey.fieldIsRequired.tr;
    } else if (value!.length > 16 || value.length < 7) {
      phoneErrorText.value = langKey.phoneValidate.tr;
    } else {
      phoneErrorText.value = null;
    }
  }

  @override
  void onInit() async{
    await authController.getCountries();
    super.onInit();
  }

  @override
  void onClose() {
    firstNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    phoneNumberController.dispose();
    GlobalVariable.showLoader.value = false;
    super.onClose();
  }

  void signUp() {
    GlobalVariable.internetErr(false);
    if (signUpFormKey.currentState?.validate() ?? false) {
      if (countryID.value != 0 && cityID.value != 0) {
        if(termAndCondition.value == true) {
          GlobalVariable.showLoader.value = true;
          String? phoneNumber = countryCode.value + phoneNumberController.text;

          Map<String, dynamic> param = {
            "firstName": firstNameController.text,
            "lastName": lastNameController.text,
            "email": emailController.text,
            "phone": phoneNumber,
            "password": passwordController.text,
            'cityId': cityID.value,
            'countryId': countryID.value,
          };

          ApiBaseHelper()
              .postMethod(url: Urls.signUp, body: param)
              .then((parsedJson) async {
            GlobalVariable.showLoader.value = false;

            if (parsedJson['message'] == 'User registered successfully.') {
              Get.offNamed(Routes.loginRoute);
              AppConstant.displaySnackBar(
                langKey.successTitle.tr,
                parsedJson['message'],
              );
              cityViewModel.cityId.value = 0;
              cityViewModel.countryId.value = 0;
              cityViewModel.authController.selectedCountry.value =
                  CountryModel();
              cityViewModel.authController.selectedCity.value = CountryModel();
              Get.offNamed(Routes.loginRoute);
            } else {
              AppConstant.displaySnackBar(
                langKey.errorTitle.tr,
                parsedJson['message'],
              );
            }
          }).catchError((e) {
            GlobalVariable.internetErr(true);
            print(e);
            GlobalVariable.showLoader.value = false;
          });
        } else{
          AppConstant.displaySnackBar(langKey.errorTitle.tr, 'Accept terms and conditions to proceed');
        }
      } else {
        if (countryID.value == 0) {
          countryErrorVisibility.value = true;
        }
        if (cityID.value == 0) {
          cityErrorVisibility.value = true;
        }
      }
    } else{
      if (countryID.value == 0) {
        countryErrorVisibility.value = true;
      }
      if (cityID.value == 0) {
        cityErrorVisibility.value = true;
      }
    }
  }

  //Apple Signin
  String generateNonce([int length = 32]) {
    final charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  /// Returns the sha256 hash of [input] in hex notation.
  String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  Future<UserCredential> signInWithApple() async {
    print("hhhhhh ----- ");
    // To prevent replay attacks with the credential returned from Apple, we
    // include a nonce in the credential request. When signing in with
    // Firebase, the nonce in the id token returned by Apple, is expected to
    // match the sha256 hash of `rawNonce`.
    final rawNonce = generateNonce();
    final nonce = sha256ofString(rawNonce);

    // Request credential for the currently signed in Apple account.
    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      nonce: nonce,
    );
    print("hhhhhh email ----- ${appleCredential.email}");
    print("hhhhhh f name----- ${appleCredential.familyName}");
    print("hhhhhh given ----- ${appleCredential.givenName}");
    print("hhhhhh  code ----- ${appleCredential.authorizationCode}");



    // Create an `OAuthCredential` from the credential returned by Apple.
    final oauthCredential = OAuthProvider("apple.com").credential(
      idToken: appleCredential.identityToken,
      rawNonce: rawNonce,
    );
print("hhhhhh RawNo----- ${oauthCredential.rawNonce}");
    print("hhhhhh Token----- ${oauthCredential.idToken}");

    // Sign in the user with Firebase. If the nonce we generated earlier does
    // not match the nonce in `appleCredential.identityToken`, sign in will fail.
    return await FirebaseAuth.instance.signInWithCredential(oauthCredential);
  }


}