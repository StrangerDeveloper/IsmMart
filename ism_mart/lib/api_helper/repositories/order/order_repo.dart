import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:ism_mart/api_helper/export_api_helper.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class OrderRepository {
  final ApiService _apiService;

  OrderRepository(this._apiService);

  Future<List<dynamic>> fetchBuyerOrders({token, limit = 20, page = 1}) async {
    var queryParams = {"limit": "$limit", "page": "$page"};
    var response = await _apiService.get(
        endpoint: 'order/myOrders',
        query: queryParams,
        requiresAuthToken: true,
        token: token);
    return response.body['data'];
  }

  Future<List<dynamic>> fetchVendorOrders({token, status}) async {
    var queryParams = {"status": "$status"};
    var response = await _apiService.get(
        endpoint: 'order/vendorOrders',
        query: queryParams,
        requiresAuthToken: true,
        token: token);
    return response.body['data'];
  }

  Future<dynamic> fetchBuyerOrdersDetails({token, orderId}) async {
    var response = await _apiService.get(
        endpoint: 'order/orderDetails/$orderId',
        requiresAuthToken: true,
        token: token);
    return response.body['data'];
  }

  Future<dynamic> fetchVendorOrdersDetails({token, orderId}) async {
    var response = await _apiService.get(
        endpoint: 'order/vendorOrders/$orderId',
        requiresAuthToken: true,
        token: token);
    return response.body['data'];
  }

  Future<dynamic> fetchBuyerOrderStats({token}) async {
    var response = await _apiService.get(
        endpoint: 'order/userStats', requiresAuthToken: true, token: token);
    return response.body;
  }

  Future<dynamic> fetchVendorOrderStats({token}) async {
    var response = await _apiService.get(
        endpoint: 'order/vendorStats', requiresAuthToken: true, token: token);
    return response.body;
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

  Future<dynamic> postDispute(
      {token, title, description, orderItemId, imagesList}) async {
    final url = "${ApiConstant.baseUrl}tickets/add";
    final request = http.MultipartRequest('POST', Uri.parse(url));
    request.headers['Authorization'] = '$token';
    request.headers['Content-Type'] = 'multipart/form-data';

    request.fields['title'] = "${title}";
    request.fields['description'] = "${description}";
    request.fields['orderItemsId'] = "${orderItemId}";

    if (imagesList!.isNotEmpty) {
      for (File image in imagesList) {
        request.files.add(await http.MultipartFile.fromPath(
          'images',
          image.path,
          contentType: MediaType.parse('image/jpeg'),
        ));
      }

      final response = await request.send();
      if (response.statusCode == 200) {
        final responseData = await response.stream.bytesToString();
        final data = json.decode(responseData);
        print(responseData);
        print(data);
        return data;
      } else {
        //TDO: Still needs to test this one properly
        http.StreamedResponse res = handleStreamResponse(response);
        return json.decode(await res.stream.bytesToString());
      }
    }
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

  /// Payment Apis
  Future<dynamic> postReview({token, data}) async {
    var response = await _apiService.post(
        endpoint: "productReviews/add",
        body: data,
        requiresAuthToken: true,
        token: token);
    return response.body;
  }
}
