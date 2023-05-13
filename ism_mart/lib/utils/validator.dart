import 'package:get/get.dart';
import 'package:ism_mart/utils/languages/translations_key.dart' as langKey;

class Validator {
  Validator();

  // String? email(String? value) {
  //   String pattern = r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+';
  //   RegExp regex = RegExp(pattern);
  //   if (!regex.hasMatch(value!.trim())) {
  //     return 'Invalid Email Format';
  //   } else {
  //     return null;
  //   }
  // }

  // String? password(String? value) {
  //   String pattern = r'^.{8,}$';
  //   RegExp regex = RegExp(pattern);
  //   if (value!.isEmpty) {
  //     return langKey.passwordRequired.tr;
  //   } else if (!regex.hasMatch(value)) {
  //     return langKey.passwordLengthReq.tr;
  //   } else {
  //     return null;
  //   }
  // }

  String? name(String? value) {
    String pattern = r"^[a-zA-Z]+(([',. -][a-zA-Z ])?[a-zA-Z]*)*$";
    RegExp regex = RegExp(pattern);
    if (value!.isEmpty) {
      return langKey.fullNameReq.tr;
    } else if (!regex.hasMatch(value.trim())) {
      return langKey.nameAlphabaticReq.tr;
    } else {
      return null;
    }
  }
  //
  // String? question(String? value) {
  //   String pattern = r"^\d+(?:\.\d+)?$";
  //   RegExp regex = RegExp(pattern);
  //   if (!regex.hasMatch(value!.trim())) {
  //     return "Invalid question format";
  //   } else {
  //     return null;
  //   }
  // }

  String? phone(String? value) {
    //String pattern = r'^\D?(\d{3})\D?\D?(\d{3})\D?(\d{4})$';
    String pattern = r'^(\+92|0|92)[0-9]{10}$'; //Pakistan
    //String pattern = r'(^(?:[+0]9)?[0-9]{11,12}$)';
    // String pattern =
    //     r'(^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$)';

    RegExp regex = RegExp(pattern);
    if (value!.isEmpty) {
      return langKey.phoneReq.tr;
    } else if (!regex.hasMatch(value.trim())) {
      return 'Invalid phone number format';
    } else {
      return null;
    }
  }

  // String? amount(String? value) {
  //   String pattern = r'^\d+$';
  //   RegExp regex = RegExp(pattern);
  //   if (!regex.hasMatch(value!)) {
  //     return 'validator.amount'.tr;
  //   } else {
  //     return null;
  //   }
  // }

  String? notEmpty(String? value, String? message) {
    //String pattern = r"^[a-zA-Z]+(([',. -][a-zA-Z ])?[a-zA-Z]*)*$";
    //String pattern = r'/^(?!\s*$).+/';
    // String pattern = "/(.|\s)*\S(.|\s)*/gm";
    //RegExp regex = RegExp(pattern);
    // if (!regex.hasMatch(value!.trim())) {
    if (value == null || value.isEmpty) {
      return message;
    } else {
      return null;
    }
  }
}