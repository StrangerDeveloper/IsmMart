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

  Future<ApiResponse> addProduct({String? token, formData, imagesList}) async {
    var response =
        await _sellersApiRepo.postProduct(token: token, formData: formData);
    return ApiResponse.fromJson(response);
  }

  Future<ApiResponse> addProductWithHttp(
      {String? token,
      ProductModel? model,
      Map<String, dynamic>? categoryFieldList,
      images}) async {
    final url = "${ApiConstant.baseUrl}vendor/products/add";
    final request = http.MultipartRequest('POST', Uri.parse(url));
    request.headers['Authorization'] = '$token';
    //request.headers['Content-Type'] = 'application/x-www-form-urlencoded';
    request.headers['Content-Type'] = 'multipart/form-data';

    request.fields['name'] = model!.name!;
    request.fields['price'] = "${model.price}";
    request.fields['stock'] = "${model.stock}";
    request.fields['categoryId'] = "${model.categoryId}";
    request.fields['subCategoryId'] = "${model.subCategoryId}";
    if (model.discount != null &&
        model.discount! >= 10 &&
        model.discount! <= 90) request.fields['discount'] = "${model.discount}";
    request.fields['description'] = "${model.description}";

    if (categoryFieldList!.isNotEmpty) {
      for (var i = 0; i < categoryFieldList.entries.length; i++) {
        request.fields['features[$i][id]'] =
            "${categoryFieldList.entries.elementAt(i).key}";
        request.fields['features[$i][value]'] =
            "${categoryFieldList.entries.elementAt(i).value}";
      }
    } else {
      request.fields['features'] = "[]";
      //request.fields['features'] = "${categoryFieldList.entries.toList()}";
      //request.fields['features[0][id]'] = "";
      //request.fields['features[0][value]'] = "[]";
      //request.fields['features[$i][value]'] = "[]";
    }

    for (File image in images) {
      request.files.add(await http.MultipartFile.fromPath(
        'images',
        image.path,
        contentType: MediaType.parse('image/jpeg'),
      ));
    }
//TDO: Response handling remaining

    http.StreamedResponse response =
        await handleStreamResponse(await request.send());
    return ApiResponse.fromJson(
        json.decode(await response.stream.bytesToString()));
  }

  Future<SellerProductModel> fetchMyProducts(
      {String? token, limit, page}) async {
    var products = await _sellersApiRepo.getMyProducts(
        token: token, limit: limit, page: page);
    return SellerProductModel.fromJson(products);
  }

  Future<ApiResponse> getProductById(int id) async {
    var response = await _sellersApiRepo.getProductDetailsById(id: id);
    return ApiResponse.fromJson(response);
  }

  Future<ApiResponse> deleteProductById({id, token}) async {
    var response = await _sellersApiRepo.deleteProduct(id: id, token: token);
    return ApiResponse.fromJson(response);
  }

  Future<ApiResponse> updateProduct(
      {String? token,
      ProductModel? model,
      List<int>? imagesToDelete,
      List<File>? imagesToUpdate,
      String thumbnailImage = ''}) async {
    final url = "${ApiConstant.baseUrl}vendor/products/update";
    var headers = {'authorization': '$token', 'Cookie': 'XSRF-token=$token'};
    final request = http.MultipartRequest('PATCH', Uri.parse(url));

    // print(imagesToDelete);
    print(">>Delete Images: $imagesToDelete");
    request.headers.addAll(headers);

    request.fields.addAll({
      'name': '${model!.name}',
      'id': '${model.id}',
      'price': '${model.price}',
      'stock': '${model.stock}',
      'description': '${model.description}',
      if (model.discount != null &&
              model.discount! >= 10 &&
              model.discount! <= 90 ||
          model.discount == 0)
        'discount': '${model.discount}',
      // 'deleteImages': imagesToDelete == [] ? "[]" : "$imagesToDelete",
      if (imagesToDelete != [])
        for (int i = 0; i < imagesToDelete!.length; i++)
          'deleteImages[$i]': "${imagesToDelete[i]}"
    });

    if (thumbnailImage == '') {
      null;
    } else {
      request.files.add(await http.MultipartFile.fromPath(
        'thumbnail',
        thumbnailImage.toString(),
        contentType: MediaType.parse('image/jpeg'),
      ));
    }

    // if(imagesToDelete!.isNotEmpty)
    //   request.fields['deleteImages'] = "$imagesToDelete";

    if (imagesToUpdate != []) {
      for (File image in imagesToUpdate!) {
        request.files.add(await http.MultipartFile.fromPath(
          'addImages',
          image.path,
          contentType: MediaType.parse('image/jpeg'),
        ));
      }
    }
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      final responseData = await response.stream.bytesToString();
      final data = json.decode(responseData);
      // print(data);
      return ApiResponse.fromJson(data);
    } else {
      http.StreamedResponse res = await handleStreamResponse(response);
      final data = json.decode(await res.stream.bytesToString());
      print(">>>UpdateREsponse: $data");
      return ApiResponse.fromJson(data);
    }
  }
}
