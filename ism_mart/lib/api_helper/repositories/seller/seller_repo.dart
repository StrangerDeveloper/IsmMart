import 'package:flutter/cupertino.dart';
import 'package:ism_mart/api_helper/api_service.dart';
import 'package:ism_mart/models/exports_model.dart';

class SellersApiRepo {
  final ApiService _apiService;

  SellersApiRepo(this._apiService);

  ///Product Variants
  Future<List<dynamic>> fetchCategoriesFields(
      {categoryId, subCategoryId}) async {
    var params = {
      "categoryId": "$categoryId",
      "subcategoryId": "$subCategoryId"
    };
    var response =
        await _apiService.get(endpoint: "categoryFields", query: params);
    return response.body['data'];
  }

  Future<dynamic> postProduct({String? token, formData}) async {
    var headers = {
      'Authorization': token!,
      'Accept': '*/*',
      //'Content-Type': 'application/x-www-form-urlencoded'
    };

    var response = await _apiService.postImage(
        endpoint: "vendor/products/add", headers: headers, body: formData);

    debugPrint("Add Prod Repo Response StCode: ${response.statusCode}");
    debugPrint("Add Prod Repo Response Strings: ${response.bodyString}");
    debugPrint(
        "Add Prod Repo Response bytes: ${response.bodyBytes.toString()}");

    return response.body;
  }

  Future<dynamic> getMyProducts(
      {String? token, int? limit = 15, int? page = 1}) async {
    final queryParameters = {"limit": "$limit", "page": "$page"};
    debugPrint("token: $token");
    var response = await _apiService.get(
        endpoint: "vendor/products/myProducts",
        query: queryParameters,
        requiresAuthToken: true,
        token: token);
    return response.body['data'];
  }

  Future<dynamic> getVendorProducts(
      {String? vendorID, int? limit = 15, int? page = 1}) async {
    final queryParameters = {"limit": "$limit", "page": "$page"};
    var response = await _apiService.get(
        endpoint: "vendor/products/$vendorID", query: queryParameters);
    return response.body['data'];
  }

  Future<dynamic> getProductDetailsById({int? id}) async {
    var response = await _apiService.get(endpoint: 'products/$id');
    return response.body;
  }

  Future<dynamic> deleteProduct({id, token}) async {
    var response = await _apiService.delete(
        endpoint: "vendor/products/delete/$id",
        token: token,
        requiresAuthToken: true);
    return response.body;
  }

  Future<dynamic> updateProduct({token, ProductModel? productModel}) async {
    var response = await _apiService.patch(
        endpoint: "vendor/products/update",
        token: token,
        body: productModel!.toUpdateProductJson(),
        requiresAuthToken: true);
    return response.body;
  }
}
