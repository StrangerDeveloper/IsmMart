import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ism_mart/api_helper/export_api_helper.dart';
import 'package:ism_mart/models/exports_model.dart';

class CurrencyController extends GetxController with StateMixin {
  final ApiProvider _apiProvider;

  CurrencyController(this._apiProvider);

  var countryCode = "".obs;
  var currency = "".obs;

  final Map<String, dynamic> currencyLocales = {
    'pkr': {
      'currencyCode': 'pkr',
      'countryCode': 'PK',
      'description': 'PKR',
      'longDesc': "Pakistani Rupee",
      'selected': false,
      'color': Colors.green[700],
    },
    'aed': {
      'currencyCode': 'aed',
      'countryCode': 'AE',
      'description': 'AED',
      'longDesc': 'United Arab Emirates Dirhaam',
      'selected': false,
      'color': Color.fromARGB(255, 89, 45, 208),
    },
    'usd': {
      'currencyCode': 'usd',
      'countryCode': 'US',
      'description': 'USD',
      'longDesc': 'Unitedstate Dollar',
      'selected': false,
      'color': Color.fromARGB(255, 222, 32, 32),
    },
    'gbp': {
      'currencyCode': 'gbp',
      'countryCode': 'GB',
      'description': 'GBP',
      'longDesc': 'Pound sterling',
      'selected': false,
      'color': Colors.blue[700],
    },
    'cny': {
      'currencyCode': 'cny',
      'countryCode': 'CN',
      'description': 'CNY',
      'longDesc': 'Chinese Yuan',
      'selected': false,
      'color': Color.fromARGB(255, 241, 114, 100),
    },
    'jpy': {
      'currencyCode': 'jpy',
      'countryCode': 'JP',
      'description': 'JPY',
      'longDesc': 'Japanese Yen',
      'selected': false,
      'color': Color.fromARGB(255, 221, 61, 143),
    },
    'aud': {
      'currencyCode': 'aud',
      'countryCode': 'AU',
      'description': 'AUD',
      'longDesc': 'Australian Dollar',
      'selected': false,
      'color': Color.fromARGB(255, 89, 45, 208),
    },
    'cad': {
      'currencyCode': 'cad',
      'countryCode': 'CA',
      'description': 'CAD',
      'longDesc': 'Candian Dollar',
      'selected': false,
      'color': Color.fromARGB(255, 211, 209, 51),
    },
    'eur': {
      'currencyCode': 'eur',
      'countryCode': 'EU',
      'description': 'EUR',
      'longDesc': 'European Union Euro',
      'selected': false,
      'color': Color.fromARGB(255, 1, 10, 176),
    },
    'inr': {
      'currencyCode': 'inr',
      'countryCode': 'IN',
      'description': 'INR',
      'longDesc': 'Indian Rupee',
      'selected': false,
      'color': Color.fromARGB(255, 89, 45, 208),
    },
    'sgd': {
      'currencyCode': 'sgd',
      'countryCode': 'SG',
      'description': 'SGD',
      'longDesc': 'Singapore Dollar',
      'selected': false,
      'color': Color.fromARGB(255, 253, 32, 168),
    },
    'try': {
      'currencyCode': 'try',
      'countryCode': 'TR',
      'description': 'TRY',
      'longDesc': 'Turkish Lira',
      'selected': false,
      'color': Color.fromARGB(255, 251, 52, 2),
    },
    'hkd': {
      'currencyCode': 'hkd',
      'countryCode': 'HK',
      'description': 'HKD',
      'longDesc': 'Hong Kong Dollar',
      'selected': false,
      'color': Color.fromARGB(255, 87, 26, 141),
    },
    'chf': {
      'currencyCode': 'chf',
      'countryCode': 'CH',
      'description': 'CHF',
      'longDesc': 'Swiss Franc',
      'selected': false,
      'color': Color.fromARGB(255, 126, 40, 93),
    },
  };

  @override
  void onInit() {
    super.onInit();
    getCurrencyState();
    LocalStorageHelper.localStorage
        .listenKey(LocalStorageHelper.currCurrencyKey, (value) {
      getCurrencyState();
    });
  }

  getCurrencyState() {
    LocalStorageHelper.getStoredCurrency().then((CurrencyModel? model) {
      if (model != null) {
        _currencyModel(model);
        currency(currencyLocales[model.to]['currencyCode']);
        countryCode(currencyLocales[model.to]['countryCode']);
        //setCurrency(key: model.to);
      } else
        setCurrency(key: "pkr");
    });
  }

  setCurrency({key}) {
    currency(currencyLocales[key]['currencyCode']);
    countryCode(currencyLocales[key]['countryCode']);
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
        print(">>Model: ${model.exchangeRate}");
        LocalStorageHelper.storeCurrency(
            currencyModel: CurrencyModel(
                to: toCurrency, from: "pkr", exchangeRate: model.exchangeRate));
      } else {
        print(">>Model is null");
      }
    });

    //return currency.value;
  }

  String? convertCurrency({String? currentPrice}) {
    return currencyModel != null
        ? "${(num.parse(currentPrice!) * (currencyModel!.exchangeRate!))}"
        : currentPrice!;
  }
}
