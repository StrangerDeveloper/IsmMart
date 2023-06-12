import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ism_mart/api_helper/global_variables.dart';
import 'package:ism_mart/helper/api_base_helper.dart';
import 'package:ism_mart/helper/urls.dart';
import 'package:ism_mart/models/exports_model.dart';
import 'package:ism_mart/utils/exports_utils.dart';

class SellerDashBoardViewModel extends GetxController {
  ScrollController scrollController = ScrollController();
  int pageNo = 0;
  RxBool showLoader = false.obs;
  Rx<VendorStats> vendorStats = VendorStats().obs;
  List<VendorOrder> ordersList = <VendorOrder>[].obs;

  @override
  void onReady() {
    getStats();
    getOrders();
    scrollController.addListener(() {
      getOrders();
    });
    super.onReady();
  }

  getStats() {
    GlobalVariable.showLoader.value = true;

    ApiBaseHelper()
        .getMethod(url: Urls.getSellerOrdersStats, withAuthorization: true)
        .then((parsedJson) {
      GlobalVariable.showLoader.value = false;
      if (parsedJson['success'] == true) {
        vendorStats.value = VendorStats.fromJson(parsedJson['data']);
      }
    }).catchError((e) {
      print(e);
      GlobalVariable.showLoader.value = false;
    });
  }

  getOrders() {
    if (pageNo == 0
        ? true
        : (scrollController.hasClients &&
            scrollController.position.maxScrollExtent ==
                scrollController.offset)) {
      pageNo++;
      showLoader.value = true;

      ApiBaseHelper()
          .getMethod(
              url: Urls.getVendorOrdersForDashboard + pageNo.toString(),
              withAuthorization: true)
          .then((parsedJson) {
        if (parsedJson['success'] == true && parsedJson['data'] != null) {
          var data = parsedJson['data'] as List;
          if (data.isEmpty) {
            scrollController.dispose();
          }
          ordersList.addAll(data.map((e) => VendorOrder.fromJson(e)));
          showLoader.value = false;
        } else {
          AppConstant.displaySnackBar(errorTitle.tr, parsedJson['message']);
        }
      }).catchError((e) {
        print(e);
      });
    }
  }
}
