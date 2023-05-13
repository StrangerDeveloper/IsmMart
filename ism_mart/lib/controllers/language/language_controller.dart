import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LanguageController extends GetxController {
  final storage = GetStorage();

  var languageKey = "".obs;
  var language = "".obs;
  var countryKey = "".obs;

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
    'tr_TR': {
      'languageCode': 'tr',
      'countryCode': 'TR',
      'description': 'Turkish',
      'selected': false,
      'color': Colors.red[600],
    },
    'fr_CH': {
      'languageCode': 'fr',
      'countryCode': 'CH',
      'description': 'French',
      'selected': false,
      'color': Colors.red,
    },
    'es_ES': {
      'languageCode': 'es',
      'countryCode': 'ES',
      'description': 'Spanish',
      'selected': false,
      'color': Colors.indigo,
    },
    'ja_JP': {
      'languageCode': 'ja',
      'countryCode': 'JP',
      'description': '日本',
      'selected': false,
      'color': Colors.blue[300],
    },
    'de_DE': {
      'languageCode': 'de',
      'countryCode': 'DE',
      'description': 'Deutsch',
      'selected': false,
      'color': Colors.amber[300],
    },
    'it_IT': {
      'languageCode': 'it',
      'countryCode': 'IT',
      'description': 'italiano',
      'selected': false,
      'color': Colors.blue[900],
    },
    'ko_KR': {
      'languageCode': 'ko',
      'countryCode': 'KR',
      'description': '한국인',
      'selected': false,
      'color': Color.fromARGB(255, 36, 51, 74),
    },
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
    countryKey(optionsLocales[key]['countryCode']);

    update();
  }
}
