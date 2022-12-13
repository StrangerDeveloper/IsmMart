import 'package:flutter/cupertino.dart';
import 'package:ism_mart/api_helper/export_api_helper.dart';
import 'package:ism_mart/models/exports_model.dart';

class SellersApiProvider {
  final SellersApiRepo _sellersApiRepo;

  SellersApiProvider(this._sellersApiRepo);

  Future<ProductResponse> addProduct({String? token, model}) async {
    var response =
        await _sellersApiRepo.postProduct(token: token, formData: model);
    //debugPrint("Add Prod provider Response: $response");
    return response != null
        ? ProductResponse.fromResponse(response)
        : ProductResponse();
  }

  Future<List<ProductModel>> fetchMyProducts({String? token}) async {
    debugPrint("token: $token");
    var products = await _sellersApiRepo.getMyProducts(token: token);
    return products.map((product) => ProductModel.fromJson(product)).toList();
  }

  Future<ProductResponse> deleteProductById({id, token}) async {
    var response = await _sellersApiRepo.deleteProduct(id: id, token: token);
    return ProductResponse.fromResponse(response);
  }

  Future<ProductResponse> updateProduct(
      {String? token, ProductModel? model}) async {
    var response =
        await _sellersApiRepo.updateProduct(token: token, productModel: model);
    debugPrint("Update Prod provider Response: $response");
    return response != null
        ? ProductResponse.fromResponse(response)
        : ProductResponse();
  }
}
