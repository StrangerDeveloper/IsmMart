import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:ism_mart/api_helper/export_api_helper.dart';
import 'package:ism_mart/controllers/controllers.dart';
import 'package:ism_mart/models/exports_model.dart';
import 'package:ism_mart/utils/exports_utils.dart';

class BuyerOrderController extends GetxController with StateMixin {
  final OrderProvider _orderProvider;

  BuyerOrderController(this._orderProvider);

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
    }).catchError((error) {
      isLoading(false);
      debugPrint(">>>>FetchOrderStats: $error");
    });
  }

  fetchOrders() async {
    change(null, status: RxStatus.loading());
    await _orderProvider
        .getMyOrders(token: authController.userToken)
        .then((data) {
      change(data, status: RxStatus.success());
    }).catchError((error) {
      debugPrint(">>>>FetchOrderStats: $error");
      change(null, status: RxStatus.error(error));
    });
  }

  fetchOrderById(OrderModel model) async {
    await _orderProvider.getMyOrdersDetails(token: authController.userToken, orderId: model.id)
       .then((value) {

    }).catchError((error) {
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
