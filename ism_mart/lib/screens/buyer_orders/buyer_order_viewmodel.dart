import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ism_mart/helper/api_base_helper.dart';
import 'package:ism_mart/helper/global_variables.dart';
import 'package:ism_mart/helper/urls.dart';
import 'package:ism_mart/models/exports_model.dart';
import 'package:ism_mart/utils/exports_utils.dart';

class BuyerOrderViewModel extends GetxController {
  ScrollController scrollController = ScrollController();
  int pageNo = 0;
  RxBool showLoader = false.obs;
  List<OrderModel> ordersList = <OrderModel>[].obs;
  Rx<OrderStats> statsModel = OrderStats().obs;

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
    GlobalVariable.internetErr(false);
    GlobalVariable.showLoader.value = true;

    ApiBaseHelper()
        .getMethod(url: Urls.getBuyerOrdersStats, withAuthorization: true)
        .then((parsedJson) {
      GlobalVariable.showLoader.value = false;
      if (parsedJson['success'] == true) {
        statsModel.value = OrderStats.fromJson(parsedJson['data']);
      }
    }).catchError((e) {
      GlobalVariable.internetErr(true);
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
              url: Urls.getBuyerOrders + pageNo.toString(),
              withAuthorization: true)
          .then((parsedJson) {
        if (parsedJson['success'] == true && parsedJson['data'] != null) {
          var data = parsedJson['data'] as List;
          if (data.isEmpty) {
            scrollController.dispose();
          }
          ordersList.addAll(data.map((e) => OrderModel.fromJson(e)));
          showLoader.value = false;
        } else {
          AppConstant.displaySnackBar(errorTitle.tr, parsedJson['message']);
        }
      }).catchError((e) {
        print(e);
        // GlobalVariable.showLoader.value = false;
      });
    }
  }
}
