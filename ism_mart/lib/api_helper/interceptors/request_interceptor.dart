import 'dart:async';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:http/http.dart' as http;

FutureOr<Request> requestInterceptor(Request? request) async {
  /*debugPrint('requestInterceptor START /////////////////');
  debugPrint('   Method: ${request!.method}');
  debugPrint('   Url: ${request.url}');
  debugPrint('   Headers: ${request.headers}');
  if(request.files!=null)
  debugPrint('   Files: ${request.files!.files.first}');
  debugPrint('requestInterceptor END /////////////////');*/

  return request!;
}
FutureOr<dynamic> requestInterceptorMultipart(http.MultipartRequest? request) async {
 /* debugPrint('/// Multipart requestInterceptor START /////////////////');
  debugPrint('   Method: ${request!.method}');
  debugPrint('   Url: ${request.url}');
  debugPrint('   Headers: ${request.headers}');
  debugPrint('//// Multipart requestInterceptor END /////////////////');*/

  return request;
}