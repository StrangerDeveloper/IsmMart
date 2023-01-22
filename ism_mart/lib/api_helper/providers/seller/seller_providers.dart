import 'package:flutter/cupertino.dart';
import 'package:ism_mart/api_helper/export_api_helper.dart';
import 'package:ism_mart/models/exports_model.dart';


class SellersApiProvider {
  final SellersApiRepo _sellersApiRepo;

  SellersApiProvider(this._sellersApiRepo);

  Future<List<ProductVariantsModel>> getProductVariantsFieldsByCategories(
      {catId, subCatId}) async {
    var fieldsResponse = await _sellersApiRepo.fetchCategoriesFields(
        categoryId: catId, subCategoryId: subCatId);
    return fieldsResponse
        .map((field) => ProductVariantsModel.fromJson(field))
        .toList();
  }
  Future<ProductResponse> addProduct({String? token, formData, imagesList}) async {
    //var tokenNew = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjQ4LCJpYW0iOiJ2ZW5kb3IiLCJ2aWQiOjQzLCJpYXQiOjE2NzIwNDcyNDk0NTUsImV4cCI6MTY3MjIyMDA0OTQ1NX0.B85lvOzdzG-EK261Wbd1hEfn1mZjxggXBfKf8k3xfDE";
    var response =
        await _sellersApiRepo.postProduct(token: token, formData: formData);
    //debugPrint("Add Prod provider Response: $response");


    // var headers = {
    //   'Authorization': token!,
    //   'Accept': '*/*'
    // };

   /*  var response = await await http.post(
         Uri.parse('${ApiConstant.baseUrl}vendor/products/add'),
       headers: {
         'Authorization': '$token',
         'Content-Type': 'application/json'
       },
       body: json.encode(formData),
       //encoding: 'charset=utf-8',
     );*/

    return ProductResponse.fromResponse(response);
    /*return response != null
        ? ProductResponse.fromResponse(response)
        : ProductResponse();*/
  }

  Future<SellerProductModel> fetchMyProducts({String? token}) async {
    debugPrint("token: $token");
    var products = await _sellersApiRepo.getMyProducts(token: token);
    return SellerProductModel.fromJson(products);
    //return products.map((product) => ProductModel.fromJson(product)).toList();
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
