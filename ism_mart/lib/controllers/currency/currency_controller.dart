import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ism_mart/api_helper/export_api_helper.dart';
import 'package:ism_mart/models/exports_model.dart';

class CurrencyController extends GetxController with StateMixin {
  final ApiProvider _apiProvider;

  CurrencyController(this._apiProvider);

  var currencyKey = "".obs;
  var currency = "".obs;

  final Map<String, dynamic> currencyLocales = {
    'pkr': {
      'currencyCode': 'pkr',
      'countryCode': 'PK',
      'description': 'PKR',
      'selected': false,
      'color': Colors.green[700],
    },
    'aed': {
      'currencyCode': 'aed',
      'countryCode': 'AE',
      'description': 'AED',
      'selected': false,
      'color': Color.fromARGB(255, 89, 45, 208),
    },
    'usd': {
      'currencyCode': 'usd',
      'countryCode': 'US',
      'description': 'USD',
      'selected': false,
      'color': Color.fromARGB(255, 222, 32, 32),
    },
    'gbp': {
      'currencyCode': 'gbp',
      'countryCode': 'GB',
      'description': 'GBP',
      'selected': false,
      'color': Colors.blue[700],
    },
    'cny': {
      'currencyCode': 'cny',
      'countryCode': 'CN',
      'description': 'CNY',
      'selected': false,
      'color': Color.fromARGB(255, 241, 114, 100),
    },
    'jpy': {
      'currencyCode': 'jpy',
      'countryCode': 'JP',
      'description': 'JPY',
      'selected': false,
      'color': Color.fromARGB(255, 221, 61, 143),
    },
    'aud': {
      'currencyCode': 'aud',
      'countryCode': 'AU',
      'description': 'AUD',
      'selected': false,
      'color': Color.fromARGB(255, 89, 45, 208),
    },
    'cad': {
      'currencyCode': 'cad',
      'countryCode': 'CA',
      'description': 'CAD',
      'selected': false,
      'color': Color.fromARGB(255, 211, 209, 51),
    },
    'eur': {
      'currencyCode': 'eur',
      'countryCode': 'EU',
      'description': 'EUR',
      'selected': false,
      'color': Color.fromARGB(255, 1, 10, 176),
    },
    'inr': {
      'currencyCode': 'inr',
      'countryCode': 'IN',
      'description': 'INR',
      'selected': false,
      'color': Color.fromARGB(255, 89, 45, 208),
    },
    'SGD': {
      'currencyCode': 'sgd',
      'countryCode': 'SG',
      'description': 'SGD',
      'selected': false,
      'color': Color.fromARGB(255, 253, 32, 168),
    }
  };

  @override
  void onInit() {
    super.onInit();
    getCurrencyState();
    LocalStorageHelper.localStorage
        .listenKey(LocalStorageHelper.currCurrencyKey, (value) {
      //fetchCurrencyExchangeRate(toCurrency: currency.value);
      print(">>Currency changed: $value: ${currency.value}");
      getCurrencyState();
    });
  }

  getCurrencyState() {
    LocalStorageHelper.getStoredCurrency().then((CurrencyModel? model) {
      if (model != null) {
        _currencyModel(model);
        setCurrency(key: model.to);
      } else
        setCurrency(key: "pkr");
    });
  }

  setCurrency({key}) {
    currency(currencyLocales[key]['currencyCode']);
    fetchCurrencyExchangeRate(toCurrency: currency.value);
    // if (storage.read('currency') == null) currencyKey(key);
    // storage.write('currency', key);
    // //storage.write('languageCode', languageCode);

    // final langKey = storage.read("key");
    // final String languageCode =
    //     languageController.optionsLocales[langKey]['languageCode'];
    // final String countryCode =
    //     languageController.optionsLocales[langKey]['countryCode'];
    // // Update App
    // Get.updateLocale(Locale(languageCode, countryCode));
  }

  var _currencyModel = CurrencyModel().obs;

  CurrencyModel? get currencyModel => _currencyModel.value;

  fetchCurrencyExchangeRate(
      {toCurrency, fromCurrency = "pkr", amount = 1}) async {
    //var currency = "".obs;
    await _apiProvider
        .convertCurrency(to: toCurrency, from: fromCurrency, amount: amount)
        .then((CurrencyModel? model) {
      if (model != null) {
        //_currencyModel(model);
        LocalStorageHelper.storeCurrency(
            currencyModel: CurrencyModel(
                to: toCurrency, from: "pkr", exchangeRate: model.exchangeRate));
      } else {}
    });

    //return currency.value;
  }

  String? convertCurrency({String? currenctPrice}) {
    return currencyModel != null
        ? "${(num.parse(currenctPrice!) * currencyModel!.exchangeRate!)}"
        : currenctPrice!;
  }
}
