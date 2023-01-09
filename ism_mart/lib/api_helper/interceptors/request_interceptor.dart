import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get_connect/http/src/request/request.dart';

FutureOr<Request> requestInterceptor(Request? request) async {
  debugPrint('requestInterceptor START /////////////////');
  debugPrint('   Method: ${request!.method}');
  debugPrint('   Url: ${request.url}');
  debugPrint('   Headers: ${request.headers}');
  if(request.files!=null)
  debugPrint('   Files: ${request.files!.files.first}');
  debugPrint('requestInterceptor END /////////////////');

  return request;
}