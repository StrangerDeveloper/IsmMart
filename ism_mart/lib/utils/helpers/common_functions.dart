import 'package:get/get.dart';

class CommonFunctions {
  static String? validateDefaultTxtField(String? value) {
    if (GetUtils.isBlank(value)!) {
      return "Field is required";
    } else {
      return null;
    }
  }
}
