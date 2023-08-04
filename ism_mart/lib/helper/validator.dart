import 'dart:core';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ism_mart/helper/languages/translations_key.dart' as langKey;

class Validator {
  /////////////////////  Formatters  /////////////////////////
  ///Number should start from + sign...
  final List<TextInputFormatter>? phoneNumberFormatter = [
    FilteringTextInputFormatter.allow(RegExp(r'^(?:[+])?\d*'))
  ];

  /////////////////////  Validators  /////////////////////////
  ///EmptyField
  String? validateDefaultTxtField(String? value) {
    if (GetUtils.isBlank(value)!) {
      return langKey.fieldIsRequired.tr;
    } else {
      return null;
    }
  }

  ///Name
  String? validateName(String? value, {String? fieldType}) {
  RegExp regex = RegExp(r'^[a-zA-Z -]+$');
  if (GetUtils.isBlank(value)!) {
    // Using fieldType parameter to construct the error message dynamically
    return fieldType;
  } else if (!regex.hasMatch(value!)) {
    return langKey.nameAlphabaticReq.tr;
  } else {
    return null;
  }
}

  // String? validateName(String? value) {
  //   RegExp regex = RegExp(r'^[a-zA-Z -]+$');
  //   if (GetUtils.isBlank(value)!) {
  //     return langKey.fieldIsRequired.tr;
  //   } else if (!regex.hasMatch(value!)) {
  //     return langKey.nameAlphabaticReq.tr;
  //   } else {
  //     return null;
  //   }
  // }

  ///Phone Number : that should NOT start from + sign...
  String? validatePhoneNumber(String? value) {
    if (GetUtils.isBlank(value)!) {
      return langKey.phoneReq.tr;
    } else if (value!.length > 16 || value.length < 7) {
      return langKey.phoneValidate.tr;
    } else {
      return null;
    }
  }

  ///Email
  String? validateEmail(String? value) {
    if (GetUtils.isBlank(value)!) {
      return langKey.emailIsRequired.tr;
    } else if (!GetUtils.isEmail(value!)) {
      return langKey.invalidEmail.tr;
    } else {
      return null;
    }
  }

  ///Password
  String? validatePassword(String? value) {
    if (GetUtils.isBlank(value)!) {
      return langKey.passwordIsRequired.tr;
    } else if (GetUtils.isLengthLessThan(value, 8)) {
      return langKey.passwordLengthReq.tr;
    } else {
      return null;
    }
  }

  ///Confirm Password
  String? validateConfirmPassword(String? value1, String? value2){
    if(GetUtils.isBlank(value1)!){
      return langKey.passwordConfirmIsRequired.tr;
    } else if(value1 != value2){
      return langKey.passwordNotMatched.tr;
    } else{
      return null;
    }
  }
}