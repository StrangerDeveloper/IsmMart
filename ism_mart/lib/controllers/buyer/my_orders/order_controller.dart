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

  late var tabController;

  var isLoading = false.obs;

  var _orderStats = OrderStats().obs;

  var _vendorStats = VendorStats().obs;

  var recentBuyerOrdersList = <OrderModel>[].obs;
  var recentVendorOrdersList = <VendorOrder>[].obs;
  OrderController(this._orderProvider);

  OrderStats? get orderStats => _orderStats.value;
  VendorStats? get vendorStats => _vendorStats.value;

  fetchBuyerOrderStats() async {
    isLoading(true);

    await _orderProvider
            .getBuyerOrderStats(token: authController.userToken!)
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
  fetchOrderById(OrderModel model) async {
    await _orderProvider
        .getMyOrdersDetails(token: authController.userToken, orderId: model.id)
        .then((value) {})
        .catchError((error) {
      debugPrint(">>>>fetchOrderById: $error");
    });
  }

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
  fetchVendorOrders({String? status}) async {
    change(null, status: RxStatus.loading());
    recentVendorOrdersList.clear();
    await _orderProvider
        .getVendorOrders(token: authController.userToken, status: status!)
        .then((data) {
      change(data, status: RxStatus.success());
      recentVendorOrdersList.addAll(data);
    })/*.catchError((error) {
      debugPrint(">>>>fetchVendorOrders: $error");
      change(null, status: RxStatus.error(error));
    })*/;
  }

  fetchVendorOrderStats() async {
    isLoading(true);

    await _orderProvider
        .getVendorOrderStats(token: authController.userToken!)
        .then((OrderResponse? response) {
      isLoading(false);
      if (response != null) {
        if (response.success!) {
          _vendorStats(response.data);
        } else
          showSnackBar(message: response.message);
      }
    }) .catchError((error) {
      isLoading(false);
      debugPrint(">>>>FetchOrderStats: $error");
    });
  }

  @override
  void onClose() {

    super.onClose();
  }

  @override
  void onInit() {

    super.onInit();
    tabController = TabController(initialIndex: 0, length: 5, vsync: this);
  }

  @override
  void onReady() {
    super.onReady();
    fetchBuyerOrderStats();
  }

  void showSnackBar({title = 'error', message = 'Something went wrong'}) {
    AppConstant.displaySnackBar(title, message);
  }
}
