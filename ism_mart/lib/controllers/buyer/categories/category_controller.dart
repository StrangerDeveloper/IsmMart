import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ism_mart/api_helper/export_api_helper.dart';
import 'package:ism_mart/models/exports_model.dart';

class CategoryController extends GetxController with StateMixin {
  final ApiProvider _apiProvider;

  CategoryController(this._apiProvider);

  /*@override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }*/

  @override
  void onReady() {
    super.onReady();
    fetchCategories();


  }

  var categories = <CategoryModel>[].obs;
  var isCategoriesLoading = false.obs;
  var isCategorySelected = false.obs;

  fetchCategories() async {
    isCategoriesLoading(true);
    change(null, status: RxStatus.loading());
    await _apiProvider.fetchCategories().then((data) {
      change(data, status: RxStatus.success());
      categories.addAll(data);
      isCategoriesLoading(false);

      getSubcategory(categories.first);

    }).catchError((error) {
      debugPrint("FetchCategoriesError $error");
      isCategoriesLoading(false);
      //fetchCategories();
      change(null, status: RxStatus.error(error));
    });
  }

  var subCategories = <SubCategory>[].obs;
  var selectedCategory = "".obs;
  getSubcategory(CategoryModel? categoryModel) async {
    selectedCategory(categoryModel!.name);
    makeSelectedCategory(categoryModel);
    fetchSubCategories(categoryModel);
  }

  fetchSubCategories(CategoryModel? categoryModel) async{
    if (categories.isNotEmpty) {
      isCategoriesLoading(true);
      subCategories.clear();
      await _apiProvider
          .fetchSubCategories(categoryID: categoryModel!.id!)
          .then((value) {
        subCategories.addAll(value);
        isCategoriesLoading(false);
      }).catchError((error){
        debugPrint(">>>fetchSubCategories $error");
        isCategoriesLoading(false);
      });
    }
  }

  makeSelectedCategory(CategoryModel? categoryModel) {
    var list = <CategoryModel>[];
    if (categories.isNotEmpty) {
      list.clear();
      for (CategoryModel model in categories) {
        if (model.id! == categoryModel!.id!) {
          model.isPressed = true;
        } else {
          model.isPressed = false;
        }
        list.add(model);
      }
      change(list, status: RxStatus.success());
      /*categories.clear();
      categories.addAll(list);
      categories.refresh();*/
    }
  }

  _clearLists() {
    categories.clear();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    _clearLists();
  }
}
