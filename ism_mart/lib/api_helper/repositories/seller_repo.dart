import 'package:ism_mart/api_helper/api_service.dart';

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
    return response.body != null ? response.body['data'] : [];
  }
}
