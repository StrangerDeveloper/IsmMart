import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ism_mart/exports/export_api_helper.dart';
import 'package:ism_mart/exports/exports_model.dart';

class CategoryController extends GetxController with StateMixin {
  final ApiProvider _apiProvider;

  var categories = <CategoryModel>[].obs;

  var isCategoriesLoading = false.obs;

  var isCategorySelected = false.obs;
  var subCategories = <SubCategory>[].obs;
  var selectedCategory = "".obs;

  CategoryController(this._apiProvider);

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
      //change(null, status: RxStatus.error(error));
      change(null, status: RxStatus.empty());
    });
  }

  fetchSubCategories(CategoryModel? categoryModel) async {
    if (categories.isNotEmpty) {
      isCategoriesLoading(true);
      subCategories.clear();
      await _apiProvider
          .fetchSubCategories(categoryID: categoryModel!.id!)
          .then((value) {
        subCategories.addAll(value);
        isCategoriesLoading(false);
      }).catchError((error) {
        debugPrint(">>>fetchSubCategories $error");
        isCategoriesLoading(false);
      });
    }
  }

  getSubcategory(CategoryModel? categoryModel) async {
    selectedCategory(categoryModel!.name);
    makeSelectedCategory(categoryModel);
    fetchSubCategories(categoryModel);
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
    }
  }

  @override
  void onClose() {
    super.onClose();
    _clearLists();
  }

  @override
  void onReady() {
    super.onReady();
    fetchCategories();
  }

  _clearLists() {
    categories.clear();
  }
}
