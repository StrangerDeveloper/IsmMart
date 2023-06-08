import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ism_mart/api_helper/api_base_helper.dart';
import 'package:ism_mart/api_helper/urls.dart';
import 'package:ism_mart/models/exports_model.dart';
import 'package:ism_mart/utils/exports_utils.dart';

class VendorOrdersViewModel extends GetxController {
  // int selectedTabIndex = 0;

  ///////////////////Pending/////////////////
  ScrollController pendingScrollController = ScrollController();
  int pendingPageNo = 0;
  RxBool pendingLoader = false.obs;
  List<VendorOrder> pendingOrdersList = <VendorOrder>[].obs;

  ///////////////////Accepted/////////////////
  ScrollController acceptedScrollController = ScrollController();
  int acceptedPageNo = 0;
  RxBool acceptedLoader = false.obs;
  List<VendorOrder> acceptedOrdersList = <VendorOrder>[].obs;

  ///////////////////Shipped/////////////////
  ScrollController shippedScrollController = ScrollController();
  int shippedPageNo = 0;
  RxBool shippedLoader = false.obs;
  List<VendorOrder> shippedOrdersList = <VendorOrder>[].obs;

  ///////////////////Delivered/////////////////
  ScrollController deliveredScrollController = ScrollController();
  int deliveredPageNo = 0;
  RxBool deliveredLoader = false.obs;
  List<VendorOrder> deliveredOrdersList = <VendorOrder>[].obs;

  ///////////////////Delivered/////////////////
  ScrollController cancelledScrollController = ScrollController();
  int cancelledPageNo = 0;
  RxBool cancelledLoader = false.obs;
  List<VendorOrder> cancelledOrdersList = <VendorOrder>[].obs;

  @override
  void onReady() {
    getPendingData();
    pendingScrollController.addListener(() {
      getPendingData();
    });
    getAcceptedData();
    acceptedScrollController.addListener(() {
      getAcceptedData();
    });
    getShippedData();
    shippedScrollController.addListener(() {
      getShippedData();
    });
    getDeliveredData();
    deliveredScrollController.addListener(() {
      getDeliveredData();
    });
    getCancelledData();
    cancelledScrollController.addListener(() {
      getCancelledData();
    });
    super.onReady();
  }

  getPendingData() {
    if (pendingPageNo == 0
        ? true
        : (pendingScrollController.hasClients &&
            pendingScrollController.position.maxScrollExtent ==
                pendingScrollController.offset)) {
      pendingPageNo++;
      pendingLoader.value = true;

      ApiBaseHelper()
          .getMethod(
              url:
                  '${Urls.getVendorOrders}page=${pendingPageNo}&status=pending',
              withAuthorization: true)
          .then((parsedJson) {
        if (parsedJson['success'] == true && parsedJson['data'] != null) {
          var data = parsedJson['data'] as List;
          if (data.isEmpty) {
            pendingScrollController.dispose();
          }
          pendingOrdersList.addAll(data.map((e) => VendorOrder.fromJson(e)));
          pendingLoader.value = false;
        } else {
          AppConstant.displaySnackBar(errorTitle.tr, parsedJson['message']);
        }
      }).catchError((e) {
        print(e);
        // GlobalVariable.showLoader.value = false;
      });
    }
  }

  getAcceptedData() {
    if (acceptedPageNo == 0
        ? true
        : (acceptedScrollController.hasClients &&
            acceptedScrollController.position.maxScrollExtent ==
                acceptedScrollController.offset)) {
      acceptedPageNo++;
      acceptedLoader.value = true;

      ApiBaseHelper()
          .getMethod(
              url:
                  '${Urls.getVendorOrders}page=${pendingPageNo}&status=approved',
              withAuthorization: true)
          .then((parsedJson) {
        if (parsedJson['success'] == true && parsedJson['data'] != null) {
          var data = parsedJson['data'] as List;
          if (data.isEmpty) {
            acceptedScrollController.dispose();
          }
          acceptedOrdersList.addAll(data.map((e) => VendorOrder.fromJson(e)));
          acceptedLoader.value = false;
        } else {
          AppConstant.displaySnackBar(errorTitle.tr, parsedJson['message']);
        }
      }).catchError((e) {
        print(e);
        // GlobalVariable.showLoader.value = false;
      });
    }
  }

  getShippedData() {
    if (shippedPageNo == 0
        ? true
        : (shippedScrollController.hasClients &&
            shippedScrollController.position.maxScrollExtent ==
                shippedScrollController.offset)) {
      shippedPageNo++;
      shippedLoader.value = true;

      ApiBaseHelper()
          .getMethod(
              url:
                  '${Urls.getVendorOrders}page=${pendingPageNo}&status=shipped',
              withAuthorization: true)
          .then((parsedJson) {
        if (parsedJson['success'] == true && parsedJson['data'] != null) {
          var data = parsedJson['data'] as List;
          if (data.isEmpty) {
            shippedScrollController.dispose();
          }
          shippedOrdersList.addAll(data.map((e) => VendorOrder.fromJson(e)));
          shippedLoader.value = false;
        } else {
          AppConstant.displaySnackBar(errorTitle.tr, parsedJson['message']);
        }
      }).catchError((e) {
        print(e);
        // GlobalVariable.showLoader.value = false;
      });
    }
  }

  getDeliveredData() {
    if (deliveredPageNo == 0
        ? true
        : (deliveredScrollController.hasClients &&
            deliveredScrollController.position.maxScrollExtent ==
                deliveredScrollController.offset)) {
      deliveredPageNo++;
      deliveredLoader.value = true;

      ApiBaseHelper()
          .getMethod(
              url:
                  '${Urls.getVendorOrders}page=${deliveredPageNo}&status=delivered',
              withAuthorization: true)
          .then((parsedJson) {
        if (parsedJson['success'] == true && parsedJson['data'] != null) {
          var data = parsedJson['data'] as List;
          if (data.isEmpty) {
            deliveredScrollController.dispose();
          }
          deliveredOrdersList.addAll(data.map((e) => VendorOrder.fromJson(e)));
          deliveredLoader.value = false;
        } else {
          AppConstant.displaySnackBar(errorTitle.tr, parsedJson['message']);
        }
      }).catchError((e) {
        print(e);
        // GlobalVariable.showLoader.value = false;
      });
    }
  }

  getCancelledData() {
    if (cancelledPageNo == 0
        ? true
        : (cancelledScrollController.hasClients &&
            cancelledScrollController.position.maxScrollExtent ==
                cancelledScrollController.offset)) {
      cancelledPageNo++;
      cancelledLoader.value = true;

      ApiBaseHelper()
          .getMethod(
              url:
                  '${Urls.getVendorOrders}page=${deliveredPageNo}&status=cancelled',
              withAuthorization: true)
          .then((parsedJson) {
        if (parsedJson['success'] == true && parsedJson['data'] != null) {
          var data = parsedJson['data'] as List;
          if (data.isEmpty) {
            cancelledScrollController.dispose();
          }
          cancelledOrdersList.addAll(data.map((e) => VendorOrder.fromJson(e)));
          cancelledLoader.value = false;
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
