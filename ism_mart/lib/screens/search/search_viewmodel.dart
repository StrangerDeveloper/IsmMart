import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ism_mart/exports/export_api_helper.dart';
import 'package:ism_mart/helper/global_variables.dart';
import 'package:ism_mart/models/product/product_model.dart';

class SearchViewModel extends GetxController {
  final ApiProvider _apiProvider;

  SearchViewModel(this._apiProvider);

  var searchTextController = TextEditingController();
  var suggestionList = <ProductModel>[].obs;
  var historyList = <String>[].obs;
  int searchLimit = 25;
  int page = 1;

  var isSearchingStarted = false.obs;
  @override
  void onReady() {
    super.onReady();

    getHistory();
    LocalStorageHelper.localStorage
        .listenKey(LocalStorageHelper.searchHistoryKey, (value) {
      getHistory();
    });
  }

  searchProducts(String? query) async {
    GlobalVariable.showLoader(true);
    await _apiProvider
        .search(text: query, page: page, limit: searchLimit)
        .then((response) {
      GlobalVariable.showLoader(false);
      suggestionList.clear();
      suggestionList.addAll(response.products.productRows!);
    }).catchError((error) {
      print("SearchProduct: $error");
      GlobalVariable.showLoader(false);
    });
  }

  addHistory({String? search}) async {
    await LocalStorageHelper.saveHistory(history: search!);
  }

  void getHistory() async {
    await LocalStorageHelper.getHistory().then((value) {
      //print(">>GetHistory: ${value.toString()}");
      historyList.addAll(value);
    });
  }

  clearHistory() async {
    historyList.clear();
    await LocalStorageHelper.clearHistory();
  }

  @override
  void onClose() {
    searchTextController.clear();
    suggestionList.clear();
    super.onClose();
  }
}
