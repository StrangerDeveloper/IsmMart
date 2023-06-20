import 'package:flutter/cupertino.dart';
import 'package:ism_mart/exports/export_api_helper.dart';

class OrderRepository {
  final ApiService _apiService;

  OrderRepository(this._apiService);


  Future<dynamic> fetchBuyerOrdersDetails({token, orderId}) async {
    var response = await _apiService.get(
        endpoint: 'order/orderDetails/$orderId',
        requiresAuthToken: true,
        token: token);
    return response.body != null ? response.body['data'] : null;
  }

  Future<dynamic> fetchVendorOrdersDetails({token, orderId}) async {
    var response = await _apiService.get(
        endpoint: 'order/vendorOrders/$orderId',
        requiresAuthToken: true,
        token: token);
    return response.body != null ? response.body['data'] : null;
  }

  Future<dynamic> postOrder({token, data}) async {
    var response = await _apiService.post(
        endpoint: "order/createOrder",
        body: data,
        requiresAuthToken: true,
        token: token);
    debugPrint("PostOrder: ${response.statusCode}");
    debugPrint("PostOrder: ${response.body}");
    return response.body;
  }


  Future<dynamic> postReview({token, data}) async {
    var response = await _apiService.post(
        endpoint: "productReviews/add",
        body: data,
        requiresAuthToken: true,
        token: token);
    return response.body;
  }

  /// Payment Apis
  Future<dynamic> postPaymentIntent({token, data}) async {
    var response = await _apiService.post(
        endpoint: "payment/paymentIntent",
        body: data,
        requiresAuthToken: true,
        token: token);
    return response.body;
  }
}
