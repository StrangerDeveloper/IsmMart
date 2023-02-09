import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ism_mart/api_helper/export_api_helper.dart';
import 'package:ism_mart/models/exports_model.dart';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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

  Future<ProductResponse> addProduct(
      {String? token, formData, imagesList}) async {
    var response =
        await _sellersApiRepo.postProduct(token: token, formData: formData);
    return ProductResponse.fromResponse(response);
  }

  Future<ProductResponse> addProductWithHttp(
      {String? token,
      ProductModel? model,
      categoryFieldList,
      images}) async {
    final url = "${ApiConstant.baseUrl}vendor/products/add";
    final request = http.MultipartRequest('POST', Uri.parse(url));
    request.headers['Authorization'] = '$token';
    //request.headers['Content-Type'] = 'application/json';
    request.headers['Content-Type'] = 'multipart/form-data';
    request.fields['name'] = model!.name!;
    request.fields['price'] = "${model.price}";
    request.fields['stock'] = "${model.stock}";
    request.fields['categoryId'] = "${model.categoryId}";
    request.fields['subCategoryId'] = "${model.subCategoryId}";
    request.fields['discount'] = "${model.discount}";
    request.fields['description'] = "${model.description}";

    if (categoryFieldList.isNotEmpty)
      for (var i = 0; i < categoryFieldList.entries.length; i++) {
        request.fields['features[$i][id]'] =
            "${categoryFieldList.entries.elementAt(i).key}";
        request.fields['features[$i][value]'] =
            "${categoryFieldList.entries.elementAt(i).value}";
      }

    for (XFile image in images) {
      request.files.add(await http.MultipartFile.fromPath(
        'images',
        image.path,
        contentType: MediaType.parse('image/jpeg'),
      ));
    }

    final response = await request.send();
    if (response.statusCode == 200) {
      final responseData = await response.stream.bytesToString();
      final data = json.decode(responseData);
      print(data);
      return ProductResponse.fromResponse(responseData);
    } else {
       throw Exception('Failed to upload image ${response.statusCode} ${json.decode(await response.stream.bytesToString())}');
    }
    return ProductResponse.fromResponse(response);
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
