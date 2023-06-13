import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ism_mart/api_helper/export_api_helper.dart';
import 'package:ism_mart/models/exports_model.dart';
import 'package:ism_mart/utils/constants.dart';
import 'package:ism_mart/utils/languages/translations_key.dart' as langKey;

class CustomSearchController extends GetxController {
  final ApiProvider _apiProvider;

  CustomSearchController(this._apiProvider);

  var searchTextController = TextEditingController();

  var minPriceController = TextEditingController();
  var maxPriceController = TextEditingController();

  var selectedCategoryId = 0.obs;

  RxString selectedCategory = ''.obs;
  var isLoadingMore = false.obs;
  ScrollController scrollController = ScrollController();

  RxInt subCategoryID = 0.obs;
  var _sortBy = ''.obs;

  String? get sortBy => _sortBy.value;

  setSortBy(String value) {
    _sortBy.value = value;
    searchProducts(searchTextController.text);
  }

  @override
  void onReady() {
    // TOO: implement onReady
    super.onReady();

    //searchTextController.addListener(() {
    //  search(searchTextController.text);
    // });

    scrollController.addListener(() {
      if (stopLoadMore.isFalse) {
        loadMoreSearchedProducts(searchTextController.text);
      }
    });
  }

  var isLoading = false.obs;
  var productList = <ProductModel>[].obs;
  var suggestionList = <ProductModel>[].obs;

  int searchLimit = 15;
  int page = 1;
  searchProducts(String? query) async {
    isLoading(true);
    await _apiProvider
        .search(text: query, page: page, limit: searchLimit, sortBy: sortBy)
        .then((response) {
      isLoading(false);
      suggestionList.clear();
      suggestionList.addAll(response.products.productRows!);
      //productList.clear();
      //productList.addAll(response.products.productRows!);
    }).catchError((error) {
      isLoading(false);
    });
  }

  void loadMoreSearchedProducts(String? searchQuery) async {
    if (scrollController.hasClients &&
        isLoadingMore.isFalse &&
        scrollController.position.maxScrollExtent == scrollController.offset) {
      isLoadingMore(true);
      searchLimit += 10;
      page++;
      await _apiProvider
          .search(
              text: searchQuery!.toLowerCase(),
              page: page,
              limit: searchLimit,
              sortBy: sortBy)
          .then((response) {
        // productList.clear();
        productList.addAll(response.products.productRows!);
        isLoadingMore(false);
      }).catchError((error) {
        isLoadingMore(false);
      });
    }
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

  Rx<int> selectedIndex = 0.obs;
  //Rx<String> changeValue = ''.obs;
  //RxBool finalSerach = false.obs;
  // var myFocusNode = FocusNode();

  // void suggestionSearch() {
  //   suggestionList.clear();
  //   //  productList.map((element) => l.add(element.name));
  //   for (var element in productList) {
  //     suggestionList.add(element.name.toString());
  //   }

  //   print("suggestin hasnain ----------- ${suggestionList.length}");
  // }

  var stopLoadMore = false.obs;

  applyFilter() async {
    stopLoadMore.value = true;
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
        langKey.errorTitle.tr,
        langKey.minPriceShouldNotBe.tr,
      );

    //int page = 1;
    //int limit = 10;
    filters.addIf(page > 0, "page", "$page");
    filters.addIf(searchLimit > 0, "limit", "$searchLimit");

    await searchWithFilters(filters: filters);
  }

  searchWithFilters({filters}) async {
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

  // loadMoreFilteredProducts() async {
  //   page++;
  //   searchLimit += 15;

  //   searchWithFilters(filters: );
  // }

  goBack() {
    productList.clear();
    searchLimit = 15;
    selectedCategory('');
    subCategoryID.value = 0;
    searchTextController.clear();
    Get.back();
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
    searchTextController.text = "";
    //searchTextController.removeListener(() {});
    //scrollController.removeListener(() {});
    //focus.removeListener(_onFocusChange);
    //focus.dispose();
  }
}
