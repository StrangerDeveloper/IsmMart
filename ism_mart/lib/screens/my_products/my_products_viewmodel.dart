import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ism_mart/helper/api_base_helper.dart';
import 'package:ism_mart/helper/global_variables.dart';
import 'package:ism_mart/helper/urls.dart';
import 'package:ism_mart/screens/my_products/vendor_product_model.dart';
import 'package:ism_mart/exports/exports_utils.dart';
import 'package:ism_mart/utils/languages/translations_key.dart' as langKey;

class MyProductsViewModel extends GetxController {
  ScrollController scrollController = ScrollController();
  List<VendorProduct> myProductsList = <VendorProduct>[].obs;
  int page = 1;
  RxBool isLoadingMore = false.obs;

  @override
  void onReady() {
    loadInitialProducts();
    scrollController..addListener(() => loadMoreProducts());
    super.onReady();
  }

  loadInitialProducts() {
    GlobalVariable.internetErr(false);
    page = 1;
    GlobalVariable.showLoader.value = true;

    ApiBaseHelper()
        .getMethod(url: Urls.getMyProducts + '1', withAuthorization: true)
        .then((parsedJson) {
      GlobalVariable.showLoader.value = false;
      if (parsedJson['message'] == 'Products fetched successfully') {
        myProductsList.clear();
        var data = parsedJson['data']['products'] as List;
        myProductsList.addAll(data.map((e) => VendorProduct.fromJson(e)));
      } else {
        AppConstant.displaySnackBar(errorTitle.tr, parsedJson['message']);
      }
    }).catchError((e) {
      GlobalVariable.internetErr(true);
      print(e);
      GlobalVariable.showLoader.value = false;
    });
  }

  deleteProduct(String productId, {required int index}) {
    GlobalVariable.internetErr(false);
    ApiBaseHelper()
        .deleteMethod(
            url: Urls.deleteProduct + productId, withAuthorization: true)
        .then((parsedJson) {
      if (parsedJson['success'] == true && parsedJson['data'] != null) {
        GlobalVariable.internetErr(false);
        Get.back();
        myProductsList.removeAt(index);

        AppConstant.displaySnackBar(
          langKey.success.tr,
          parsedJson['message'],
        );
      } else {
        AppConstant.displaySnackBar(
          langKey.errorTitle.tr,
          langKey.recordDoNotExist.tr,
        );
      }
    }).catchError((e) {
      GlobalVariable.internetErr(true);
      print(e);
    });
  }

  loadMoreProducts() {
    if (scrollController.hasClients &&
        isLoadingMore.isFalse &&
        scrollController.position.maxScrollExtent == scrollController.offset) {
      isLoadingMore(true);
      page++;
      GlobalVariable.showLoader.value = true;

      ApiBaseHelper()
          .getMethod(
              url: Urls.getMyProducts + page.toString(),
              withAuthorization: true)
          .then((parsedJson) {
        GlobalVariable.showLoader.value = false;
        isLoadingMore(false);
        if (parsedJson['message'] == 'Products fetched successfully') {
          var data = parsedJson['data']['products'] as List;
          myProductsList.addAll(data.map((e) => VendorProduct.fromJson(e)));
        } else {
          GlobalVariable.internetErr(true);

          //   AppConstant.displaySnackBar(errorTitle.tr, parsedJson['message']);
        }
      }).catchError((e) {
        GlobalVariable.internetErr(true);

        print(e);
        GlobalVariable.showLoader.value = false;
      });
    }
  }
}
