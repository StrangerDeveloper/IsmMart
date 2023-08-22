import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:ism_mart/helper/api_base_helper.dart';
import 'package:ism_mart/helper/global_variables.dart';
import 'package:ism_mart/helper/constants.dart';
import 'package:ism_mart/helper/languages/translations_key.dart' as langKey;
import '../../models/product/product_model.dart';

class DealsViewModel extends GetxController {
  final productList = <ProductModel>[].obs;
  var limit = 15.obs;
  var page = 1;
  var url = 'filter?type=Discounts&';
  ScrollController scrollController = ScrollController();
  var isLoadingMore = false.obs;
  RxBool noProductsFound = false.obs;

  @override
  void onInit() {
    url = '${url}page=$page&limit=$limit&';
    getProducts();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    scrollController.addListener(() {
      loadMoreFilteredProducts();
    });
  }

  getProducts() async {
    GlobalVariable.internetErr(false);
    GlobalVariable.showLoader.value = true;
    noProductsFound.value = false;
    productList.clear();
    await ApiBaseHelper().getMethod(url: url).then((response) {
      if(response['success'] == true && response['data'] != []){
        productList.clear();
        var data = response['data'] as List;
        if(data.isEmpty){
          noProductsFound.value = true;
          GlobalVariable.showLoader.value = false;
        }
        else {
          productList.addAll(data.map((e) => ProductModel.fromJson(e)));
          GlobalVariable.showLoader.value = false;
        }
      } else {
        noProductsFound.value = true;
        GlobalVariable.showLoader.value = false;
        AppConstant.displaySnackBar(langKey.errorTitle.tr, response['message']);
        print('>>>No Products Value: ${noProductsFound.value}');
      }
    }).catchError((e) {
    //  GlobalVariable.internetErr(true);
      print(e);
      GlobalVariable.showLoader.value = false;
    });
  }

  loadMoreFilteredProducts() async {
    if (scrollController.hasClients &&
        isLoadingMore.isFalse &&
        scrollController.position.maxScrollExtent == scrollController.offset) {
      page++;
      url = 'filter?type=Discounts&limit=$limit&page=$page';
      isLoadingMore(true);
      await ApiBaseHelper().getMethod(url: url).then((response) {
        if (response['success'] == true && response['data'] != null) {
          var data = response['data'] as List;
          productList.addAll(data.map((e) => ProductModel.fromJson(e)));
          isLoadingMore(false);
        } else {
          isLoadingMore(false);
        }
      }).catchError((e) {
        isLoadingMore(false);
      });
    }
  }
}