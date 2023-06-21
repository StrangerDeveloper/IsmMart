import 'package:get/get.dart';
import 'package:ism_mart/helper/languages/translations_key.dart' as langKey;

class Errors {
  static String generalApiError = langKey.someThingWentWrong.tr;
  static String noInternetError = langKey.noInternetConnection.tr;
  static String formatException = langKey.serverUnableToHandle.tr;
  static String timeOutException = langKey.serverTakingTooLong.tr;
}
