import 'dart:core';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ism_mart/helper/languages/translations_key.dart' as langKey;
import 'package:ism_mart/screens/vendor_signup/vendor_signup3/vendor_signup3_viewmodel.dart';

class Validator {
  /////////////////////  Formatters  /////////////////////////
  ///Number should start from + sign...
  final List<TextInputFormatter>? phoneNumberFormatter = [
    FilteringTextInputFormatter.allow(RegExp(r'^(?:[+])?\d*'))
  ];

  /////////////////////  Validators  /////////////////////////
  ///EmptyField
  String? validateDefaultTxtField(String? value, {String? errorPrompt}) {
    if (GetUtils.isBlank(value)!) {
      if(errorPrompt == null) {
        return langKey.fieldIsRequired.tr;
      } else{
        return errorPrompt;
      }
    } else {
      return null;
    }
  }

  ///Address
  String? validateAddress(String? value){
    RegExp regex = RegExp(r'^[#.0-9a-zA-Z\s,-]+$');
    if(GetUtils.isBlank(value)!){
      return langKey.shopAddressReq.tr;
    } else if(!regex.hasMatch(value!)){
      return langKey.incorrectAddress.tr;
    } else{
      return null;
    }
  }

  ///CNIC
  String? validateCNIC(String? value){
    if(GetUtils.isBlank(value)!){
      return langKey.cnicReq.tr;
    } else if(value!.length < 11 || value.length > 18){
      return langKey.incorrectCNIC.tr;
    } else {
      return null;
    }
  }
  
  ///Name
  String? validateName(String? value, {String? errorToPrompt}) {
  RegExp regex = RegExp(r'^[a-zA-Z0-9 -]+$');
  if (GetUtils.isBlank(value)!) {
    // Using errorToPrompt parameter to construct the error message dynamically
    return errorToPrompt;
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

  ///NTN
  String? validateNTN(String? value){
    if(GetUtils.isBlank(value)!){
      return null;
    } else if(value!.length < 7 || value.length > 9){
      return langKey.incorrectNTN.tr;
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

  ///Bank Account
  String? validateBankAcc(String? value){
    if(GetUtils.isBlank(value)!){
      return langKey.bankAccountReq.tr;
    } else {
      VendorSignUp3ViewModel vendorSignUp3ViewModel = Get.find();
      if(value!.length < 14 || value.length > 33){

        Future.delayed(Duration(milliseconds: 500), (){
          vendorSignUp3ViewModel.enableBranchCode.value = false;
        });
      return langKey.incorrectAccOrIbanNo.tr;
    } else{
        if(RegExp(r'^-?(([0-9]*)|(([0-9]*)\.([0-9]*)))$').hasMatch(value)){
        Future.delayed(Duration(milliseconds: 500), (){
          vendorSignUp3ViewModel.enableBranchCode.value = true;
        });
        return null;
        } else{
          Future.delayed(Duration(milliseconds: 500), (){
            vendorSignUp3ViewModel.enableBranchCode.value = false;
          });
          return null;
        }
      }
    }
  }

  ///Branch Code
  String? validateBranchCode(String? value, String bankAcc) {
    if (GetUtils.isBlank(value)!) {
      if(bankAcc.isEmpty || bankAcc == ''){
        return null;
      } else if(RegExp(r'^-?(([0-9]*)|(([0-9]*)\.([0-9]*)))$').hasMatch(bankAcc)){
          return langKey.enterBranchCode.tr;
      } else{
        return null;
      }
    } else if (value?.length != 4) {
      return langKey.incorrectBranchCode.tr;
    }
    else {
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

  ///Weight
  String? validateWeightField(String value){
    if(GetUtils.isBlank(value)!){
      return langKey.weightIsReq.tr;
    } else{
      return null;
    }
  }

}