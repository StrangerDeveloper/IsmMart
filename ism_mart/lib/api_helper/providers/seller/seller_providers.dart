import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
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

  Future<ProductResponse> addProduct(
      {String? token, formData, imagesList}) async {
    var response =
        await _sellersApiRepo.postProduct(token: token, formData: formData);
    return ProductResponse.fromResponse(response);
  }

  Future<ProductResponse> addProductWithHttp(
      {String? token, ProductModel? model, categoryFieldList, images}) async {
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

    for (File image in images) {
      request.files.add(await http.MultipartFile.fromPath(
        'images',
        image.path,
        contentType: MediaType.parse('image/jpeg'),
      ));
    }
//TDO: Response handling remaining
    final response = await request.send();

    if (response.statusCode == 200) {
      final responseData = await response.stream.bytesToString();
      final data = json.decode(responseData);
      print(data);
      return ProductResponse.fromResponse(data);
    } else {
      //: Still needs to test this one properly
      http.StreamedResponse res = handleStreamResponse(response);
      return ProductResponse.fromResponse(
          json.decode(await res.stream.bytesToString()));
    }
  }

  Future<SellerProductModel> fetchMyProducts(
      {String? token, limit, page}) async {
    var products = await _sellersApiRepo.getMyProducts(
        token: token, limit: limit, page: page);
    return SellerProductModel.fromJson(products);
  }

  Future<ProductResponse> getProductById(int id) async {
    var response = await _sellersApiRepo.getProductDetailsById(id: id);
    return ProductResponse.fromResponse(response);
  }

  Future<ProductResponse> deleteProductById({id, token}) async {
    var response = await _sellersApiRepo.deleteProduct(id: id, token: token);
    return ProductResponse.fromResponse(response);
  }

  Future<ProductResponse> updateProduct(
      {String? token, ProductModel? model}) async {
    /* var response =
        await _sellersApiRepo.updateProduct(token: token, productModel: model);
   print("Update Prod provider Response: $response");
    return ProductResponse.fromResponse(response);*/

    /*final data = {
      "id": "${model!.id}",
      "name": "${model.name}",
      "price": "${model.price}",
      "stock": "${model.stock}",
      "discount": "${model.discount ?? 0}",
      "description": "${model.description}",
    };
    final body = data.keys.map((key) {
      final value = data[key];
      return '$key=${Uri.encodeComponent(value.toString())}';
    }).join('&');
    final response = await http.patch(
      Uri.parse(url),
      headers: {
        'Content-Type': 'multipart/form-data',
        'Authorization': '$token'
      },
      body: body,
    );*/

    final url = "${ApiConstant.baseUrl}vendor/products/update";
    //  final request = http.MultipartRequest('PATCH', Uri.parse(url));
    //request.headers['Accept'] = 'multipart/form-data';
    // request.headers['content-type'] = 'multipart/form-data';
    // request.headers['authorization'] = '$token';

    // request.fields['id'] = model!.id!.toString();
    // request.fields['name'] = model.name!;
    // // request.fields['thumbnail'] = model.thumbnail!;
    // request.fields['price'] = "${model.price}";

    // request.fields['discount'] = "${model.discount}";
    // request.fields['description'] = "${model.description}";

    // requestInterceptorMultipart(request);

    // final response = await request.send();

    var headers = {'authorization': '$token', 'Cookie': 'XSRF-token=$token'};
    var request = http.MultipartRequest('PATCH', Uri.parse(url));
    request.fields.addAll({
      'name': 'Apple Machbook Pro M2',
      'id': '329',
      'discount': '15',
      'price': '300'
    });
    // request.files.add(await http.MultipartFile.fromPath('thumbnail',
    //     '/C:/Users/moizu/Pictures/Screenshots/Screenshot (2).png'));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final responseData = await response.stream.bytesToString();
      final data = json.decode(responseData);
      print(data);
      return ProductResponse.fromResponse(data);
    } else {
      http.StreamedResponse res = handleStreamResponse(response);
      return ProductResponse.fromResponse(
          json.decode(await res.stream.bytesToString()));
    }
  }
}
