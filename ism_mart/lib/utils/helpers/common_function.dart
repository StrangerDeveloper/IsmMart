import 'package:get/get.dart';
import 'package:ism_mart/utils/languages/translations_key.dart' as langKey;

class CommonFunctions {
  static String? validateDefaultTxtField(String? value) {
    if (GetUtils.isBlank(value)!) {
      return langKey.fieldIsRequired.tr;
    } else {
      return null;
    }
  }
}
