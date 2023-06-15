import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ism_mart/api_helper/export_api_helper.dart';
import 'package:ism_mart/models/exports_model.dart';
import 'package:ism_mart/utils/constants.dart';
import 'package:ism_mart/utils/languages/translations_key.dart' as langKey;

class CustomSearchController extends GetxController {
  final ApiProvider _apiProvider;

  CustomSearchController(this._apiProvider);

  TextEditingController minPriceController = TextEditingController();
  TextEditingController maxPriceController = TextEditingController();
  ScrollController scrollController = ScrollController();

  int searchLimit = 25;
  int page = 1;

  var productList = <ProductModel>[].obs;

  var selectedCategoryId = 0.obs;
  var selectedCategory = ''.obs;
  var subCategoryID = 0.obs;
  var isLoadingMore = false.obs;
  var _sortBy = ''.obs;
  String? get sortBy => _sortBy.value;

  setSortBy(String value) {
    _sortBy.value = value;
    // filters.addIf(value.isNotEmpty, "sort", value);
    addFilters("sort", value);
    //searchProducts(searchTextController.text);
  }

  var filters = Map<String, String>().obs;

  @override
  void onReady() {
    // TOO: implement onReady
    super.onReady();

    scrollController.addListener(() {
      loadMoreFilteredProducts();
    });

    // ever(filters, handleFilters);
  }

  handleFilters(Map<String, String> filters) {
    filters.addIf(page > 0, "page", "$page");
    filters.addIf(searchLimit > 0, "limit", "$searchLimit");

    searchWithFilters(filters: filters);
  }

  var categoriesList = <CategoryModel>[].obs;

  setCategories(List<CategoryModel> list) {
    categoriesList.clear();
    categoriesList.addAll(list);
    categoriesList.refresh();
  }

  setSelectedCategory(CategoryModel? categoryModel) {
    var list = <CategoryModel>[];
    if (categoriesList.isNotEmpty) {
      list.clear();
      for (CategoryModel model in categoriesList) {
        if (model.id! == categoryModel!.id!) {
          model.isPressed = true;
        } else {
          model.isPressed = false;
        }
        list.add(model);
      }
      setCategories(list);
    }
  }

  addFilters(key, value) {
    //clearFilters();
    //filters.clear();
    if (value is String) {
      filters.addIf(value.isNotEmpty, key, value);
    } else if (value is int) {
      filters.addIf(value > 0, key, "$value");
    }

    handleFilters(filters);
  }

  deleteFilter(key) {
    filters.remove(key);
  }

  var stopLoadMore = false.obs;

  applyFilter() async {
    //stopLoadMore.value = true;
    int? categoryId = selectedCategoryId.value;
    num? minPrice = num.parse(minPriceController.text.isNotEmpty
        ? minPriceController.text.toString().trim()
        : "0");
    num? maxPrice = num.parse(maxPriceController.text.isNotEmpty
        ? maxPriceController.text.toString().trim()
        : "0");

    addFilters("category", categoryId);

    //filters.addIf(categoryId > 0, "category", "$categoryId");
    if (minPrice != 0 && maxPrice != 0) {
      if (minPrice.isLowerThan(maxPrice)) {
        addFilters("minPrice", minPrice);
        addFilters("maxPrice", maxPrice);
        //filters.addIf(minPrice > 0, "minPrice", "$minPrice");
        //filters.addIf(maxPrice > 0, "maxPrice", "$maxPrice");
      } else
        AppConstant.displaySnackBar(
          langKey.errorTitle.tr,
          langKey.minPriceShouldNotBe.tr,
        );
    }

    //int page = 1;
    //int limit = 10;

    // await searchWithFilters(filters: filters);
  }

  var isLoading = false.obs;

  searchWithFilters({filters}) async {
    print("SearchWithFilters: ${filters.toString()}");
    isLoading(true);
    await _apiProvider.filterSearch(appliedFilters: filters).then((products) {
      productList.clear();
      productList.addAll(products);
      isLoading(false);
    }).catchError((onError) {
      isLoading(false);
      debugPrint("searchFilter: $onError");
    });
  }

  loadMoreFilteredProducts() async {
    if (scrollController.hasClients &&
        isLoadingMore.isFalse &&
        scrollController.position.maxScrollExtent == scrollController.offset) {
      //page++;
      searchLimit += 15;
      isLoadingMore(true);
      await _apiProvider.filterSearch(appliedFilters: filters).then((products) {
        //productList.clear();
        productList.addAll(products);
        isLoadingMore(false);
      }).catchError((onError) {
        isLoadingMore(false);
        debugPrint("loadMoreFilterProduct: $onError");
      });
    }
  }

  clearFilters() async {
    minPriceController.clear();
    maxPriceController.clear();
    searchLimit = 25;
    page = 1;
    filters.clear();

    //Map<String, dynamic>? filters = Map();
    //int page = 1;
    //int limit = 10;
    //filters.addIf(page > 0, "page", "$page");
    //filters.addIf(limit > 0, "limit", "$limit");

    //await searchWithFilters(filters: filters);
  }

  @override
  void onClose() {
    super.onClose();
    clearFilters();
    //searchTextController.removeListener(() {});
    //scrollController.removeListener(() {});
    //focus.removeListener(_onFocusChange);
    //focus.dispose();
  }
}
