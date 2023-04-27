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

  var isLoadingMore = false.obs;
  ScrollController scrollController = ScrollController();

  var _sortBy = ''.obs;

  String? get sortBy => _sortBy.value;

  setSortBy(String value) {
    _sortBy.value = value;
    search(searchTextController.text);
  }

  @override
  void onInit() {
    super.onInit();
    //change(null, status: RxStatus.loading());
  }

  @override
  void onReady() {
    // TOO: implement onReady
    super.onReady();
    searchTextController.addListener(() {
      search(searchTextController.text);
    });
    scrollController..addListener(() => loadMore(searchTextController.text));
  }

  var isLoading = false.obs;
  var productList = <ProductModel>[].obs;

  int searchLimit = 32;
  int page = 1;

  search(String? query) async {
    //change(null, status: RxStatus.loading());
    isLoading(true);
    page = 1;
    searchLimit = 32 * 2;
    await _apiProvider
        .search(
            text: query!.toLowerCase(),
            page: page,
            limit: searchLimit,
            sortBy: sortBy)
        .then((response) {
      isLoading(false);
      productList.clear();
      productList.addAll(response.products.productRows!);
    }).catchError((error) {
      isLoading(false);
      //change(null, status: RxStatus.error(error));
    });
  }

  void loadMore(String? searchQuery) async {
    //scrollController.position.maxScrollExtent == scrollController.offset
    //scrollController.position.extentAfter<300
    if (scrollController.hasClients &&
        isLoadingMore.isFalse &&
        scrollController.position.maxScrollExtent == scrollController.offset) {
      isLoadingMore(true);
      searchLimit = 15;
      page++;
      await _apiProvider
          .search(
              text: searchQuery!.toLowerCase(),
              page: page,
              limit: searchLimit,
              sortBy: sortBy)
          .then((response) {
        //change(products, status: RxStatus.success());
        // productList.clear();
        productList.addAll(response.products.productRows!);
        isLoadingMore(false);
      }).catchError((error) {
        isLoadingMore(false);
        //change(null, status: RxStatus.error(error));
      });
    }
  }

  var categoriesList = <CategoryModel>[].obs;

  setCategories(List<CategoryModel> list) {
    categoriesList.clear();

    categoriesList.addAll(list);

    categoriesList.refresh();

    debugPrint(">>>SetCategories: ${categoriesList.length}");
  }

  makeSelectedCategory(CategoryModel? categoryModel) {
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

  applyFilter() async {
    int? categoryId = selectedCategoryId.value;
    num? minPrice = num.parse(minPriceController.text.isNotEmpty
        ? minPriceController.text.toString().trim()
        : "0");
    num? maxPrice = num.parse(maxPriceController.text.isNotEmpty
        ? maxPriceController.text.toString().trim()
        : "0");

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

  searchWithFilters({filters}) async {
    isLoading(true);
    await _apiProvider.filterSearch(appliedFilters: filters).then((products) {
      Get.back();

      productList.clear();
      productList.addAll(products);
      isLoading(false);
    }).catchError((onError) {
      isLoading(false);
      debugPrint("searchFilter: $onError");
    });
  }

  clearFilters() async {
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
    super.onClose();
    searchTextController.clear();
  }
}
