import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ism_mart/exports/export_api_helper.dart';
import 'package:ism_mart/helper/global_variables.dart';
import 'package:ism_mart/exports/exports_model.dart';
import 'package:ism_mart/helper/constants.dart';
import 'package:ism_mart/helper/languages/translations_key.dart' as langKey;

class CustomSearchController extends GetxController {
  final ApiProvider _apiProvider;

  CustomSearchController(this._apiProvider);

  TextEditingController minPriceController = TextEditingController();
  TextEditingController maxPriceController = TextEditingController();
  ScrollController scrollController = ScrollController();

  int searchLimit = 25;
  int page = 1;
  var isLoading = false.obs;
  var productList = <ProductModel>[].obs;

  var selectedCategoryId = 0.obs;
  var selectedCategory = ''.obs;
  var subCategoryID = 0.obs;
  var isLoadingMore = false.obs;
  var _sortBy = ''.obs;
  var noProductsFound = false.obs;

  String? get sortBy => _sortBy.value;

  setSortBy(String value) {
    _sortBy.value = value;
    addFilters("sort", value);
  }

  var filters = Map<String, String>().obs;

  @override
  void onReady() {
    scrollController.addListener(() {
      loadMoreFilteredProducts();
    });
    super.onReady();
  }

  handleFilters(Map<String, String> filters) {
    filters.addIf(page > 0, "page", "$page");
    filters.addIf(searchLimit > 0, "limit", "$searchLimit");
    searchWithFilters();
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
    GlobalVariable.internetErr(false);
    int? categoryId = selectedCategoryId.value;
    num? minPrice = num.parse(minPriceController.text.isNotEmpty
        ? minPriceController.text.toString().trim()
        : "0");
    num? maxPrice = num.parse(maxPriceController.text.isNotEmpty
        ? maxPriceController.text.toString().trim()
        : "0");

    addFilters("category", categoryId);

    if (minPrice != 0 && maxPrice != 0) {
      if (minPrice.isLowerThan(maxPrice)) {
        addFilters("minPrice", minPrice);
        addFilters("maxPrice", maxPrice);
      } else
        AppConstant.displaySnackBar(
          langKey.errorTitle.tr,
          langKey.minPriceShouldNotBe.tr,
        );
    }
  }

  searchWithFilters() async {
    GlobalVariable.internetErr(false);
    print("SearchWithFilters: ${filters.toString()}");
    isLoading.value = true;
    int i = 0;
    var url = 'filter';
    filters.forEach((key, value) {
      if (i == 0) {
        url = '$url?${key}=$value';
        i++;
      } else {
        url = '$url&${key}=$value';
      }
    });
    await _apiProvider.filterSearch(appliedFilters: filters).then((products) {
      if (products.length == 0) {
        noProductsFound.value = true;
      }
      noProductsFound.value = false;
      productList.clear();
      productList.addAll(products);
      productList.isEmpty
          ? GlobalVariable.internetErr(true)
          : GlobalVariable.internetErr(false);
      isLoading.value = false;
    }).catchError((onError) {
      isLoading.value = false;
      debugPrint("searchFilter: $onError");
    });
  }

  loadMoreFilteredProducts() async {
    if (scrollController.hasClients &&
        isLoadingMore.isFalse &&
        scrollController.position.maxScrollExtent == scrollController.offset) {
      filters.remove('page');
      page++;
      filters.addIf(page > 0, 'page', "$page");
      // searchLimit += 15;
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
    _sortBy.value = '';
    selectedCategory.value = '';
    selectedCategoryId.value = 0;
    filters.clear();
  }

  @override
  void onClose() {
    super.onClose();
    clearFilters();
  }
}
