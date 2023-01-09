import 'package:flutter/cupertino.dart';
import 'package:ism_mart/api_helper/export_api_helper.dart';
import 'package:ism_mart/models/exports_model.dart';
import 'package:ism_mart/utils/constants.dart';

class ApiProvider {
  final ApiRepository _apiRepository;

  ApiProvider(this._apiRepository);

  //TODO: Search Provider
  Future<List<ProductModel>> search({text, page, limit, sortBy}) async {
    var products = await _apiRepository.searchProduct(text: text, page: page, limit: limit, sortBy: sortBy);
    return products.map((product) => ProductModel.fromJson(product)).toList();
  }

  Future<List<ProductModel>> filterSearch({appliedFilters}) async {
    var products =
        await _apiRepository.searchFilterProducts(filters: appliedFilters);
    return products.map((product) => ProductModel.fromJson(product)).toList();
  }

  //TODO: Fetch Slider Provider
  Future<List<SliderModel>> fetchSliderImages() async {
    var response = await _apiRepository.getSliderImages();
    return response.map((json) => SliderModel.fromJson(json)).toList();
  }

  Future<List<ProductModel>> getSliderDiscountProducts() async {
    var response = await _apiRepository.fetchSliderDiscountProducts();
    return response.map((json) => ProductModel.fromJson(json)).toList();
  }

//TODO: Fetch Category Provider
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

  Future<List<ProductModel>> getProductsByType({String? type}) async {
    var products = await _apiRepository.getProductsByType(type: type);

    return products.map((product) => ProductModel.fromJson(product)).toList();
  }

  Future<ProductModel> getProductById(int id) async {
    var productResponse = await _apiRepository.getProductDetailsById(id: id);
    debugPrint("getProductById: ${productResponse.toString()}");
    return ProductModel.fromJson(productResponse['data']);

    //return products.map((product) => ProductModel.fromJson(product)).first;
  }

  //TODO: Cart Item APIs
  //TODO:

  Future<List<CartModel>> getCartItems({String? token}) async {
    var cartResponse = await _apiRepository.getCartItem(token: token);
    return cartResponse.map((e) => CartModel.fromJson(e)).toList();
  }

  Future<CartResponse> addCart({String? token, JSON? data}) async {
    var response = await _apiRepository.postCartItem(token: token, data: data);
    return CartResponse.fromJson(response);
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
        client_secret: AppConstant.SECRET_KEY, body: data);
    return response;
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
