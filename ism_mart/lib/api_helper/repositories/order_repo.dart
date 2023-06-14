import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:ism_mart/api_helper/export_api_helper.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

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

  Future<dynamic> postDispute(
      {token, title, description, orderItemId, imagesList}) async {
    final url = "${ApiConstant.baseUrl}tickets/add";
    var headers = {'authorization': '$token', 'Cookie': 'XSRF-token=$token'};
    final request = http.MultipartRequest('POST', Uri.parse(url));
    request.headers.addAll(headers);
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
      //var response = await request.send();
      http.StreamedResponse response = await request.send();
      return json.decode(await response.stream.bytesToString());
    }
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