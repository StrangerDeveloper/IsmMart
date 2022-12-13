import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get_connect/http/src/request/request.dart';

FutureOr<Request> requestInterceptor(request) async {
  debugPrint('requestInterceptor START /////////////////');
  debugPrint('   Method: ${request.method}');
  debugPrint('   Url: ${request.url}');
  debugPrint('   Headers: ${request.headers}');
  debugPrint('requestInterceptor END /////////////////');

  return request;
}