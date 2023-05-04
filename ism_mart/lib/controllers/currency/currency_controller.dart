import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ism_mart/api_helper/export_api_helper.dart';
import 'package:ism_mart/controllers/export_controllers.dart';

class CurrencyController extends GetxController {
  final ApiProvider _apiProvider;

  CurrencyController(this._apiProvider);

  final storage = GetStorage();

  var currencyKey = "".obs;
  var currency = "".obs;

  final Map<String, dynamic> currencyLocales = {
    'ur_PKR': {
      'currencyCode': 'pkr',
      'countryCode': 'PK',
      'description': 'PKR',
      'selected': false,
      'color': Colors.green[700],
    },
    'ar_AED': {
      'currencyCode': 'aed',
      'countryCode': 'AE',
      'description': 'AED',
      'selected': false,
      'color': Color.fromARGB(255, 246, 3, 3),
    },
    'en_GBP': {
      'currencyCode': 'gbp',
      'countryCode': 'GB',
      'description': 'GBP',
      'selected': false,
      'color': Colors.blue[700],
    }
  };

  @override
  void onInit() {
    super.onInit();
    getCurrencyState();
  }

  getCurrencyState() {
    if (storage.read('currency') != null) {
      currencyKey(storage.read('currency'));
      return setCurrency(key: storage.read('currency'));
    }

    setCurrency(key: 'ur_PKR');
  }

  setCurrency({key}) {
    if (storage.read('currency') == null) currencyKey(key);
    storage.write('currency', key);
    //storage.write('languageCode', languageCode);

    currency(currencyLocales[key]['currencyCode']);

    final langKey = storage.read("key");
    final String languageCode =
        languageController.optionsLocales[langKey]['languageCode'];
    final String countryCode =
        languageController.optionsLocales[langKey]['countryCode'];
    // Update App
    Get.updateLocale(Locale(languageCode, countryCode));
  }

  Future<JSON> convertCurrency(
      {toCurrency, fromCurrency = "pkr", amount}) async {
    //var currency = "".obs;
    return await _apiProvider.convertCurrency(
        to: toCurrency, from: fromCurrency, amount: amount);

    //return currency.value;
  }
}
