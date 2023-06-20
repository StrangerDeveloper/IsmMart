import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:ism_mart/exports/export_api_helper.dart';

class ApiRepository {
  final ApiService _apiService;

  ApiRepository(this._apiService);

  Future<dynamic> searchProduct({text, page, limit = 10, sortBy}) async {
    final queryParameters = {
      "text": "$text",
      "limit": "$limit",
      "page": "$page"
    };
    queryParameters.addIf(sortBy != null, 'sort', '$sortBy');
    var response =
        await _apiService.get(endpoint: "search/", query: queryParameters);
    return response.body;
  }

  Future<List<dynamic>> searchFilterProducts({filters}) async {
    var response = await _apiService.get(endpoint: "filter", query: filters);
    return response.body != null ? response.body['data'] : [];
  }

  Future<List<dynamic>> getSliderImages() async {
    var response = await _apiService.get(endpoint: "slider");
    return response.body != null ? response.body['data'] : [];
  }

  Future<List<dynamic>> fetchSliderDiscountProducts() async {
    var queryParam = {"limit": "3"};
    var response = await _apiService.get(
        endpoint: "slider/getDiscountProducts", query: queryParam);
    return response.body != null ? response.body['data'] : [];
  }

  Future<List<dynamic>> getAllCategories() async {
    var response = await _apiService.get(endpoint: "category");
    return response.body != null ? response.body['data'] : [];
  }

  Future<List<dynamic>> getCategoriesWithSubCategories() async {
    var response = await _apiService.get(endpoint: "category/");
    return response.body != null ? response.body['data'] : [];
  }

  Future<List<dynamic>> getSubCategoriesByCategoryID(int? categoryId) async {
    var response = await _apiService.get(endpoint: "subcategory/$categoryId");
    return response.body != null ? response.body['data'] : [];
  }

  Future<List<dynamic>> getProductsByType(
      {int? limit = 15, int? page = 1, String? type = "Discount"}) async {
    final queryParameters = {"limit": "$limit", "page": "$page", "type": type};
    var response =
        await _apiService.get(endpoint: "products/", query: queryParameters);
    return response.body != null ? response.body['data'] : [];
  }

  Future<List<dynamic>> fetchAllProducts({int? limit = 30}) async {
    final queryParameters = {"limit": "$limit"};
    var response =
        await _apiService.get(endpoint: "products/", query: queryParameters);
    return response.body != null ? response.body['data'] : [];
  }

  // same for categoryById and SubCategoryById
  Future<List<dynamic>> getProductsByCategory(
      {required String? endPoint,
      int? limit = 20,
      int? page = 1,
      required int? id}) async {
    final queryParameters = {"limit": "$limit", "page": "$page", "id": "$id"};
    var response = await _apiService.get(
        endpoint: "products/$endPoint/", query: queryParameters);
    return response.body != null ? response.body['data'] : [];
  }

  Future<dynamic> getProductDetailsById({int? id}) async {
    var response = await _apiService.get(endpoint: 'products/$id');
    return response.body;
  }

  Future<dynamic> fetchProductsReviews({productId, token}) async {
    var response =
        await _apiService.get(endpoint: 'productReviews/allReviews/$productId');
    return response.body != null ? response.body['data'] : null;
  }

  ///Fetch store details by id customerSide
  Future<dynamic> fetchStoreDetailsByID({token, storeId}) async {
    var response = await _apiService.get(endpoint: 'vendor/store/$storeId');
    return response.body != null ? response.body['data'] : null;
  }

  Future<List<dynamic>> fetchStoreProductsById(
      {token, storeID, limit = 30, page = 1}) async {
    final queryParameters = {"limit": "$limit", "page": "$page"};
    var response = await _apiService.get(
        endpoint: 'vendor/products/$storeID',
        requiresAuthToken: true,
        token: token,
        query: queryParameters);
    return response.body != null ? response.body['data'] : [];
  }

  /// Product Answer and Questions

  Future<List<dynamic>> fetchProductQuestions({productId}) async {
    var response =
        await _apiService.get(endpoint: 'product/questions/$productId');
    return response.body != null ? response.body['data'] : [];
  }

  Future<dynamic> postQuestion({token, data}) async {
    var response = await _apiService.post(
        endpoint: "product/questions/add",
        body: data,
        requiresAuthToken: true,
        token: token);
    return response.body;
  }

  //TDO: Cart Repo

  Future<dynamic> postCartItem({token, data}) async {
    var response = await _apiService.post(
        endpoint: 'cart/add',
        body: data,
        token: token,
        requiresAuthToken: true);
    return response.body;
  }

  Future<List<dynamic>> getCartItem({token}) async {
    var response = await _apiService.get(
        endpoint: 'cart', token: token, requiresAuthToken: true);
    return response.body != null ? response.body['data'] : [];
  }

  Future<dynamic> deleteCartItem({token, id}) async {
    var response = await _apiService.delete(
        endpoint: 'cart/delete/$id', token: token, requiresAuthToken: true);
    return response.body;
  }

  Future<dynamic> updateCartItem({token, data}) async {
    var response = await _apiService.patch(
        endpoint: 'cart/update',
        body: data,
        token: token,
        requiresAuthToken: true);
    return response.body;
  }

  /**
   * Create Order
   *
   * */

  Future<dynamic> postOrder({token, data}) async {
    var response = await _apiService.post(
        endpoint: "order/createOrder",
        body: data,
        requiresAuthToken: true,
        token: token);
    return response.body;
  }

  /**
   *
   * Flutter Stripe Integration
   * */

  Future<dynamic> reqStripePayment({client_secret, body}) async {
    var response = await http.post(
      Uri.parse('https://api.stripe.com/v1/payment_intents'),
      headers: {
        //'Authorization': 'Bearer $client_secret',
        'Content-Type': 'application/x-www-form-urlencoded'
      },
      body: body,
    );
    return json.decode(response.body);
  }

  /**
   *
   * Flutter Api Layer exchange currency Api
   * */

  Future<dynamic> reqCurrencyConverter({to, from, amount}) async {
    var response = await http.get(
      Uri.parse(
          'https://api.apilayer.com/exchangerates_data/convert?to=$to&from=$from&amount=$amount'),
      headers: {
        //'Authorization': 'Bearer $client_secret',
        'apikey': ApiConstant.CURRENCY_EXCHANGE_API_KEY,
      },
    );
    return json.decode(response.body);
  }
}
