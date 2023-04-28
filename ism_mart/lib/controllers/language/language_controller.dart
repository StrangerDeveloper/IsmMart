import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LanguageController extends GetxController {
  final storage = GetStorage();

  var languageKey = "".obs;
  var language = "".obs;

  var locale = Get.locale.toString().obs;

  final Map<String, dynamic> optionsLocales = {
    'en_US': {
      'languageCode': 'en',
      'countryCode': 'US',
      'description': 'English',
      'selected': false,
      'color': Colors.blue[600],
    },
    'ar_AE': {
      'languageCode': 'ar',
      'countryCode': 'AE',
      'description': 'العربية',
      'selected': false,
      'color': Colors.black,
    },
    'ur_PK': {
      'languageCode': 'ur',
      'countryCode': 'PK',
      'description': 'اردو',
      'selected': false,
      'color': Colors.green[700],
    },
    'zh_CN': {
      'languageCode': 'zh',
      'countryCode': 'CN',
      'description': '中国人',
      'selected': false,
      'color': Colors.red[900],
    },
    'ru_RU': {
      'languageCode': 'ru',
      'countryCode': 'RU',
      'description': 'русский',
      'selected': false,
      'color': Colors.blue[900],
    },
  };
  final Map<String, dynamic> currencyLocales = {
     'ar_AE': {
      'languageCode': 'ar',
      'countryCode': 'AE',
      'description': 'AED',
      'selected': false,
      'color': Colors.black,
    },
    'ur_PK': {
      'languageCode': 'ur',
      'countryCode': 'PK',
      'description': 'PKR',
      'selected': false,
      'color': Colors.green[700],
    },
    'en_gbp': {
      'languageCode': 'ur',
      'countryCode': 'PK',
      'description': 'GBP',
      'selected': false,
      'color': Colors.green[700],
    }
  };

  /*final List locale =[
    {'name':'ENGLISH','locale': Locale('en','US')},
    {'name':'ಕನ್ನಡ','locale': Locale('kn','IN')},
    {'name':'हिंदी','locale': Locale('hi','IN')},
  ];*/

  @override
  void onInit() {
    super.onInit();
    getLanguageState();
  }

  getLanguageState() {
    if (storage.read('key') != null) {
      languageKey(storage.read('key'));
      return setLanguage(key: storage.read('key'));
    }

    setLanguage(key: 'en_US');
  }

  void setLanguage({key}) {
    final String languageCode = optionsLocales[key]['languageCode'];
    final String countryCode = optionsLocales[key]['countryCode'];
    // Update App
    Get.updateLocale(Locale(languageCode, countryCode));
    // Update obs
    locale.value = Get.locale.toString();
    if (storage.read('key') == null) languageKey(key);
    storage.write('key', key);
    //storage.write('languageCode', languageCode);

    language(optionsLocales[key]['description']);

    update();
  }
}
