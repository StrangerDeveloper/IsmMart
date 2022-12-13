import 'package:flutter/cupertino.dart';
import 'package:ism_mart/api_helper/export_api_helper.dart';

class OrderRepository {

  final ApiService _apiService;
  OrderRepository(this._apiService);

  Future<List<dynamic>> fetchMyOrders({token}) async {
    var response = await _apiService.get(endpoint: 'order/myOrders', requiresAuthToken: true, token: token);
    return response.body['data'];
  }


  Future<dynamic> fetchMyOrdersDetails({token, orderId}) async {
    var response = await _apiService.get(endpoint: 'order/orderDetails/$orderId', requiresAuthToken: true, token: token);
    return response.body['data'];
  }

  Future<dynamic> fetchOrderStats({token}) async{
    var response = await _apiService.get(endpoint: 'order/userStats', requiresAuthToken: true, token: token);
    return response.body;
  }


  Future<dynamic> postOrder({token, data}) async {
    var response = await _apiService.post(
      endpoint: "order/createOrder",
      body: data,
      requiresAuthToken: true,
      token: token
    );
    debugPrint("PostOrder: ${response.statusCode}");
    debugPrint("PostOrder: ${response.body}");
    return response.body;
  }


}