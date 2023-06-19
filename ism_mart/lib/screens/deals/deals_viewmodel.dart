import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:ism_mart/helper/api_base_helper.dart';
import 'package:ism_mart/helper/global_variables.dart';
import 'package:ism_mart/helper/constants.dart';
import 'package:ism_mart/utils/languages/translations_key.dart' as langKey;
import '../categories/model/category_model.dart';
import '../../models/product/product_model.dart';

class DealsViewModel extends GetxController{

  final productList = <ProductModel>[].obs;
  var suggestionList = <ProductModel>[].obs;
  final filters = Map<String, String>().obs;
  var limit = 15.obs;
  var page = 1;
  var selectedCategoryId = 0.obs;
  var url = 'filter?type=Discounts&';
  ScrollController scrollController = ScrollController();
  var isLoadingMore = false.obs;
  TextEditingController searchTextController = TextEditingController();
  var isSearchingStarted = false.obs;
  TextEditingController minPriceController = TextEditingController();
  TextEditingController maxPriceController = TextEditingController();
  RxBool noProductsFound = false.obs;

  @override
  void onReady() {
    super.onReady();
    scrollController.addListener(() {
      loadMoreFilteredProducts();
    });
  }

  @override
  void onInit() {
    url = '${url}page=$page&limit=$limit&';
    getProducts();
    super.onInit();
  }

  addPriceFilter()async{
    int minPrice = int.parse(minPriceController.text);
    int maxPrice = int.parse(maxPriceController.text);
    if (minPrice != 0 && maxPrice != 0) {
      if (minPrice.isLowerThan(maxPrice)) {
        filters.addAll({
          'minPrice': '${minPriceController.text}',
          'maxPrice': '${maxPriceController.text}'
        });
        addFilters();
        // addFilters("minPrice", minPrice);
        // addFilters("maxPrice", maxPrice);
        // //filters.addIf(minPrice > 0, "minPrice", "$minPrice");
        //filters.addIf(maxPrice > 0, "maxPrice", "$maxPrice");
      } else
        AppConstant.displaySnackBar(
          langKey.errorTitle.tr,
          langKey.minPriceShouldNotBe.tr,
        );
    }
  }

  addFilters()async{
    url = 'filter?type=Discounts&page=$page&limit=$limit&';
    filters.forEach((key, value) {
      url = '$url$key=$value&';
    });
    await getProducts();
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

  getProducts()async{
    GlobalVariable.showLoader.value = true;
    noProductsFound.value = false;
    productList.clear();
    await ApiBaseHelper().getMethod(url: url).then((response) {
      if(response['success'] == true && response['data'] != null){
        productList.clear();
        var data = response['data'] as List;
        productList.addAll(data.map((e) => ProductModel.fromJson(e)));
        GlobalVariable.showLoader.value = false;
      } else{
        noProductsFound.value = true;
        GlobalVariable.showLoader.value = false;
        AppConstant.displaySnackBar(langKey.errorTitle.tr, response['message']);
        print('>>>No Products Value: ${noProductsFound.value}');
      }
    }).catchError((e){
      print(e);
      GlobalVariable.showLoader.value = false;
    });
  }
  
  searchProductsForSuggestion(String value)async{
    GlobalVariable.showLoader.value = true;
    productList.clear();
    await ApiBaseHelper().getMethod(url: '${url}text=$value&').then((response){
      GlobalVariable.showLoader.value = false;
      if(response['success'] == true && response['data'] != null){
        var data = response['data'] as List;
        productList.addAll(
          data.map((e) => ProductModel.fromJson(e))
        );
      }
    }).catchError((e){
      print(e);
    });
  }

  loadMoreFilteredProducts() async {
    if (scrollController.hasClients &&
        isLoadingMore.isFalse &&
        scrollController.position.maxScrollExtent == scrollController.offset) {
      page++;
      url = 'filter?type=Discounts&limit=$limit&page=$page&';
      filters.forEach((key, value) {
        url = '$url$key=$value&';
      });
      isLoadingMore(true);
      print('>>>Load More: $url');
      await ApiBaseHelper().getMethod(url: url).then((response) {
        if(response['success'] == true && response['data'] != null){
          var data = response['data'] as List;
          productList.addAll(data.map((e) => ProductModel.fromJson(e)));
          isLoadingMore(false);
        }
        else{
          isLoadingMore(false);
        }
      }).catchError((e){
        isLoadingMore(false);
      });
      // await _apiProvider.filterSearch(appliedFilters: filters).then((products) {
      //   //productList.clear();
      //   productList.addAll(products);
      //   isLoadingMore(false);
      // }).catchError((onError) {
      //   isLoadingMore(false);
      //   debugPrint("loadMoreFilterProduct: $onError");
      // });
    }
  }
}