import 'package:flutter/cupertino.dart';
import 'package:ism_mart/api_helper/export_api_helper.dart';
import 'package:ism_mart/models/exports_model.dart';

class ApiProvider {
  final ApiRepository _apiRepository;

  ApiProvider(this._apiRepository);

  Future<SearchProductResponse> search({text, page, limit, sortBy}) async {
// Search api call for search UI product
    // var request = http.Request(
    //     'GET',
    //     Uri.parse(
    //         'https://ismmart-api.com/api/filter?minPrice=1&maxPrice=100&type=Discounts&1000=100&page=$page&sort=low-to-high'));
    // http.StreamedResponse response = await request.send();
    // var raw = await http.Response.fromStream(response);
    // var res = jsonDecode(raw.body);

    // print("search api hit >>> $res");
    // if (response.statusCode == 200) {
    //   print(await response.stream.bytesToString());
    // } else {
    //   print(response.reasonPhrase);
    // }
    var products = await _apiRepository.searchProduct(
        text: text, page: page, limit: limit, sortBy: sortBy);

    return SearchProductResponse.fromJson(products['data']);
  }

  Future<List<ProductModel>> filterSearch({appliedFilters}) async {
    var products =
        await _apiRepository.searchFilterProducts(filters: appliedFilters);
    return products.map((product) => ProductModel.fromJson(product)).toList();
  }

  //TOO: Fetch Slider Provider
  Future<List<SliderModel>> fetchSliderImages() async {
    var response = await _apiRepository.getSliderImages();
    return response.map((json) => SliderModel.fromJson(json)).toList();
  }

  Future<List<ProductModel>> getSliderDiscountProducts() async {
    var response = await _apiRepository.fetchSliderDiscountProducts();
    return response.map((json) => ProductModel.fromJson(json)).toList();
  }

//TDO: Fetch Category Provider
  Future<List<CategoryModel>> fetchCategories() async {
    var response = await _apiRepository.getAllCategories();
    return response.map((json) => CategoryModel.fromJson(json)).toList();
  }

  Future<List<SubCategory>> fetchSubCategories({int? categoryID}) async {
    var response =
        await _apiRepository.getSubCategoriesByCategoryID(categoryID);
    return response.map((json) => SubCategory.fromJson(json)).toList();
  }

  Future<List<ProductModel>> getProductsByCategory(int id) async {
    var products = await _apiRepository.getProductsByCategory(
        endPoint: "getByCategory", id: id);

    return products.map((product) => ProductModel.fromJson(product)).toList();
  }

  Future<List<ProductModel>> getProductsBySubCategory(int id) async {
    var products = await _apiRepository.getProductsByCategory(
        endPoint: "getBySubCategory", id: id);

    return products.map((product) => ProductModel.fromJson(product)).toList();
  }

  Future<List<ProductModel>> getProductsByType({String? type, limit}) async {
    var products =
        await _apiRepository.getProductsByType(type: type, limit: limit);

    return products.map((product) => ProductModel.fromJson(product)).toList();
  }

  Future<ProductModel> getProductById(int id) async {
    var productResponse = await _apiRepository.getProductDetailsById(id: id);
    debugPrint("getProductById: ${productResponse.toString()}");
    return ProductModel.fromJson(productResponse['data']);
  }

  Future<ReviewModelResponse> getProductReviews({productId, token}) async {
    var response =
        await _apiRepository.fetchProductsReviews(productId: productId);
    return ReviewModelResponse.fromJson(response);
  }

  /// Get Vendor seller details by ID customer Side
  Future<SellerModelResponse> getVendorStoreById({token, storeID}) async {
    var response = await _apiRepository.fetchStoreDetailsByID(
        token: token, storeId: storeID);
    return SellerModelResponse.fromJson(response);
  }

  Future<List<ProductModel>> geVendorProductById(
      {token, storeID, limit, page}) async {
    var response = await _apiRepository.fetchStoreProductsById(
        token: token, storeID: storeID, limit: limit, page: page);
    return response.map((e) => ProductModel.fromJson(e)).toList();
  }

  ///Answer and Questions of product
  Future<List<QuestionModel>> geProductQuestionsById({productID}) async {
    var response =
        await _apiRepository.fetchProductQuestions(productId: productID);
    return response.map((e) => QuestionModel.fromJson(e)).toList();
  }

  Future<ApiResponse> postProductQuestion({token, model}) async {
    var response = await _apiRepository.postQuestion(token: token, data: model);
    return ApiResponse.fromJson(response);
  }

  //TDO: Cart Item APIs

  Future<List<CartModel>> getCartItems({String? token}) async {
    var cartResponse = await _apiRepository.getCartItem(token: token);
    return cartResponse.map((e) => CartModel.fromJson(e)).toList();
  }

  Future<ApiResponse> addCart({String? token, JSON? data}) async {
    var response = await _apiRepository.postCartItem(token: token, data: data);
    return ApiResponse.fromJson(response);
  }

  Future<CartResponse> deleteCartItem({String? token, int? cartId}) async {
    var response =
        await _apiRepository.deleteCartItem(token: token, id: cartId);
    return CartResponse.fromJson(response);
  }

  Future<CartResponse> updateCartItem({String? token, JSON? data}) async {
    var response =
        await _apiRepository.updateCartItem(token: token, data: data);
    return CartResponse.fromJson(response);
  }

  /**
   *
   * Flutter Stripe
   * */

  Future<JSON> postStripePaymentInfo({data}) async {
    var response = await _apiRepository.reqStripePayment(
        client_secret: ApiConstant.SECRET_KEY, body: data);
    return response;
  }

  /**
   *
   * Api Layer
   * */

  Future<CurrencyModel> convertCurrency({to, from, amount}) async {
    var response = await _apiRepository.reqCurrencyConverter(
        to: to, from: from, amount: amount);
    return CurrencyModel.fromJson(response);
  }

  /**
   *
   * FAQs
   * */

  Future<List<FAQModel>> getAllFaqs({token}) async {
    var response = await _apiRepository.fetchAllFAQ(token: token);
    return response.map((e) => FAQModel.fromJson(e)).toList();
  }
}
