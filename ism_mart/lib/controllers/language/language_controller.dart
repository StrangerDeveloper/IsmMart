import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LanguageController extends GetxController{
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
    },
    'ar_UAE': {
      'languageCode': 'ar',
      'countryCode': 'UAE',
      'description': 'العربية',
      'selected': false,
    },
    'ur_PK': {
      'languageCode': 'ur',
      'countryCode': 'PK',
      'description': 'اردو',
      'selected': false,
    },

    /*'zh_CN': {
      'languageCode': 'zh',
      'countryCode': 'CN',
      'description': '中国人'
    },
    'ru_RU': {
      'languageCode': 'ru',
      'countryCode': 'RU',
      'description': 'русский'
    },*/
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

   getLanguageState(){
    if (storage.read('key') != null) {
      languageKey(storage.read('key'));
      return setLanguage(key: storage.read('key'));
    }

    setLanguage(key: 'en_US');
  }

  void setLanguage({key}){
    final String languageCode = optionsLocales[key]['languageCode'];
    final String countryCode = optionsLocales[key]['countryCode'];
    // Update App
    Get.updateLocale(Locale(languageCode, countryCode));
    // Update obs
    locale.value = Get.locale.toString();

    storage.write('key', key);
    //storage.write('languageCode', languageCode);

    language(optionsLocales[key]['description']);


    update();
  }



}