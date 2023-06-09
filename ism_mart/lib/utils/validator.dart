import 'dart:core';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ism_mart/utils/languages/translations_key.dart' as langKey;

class Validator {
  Validator();

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
  String? validateName(String? value) {
    RegExp regex = RegExp(r'^[a-zA-Z -]+$');
    if (GetUtils.isBlank(value)!) {
      return langKey.fieldIsRequired.tr;
    } else if (!regex.hasMatch(value!)) {
      return langKey.nameAlphabaticReq.tr;
    } else {
      return null;
    }
  }

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
      return langKey.fieldIsRequired.tr;
    } else if (!GetUtils.isEmail(value!)) {
      return langKey.invalidEmail.tr;
    } else {
      return null;
    }
  }

  ///Password
  String? validatePassword(String? value) {
    if (GetUtils.isBlank(value)!) {
      return langKey.fieldIsRequired.tr;
    } else if (GetUtils.isLengthLessThan(value, 8)) {
      return langKey.passwordLengthReq.tr;
    } else {
      return null;
    }
  }


  //replace this with upper one
  String? name(String? value, {String? title}) {
    //String pattern = r"^[a-zA-Z]+(([',.-][a-zA-Z])?[a-zA-Z])$";
    // String pattern = r"[a-zA-Z-]+$|\s";
    RegExp regex = RegExp(r'[a-zA-Z-]+|\s');
    if (value!.isEmpty) {
      return "$title is required";
    } else if (!regex.hasMatch(value.trim())) {
      return langKey.nameAlphabaticReq.tr;
    } else {
      //GetUtils.isAlphabetOnly(s)
      return null;
    }
  }

  String? question(String? value) {
    String pattern = r"^\d+(?:\.\d+)?$";
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value!.trim())) {
      return "Invalid question format";
    } else {
      return null;
    }
  }

}
