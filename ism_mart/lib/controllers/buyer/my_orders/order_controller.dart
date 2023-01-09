import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ism_mart/api_helper/export_api_helper.dart';
import 'package:ism_mart/controllers/controllers.dart';
import 'package:ism_mart/models/exports_model.dart';
import 'package:ism_mart/utils/exports_utils.dart';

class OrderController extends GetxController
    with StateMixin, GetSingleTickerProviderStateMixin {
  final OrderProvider _orderProvider;

  OrderController(this._orderProvider);

  late var tabController;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    tabController = TabController(initialIndex: 0, length: 2, vsync: this);
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    fetchOrderStats();
  }

  var isLoading = false.obs;
  var _orderStats = OrderStats().obs;

  OrderStats? get orderStats => _orderStats.value;

  fetchOrderStats() async {
    isLoading(true);

    await _orderProvider
            .getOrderStats(token: authController.userToken!)
            .then((OrderResponse? response) {
      isLoading(false);
      if (response != null) {
        if (response.success!) {
          _orderStats(response.data);
        } else
          showSnackBar(message: response.message);
      }
    }) /*.catchError((error) {
      isLoading(false);
      debugPrint(">>>>FetchOrderStats: $error");
    })*/
        ;
  }

  var recentBuyerOrdersList = <OrderModel>[].obs;
  var recentVendorOrdersList = <OrderModel>[].obs;

  fetchOrders() async {
    change(null, status: RxStatus.loading());
    recentBuyerOrdersList.clear();
    await _orderProvider
            .getBuyerOrders(token: authController.userToken)
            .then((data) {
      change(data, status: RxStatus.success());
      recentBuyerOrdersList.addAll(data);
    }) .catchError((error) {
      debugPrint(">>>>FetchOrderStats: $error");
      change(null, status: RxStatus.error(error));
    });
  }

  fetchVendorOrders() async {
    //change(null, status: RxStatus.loading());

    recentVendorOrdersList.clear();
    await _orderProvider
        .getVendorOrders(token: authController.userToken, status: "pending")
        .then((data) {
      //change(data, status: RxStatus.success());
      recentVendorOrdersList.addAll(data);
    }) .catchError((error) {
      debugPrint(">>>>fetchVendorOrders: $error");
      //change(null, status: RxStatus.error(error));
    });
  }

  fetchOrderById(OrderModel model) async {
    await _orderProvider
        .getMyOrdersDetails(token: authController.userToken, orderId: model.id)
        .then((value) {})
        .catchError((error) {
      debugPrint(">>>>fetchOrderById: $error");
    });
  }

  void showSnackBar({title = 'error', message = 'Something went wrong'}) {
    AppConstant.displaySnackBar(title, message);
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}
