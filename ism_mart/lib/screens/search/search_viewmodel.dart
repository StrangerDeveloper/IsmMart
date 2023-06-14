import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ism_mart/api_helper/export_api_helper.dart';
import 'package:ism_mart/api_helper/global_variables.dart';
import 'package:ism_mart/models/product/product_model.dart';

class SearchViewModel extends GetxController {
  final ApiProvider _apiProvider;

  SearchViewModel(this._apiProvider);

  var searchTextController = TextEditingController();
  var suggestionList = <ProductModel>[].obs;
  int searchLimit = 15;
  int page = 1;

  @override
  void onReady() {
    super.onReady();
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
      GlobalVariable.showLoader(false);
    });
  }

  
}
