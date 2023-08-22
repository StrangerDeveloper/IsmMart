import 'dart:io';

import 'package:get/get.dart';
import 'package:ism_mart/exports/export_api_helper.dart';

import '../helper/global_variables.dart';

typedef JSON = Map<String, dynamic>;

class ApiService {
  final BaseProvider _baseProvider;

  ApiService(this._baseProvider);

  Future<Response> get<T>({
    required String endpoint,
    JSON? query,
    Map<String, String>? headers,
    String? token,
    bool requiresAuthToken = false,
  }) async {
    var response;
    try {
    var customHeaders = {
      'Accept': 'application/json',
      //requiresAuthToken?'authorization' : '':'',
    };
    customHeaders.addIf(requiresAuthToken, "Authorization", "$token");

    if (headers != null) {
      customHeaders.addAll(headers);
    }

    // _baseProvider.httpClient.baseUrl = ApiConstant.baseUrl;
     response =
        await _baseProvider.get(endpoint, headers: customHeaders, query: query);

    return response;
    } on SocketException catch (error) {
      GlobalVariable.internetErr(true);
      print("ApiService: $error");
    //  AppConstant.displaySnackBar("error", Errors.noInternetError);
    //  throw Errors.noInternetError;
    }
    return response;
  }

  Future<Response> post<T>({
    required String endpoint,
    dynamic body,
    JSON? query,
    String? token,
    Map<String, String>? headers,
    bool requiresAuthToken = false,
  }) async {
    //try {
    var customHeaders = {
      'Accept': 'application/json',
      //requiresAuthToken ? 'Authorization' : '': '',
    };
    customHeaders.addIf(requiresAuthToken, "Authorization", "$token");

    if (headers != null) {
      customHeaders.addAll(headers);
    }
    // _baseProvider.httpClient.baseUrl = ApiConstant.baseUrl;

    final response = await _baseProvider.post(
      endpoint,
      body,
      headers: customHeaders,
      query: query,
    );

    /*debugPrint("ApiService: ${response.body}"
        "StCode: ${response.statusCode}"
        "UnAuth ${response.unauthorized}"
        " Error ${response.hasError}"
        "ApiService: ${response.status.isForbidden}");*/
    return response;
    // } on SocketException catch (error) {
    //   print("ApiService: $error");
    //   AppConstant.displaySnackBar("error", Errors.noInternetError);
    //   throw Errors.noInternetError;
    // }
  }

  Future<Response> postImage<T>({
    required String endpoint,
    dynamic body,
    Map<String, String>? headers,
  }) async {
    // _baseProvider.httpClient.baseUrl = ApiConstant.baseUrl;
    final response = await _baseProvider.post(
      endpoint,
      body,
      headers: headers!,
    );
    return response;
  }

  // Future<Response> postStripe<T>({
  //   required String endpoint,
  //   dynamic body,
  //   JSON? query,
  //   String? clientSecretId,
  // }) async {
  //   var customHeaders = {
  //     'Accept': '*/*',
  //     'Authorization': 'Bearer $clientSecretId',
  //     'Content-Type': 'application/x-www-form-urlencoded'
  //   };
  //
  //   _baseProvider.httpClient.baseUrl = ApiConstant.stripeBaseUrl;
  //   final response = await _baseProvider.post(
  //     endpoint,
  //     body,
  //     headers: customHeaders,
  //     query: query,
  //   );
  //   /*debugPrint("BaseUrl: after ${_baseProvider.httpClient.baseUrl}");
  //   debugPrint("STripe: ${response.body}");
  //   debugPrint("STripe: ${response.statusCode}");*/
  //   return response;
  // }

  Future<Response> put<T>({
    required String endpoint,
    JSON? body,
    JSON? query,
    Map<String, String>? headers,
    String? token,
    bool requiresAuthToken = false,
  }) async {
    var customHeaders = {
      'Accept': 'application/json',
    };

    customHeaders.addIf(requiresAuthToken, "Authorization", "$token");

    if (headers != null) {
      customHeaders.addAll(headers);
    }

    final response = await _baseProvider.put(endpoint, body,
        headers: customHeaders, query: query);

    return response;
  }

  Future<Response> patch<T>({
    required String endpoint,
    JSON? body,
    JSON? query,
    Map<String, String>? headers,
    String? token,
    bool requiresAuthToken = false,
  }) async {
    var customHeaders = {
      'Accept': 'application/json',
    };

    customHeaders.addIf(requiresAuthToken, "Authorization", "$token");

    if (headers != null) {
      customHeaders.addAll(headers);
    }
    // _baseProvider.httpClient.baseUrl = ApiConstant.baseUrl;
    final response = await _baseProvider.patch(endpoint, body,
        headers: customHeaders, query: query);

    return response;
  }

  Future<Response> delete<T>({
    required String endpoint,
    JSON? body,
    JSON? query,
    Map<String, String>? headers,
    String? token,
    bool requiresAuthToken = false,
  }) async {
    var customHeaders = {
      'Accept': 'application/json',
    };

    customHeaders.addIf(requiresAuthToken, "Authorization", "$token");
    if (headers != null) {
      customHeaders.addAll(headers);
    }
    // _baseProvider.httpClient.baseUrl = ApiConstant.baseUrl;
    final response = await _baseProvider.delete(endpoint,
        headers: customHeaders, query: query);

    return response;
  }
}
