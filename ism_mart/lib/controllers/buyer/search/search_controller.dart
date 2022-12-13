import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ism_mart/api_helper/export_api_helper.dart';
import 'package:ism_mart/models/exports_model.dart';
import 'package:ism_mart/utils/constants.dart';

class SearchController extends GetxController {
  final ApiProvider _apiProvider;

  SearchController(this._apiProvider);

  var searchTextController = TextEditingController();

  var minPriceController = TextEditingController();
  var maxPriceController = TextEditingController();

  var selectedCategoryId = 0.obs;

  @override
  void onInit() {
    super.onInit();
    //change(null, status: RxStatus.loading());

    searchTextController.addListener(() {
      search(searchTextController.text);
    });
  }

  var isLoading = false.obs;
  var productList = <ProductModel>[].obs;

  search(String? query) async {
    //change(null, status: RxStatus.loading());
    isLoading(true);

    await _apiProvider.search(text: query!.toLowerCase()).then((products) {
      //change(products, status: RxStatus.success());
      productList.clear();
      productList.addAll(products);
      isLoading(false);
    }).catchError((error) {
      isLoading(false);
      //change(null, status: RxStatus.error(error));
    });
  }

  applyFilter() async{
    int? categoryId = selectedCategoryId.value;
    num? minPrice = num.parse(minPriceController.text.isNotEmpty? minPriceController.text.toString().trim() : "0");
    num? maxPrice = num.parse(maxPriceController.text.isNotEmpty?maxPriceController.text.toString().trim() : "0");

    Map<String, dynamic>? filters = Map();
    filters.addIf(categoryId > 0, "category", "$categoryId");
    if (minPrice != 0 && maxPrice != 0) if (minPrice.isLowerThan(maxPrice)) {
      filters.addIf(minPrice > 0, "minPrice", "$minPrice");
      filters.addIf(maxPrice > 0, "maxPrice", "$maxPrice");
    } else
      AppConstant.displaySnackBar(
          "error", "Min. Price shouldn't be greater than Max. price!");

    int page = 1;
    int limit = 10;
    filters.addIf(page > 0, "page", "$page");
    filters.addIf(limit > 0, "limit", "$limit");

   await searchWithFilters(filters: filters);
  }

  searchWithFilters({filters}) async{
    isLoading(true);
    await _apiProvider.filterSearch(appliedFilters: filters)
        .then((products){
      Get.back();

      productList.clear();
      productList.addAll(products);
      isLoading(false);
    }).catchError((onError){
      isLoading(false);
      debugPrint("searchFilter: $onError");
    });
  }

  clearFilters() async{
    minPriceController.clear();
    maxPriceController.clear();

    Map<String, dynamic>? filters = Map();
    int page = 1;
    int limit = 10;
    filters.addIf(page > 0, "page", "$page");
    filters.addIf(limit > 0, "limit", "$limit");

    await searchWithFilters(filters: filters);
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    searchTextController.clear();
  }
}
