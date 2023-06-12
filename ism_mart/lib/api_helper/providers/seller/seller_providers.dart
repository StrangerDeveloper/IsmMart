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
}
