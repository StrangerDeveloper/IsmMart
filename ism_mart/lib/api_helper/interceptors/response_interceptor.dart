import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';

FutureOr<dynamic> responseInterceptor(
    Request request, Response response) async {
  return handelResponse(response);
}

dynamic handelResponse(response) {
  debugPrint('RESPONSE START /////////////////');
  debugPrint('  Status Code: ${response.statusCode}');
  debugPrint('  Body: ${response.body}');
  debugPrint('RESPONSE END /////////////////');

  switch (response.statusCode) {
    case 200:
      return response;
    case 400:
    case 404:
    case 403:
      return response;
    case 500:
      return response;
    default:
      return response;

      throw UnknownException(
          'Error accrued while fetching data. : ${response.statusCode}');
  }
}

class AppException implements Exception {
  final String? code, message, details;

  AppException({this.code, this.message, this.details});

  @override
  String toString() {
    return "[$code]: $message \n $details";
  }
}

class UnknownException extends AppException {
  UnknownException(String message) : super(code: "010", message: message);
}
