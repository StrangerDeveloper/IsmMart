import 'package:ism_mart/exports/export_api_helper.dart';
import 'package:ism_mart/exports/exports_model.dart';

class SellersApiProvider {
  final SellersApiRepo _sellersApiRepo;

  SellersApiProvider(this._sellersApiRepo);

  Future<List<ProductVariantsModel>> getProductVariantsFieldsByCategories(
      {catId, subCatId}) async {
    var fieldsResponse = await _sellersApiRepo.fetchCategoriesFields(categoryId: catId, subCategoryId: subCatId);
    return fieldsResponse.map((field) => ProductVariantsModel.fromJson(field)).toList();
  }
}
