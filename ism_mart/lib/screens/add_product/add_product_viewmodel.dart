// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:ism_mart/api_helper/export_api_helper.dart';
// import 'package:ism_mart/controllers/controllers.dart';
// import '../../models/category/category_model.dart';
// import '../../models/category/product_variants_model.dart';
// import '../../models/category/sub_category_model.dart';
//
// class AddProductViewModel extends GetxController {
//
//   // final apiProvider = ApiProvider(Get.find());
//
//   var prodNameController = TextEditingController();
//
//   var prodStockController = TextEditingController();
//   var prodBrandController = TextEditingController();
//   var prodDiscountController = TextEditingController();
//   var prodDescriptionController = TextEditingController();
//   var prodSKUController = TextEditingController();
//
//   var prodPriceController = TextEditingController();
//   var priceAfterCommission = 0.obs;
//   void totalTax() {
//     var price = int.parse(prodPriceController.text.toString());
//     var a = (5 / 100) * price;
//
//     priceAfterCommission.value = priceAfterCommission.value + a.toInt();
//     print(" percentage after tax $a   total ${priceAfterCommission.value}");
//   }
//
//   static const chooseCategory = "Select Category";
//
//   //var selectedCategory = chooseCategory.obs;
//
//   var selectedCategory = CategoryModel().obs;
//   var selectedCategoryID = 1.obs;
//   var categoriesList = <CategoryModel>[].obs;
//
//   // var productImages = <ProductImages>[].obs;
//
//   fetchCategories() async {
//     categoriesList.clear();
//     categoriesList.insert(0, CategoryModel(name: chooseCategory, id: 0));
//     if (categoryControllerFindOrInit.categories.isEmpty) {
//       await categoryControllerFindOrInit.fetchCategories();
//       fetchCategories();
//     } else {
//       categoriesList.addAll(categoryControllerFindOrInit.categories);
//       categoriesList.refresh();
//     }
//   }
//
//   static const chooseSubCategory = "Select sub categories";
//
//   //var selectedSubCategory = chooseSubCategory.obs;
//   var selectedSubCategory = SubCategory().obs;
//   var selectedSubCategoryID = 1.obs;
//   var subCategoriesList = <SubCategory>[].obs;
//
//   populateSubCategoriesList() {
//     // isLoading(true);
//     subCategoriesList.clear();
//     selectedSubCategory(SubCategory(name: chooseSubCategory, id: 0));
//     subCategoriesList.insert(0, SubCategory(name: chooseSubCategory, id: 0));
//
//     if (categoryControllerFindOrInit.subCategories.isNotEmpty) {
//       // isLoading(false);
//       subCategoriesList.addAll(categoryControllerFindOrInit.subCategories);
//     } else {
//       setSelectedCategory(category: selectedCategory.value);
//     }
//   }
//
//   void setSelectedCategory({CategoryModel? category}) async {
//     selectedCategory.value = category!;
//     if (!category.name!.contains(chooseCategory)) {
//       dynamicFieldsValuesList.clear();
//       selectedCategoryID(category.id!);
//       subCategoriesList.clear();
//       await categoryControllerFindOrInit.fetchSubCategories(category);
//       await populateSubCategoriesList();
//     }
//   }
//
//   void setSelectedSubCategory({SubCategory? subCategory}) {
//     selectedSubCategory.value = subCategory!;
//     if (!subCategory.name!.contains(chooseSubCategory)) {
//       selectedSubCategoryID(subCategory.id!.isNaN ? 1 : subCategory.id!);
//       getVariantsFields();
//     }
//   }
//
//   var productVariantsFieldsList = <ProductVariantsModel>[].obs;
//
//   getVariantsFields() async {
//     // isLoading(true);
//     // await apiProvider
//     //     .getProductVariantsFieldsByCategories(
//     //     catId: selectedCategoryID.value,
//     //     subCatId: selectedSubCategoryID.value)
//     //     .then((fieldsList) {
//     //   // isLoading(false);
//     //   productVariantsFieldsList.clear();
//     //   productVariantsFieldsList.addAll(fieldsList);
//     // });
//   }
//
//   var dynamicFieldsValuesList = Map<String, dynamic>().obs;
//
//   onDynamicFieldsValueChanged(String? value, ProductVariantsModel? model) {
//     if (dynamicFieldsValuesList.containsValue(value))
//       dynamicFieldsValuesList.removeWhere((key, v) => v == value);
//     dynamicFieldsValuesList.addIf(
//         !dynamicFieldsValuesList.containsValue(value), "${model!.id}", value);
//   }
//
//   addProduct() async {
//     isLoading(true);
//     num discount = prodDiscountController.text.isEmpty
//         ? 0
//         : num.parse(prodDiscountController.text);
//     ProductModel newProduct = ProductModel(
//         name: prodNameController.text.trim(),
//         price: priceAfterCommission.value,
//         stock: int.parse(prodStockController.text),
//         categoryId: selectedCategoryID.value,
//         subCategoryId: selectedSubCategoryID.value,
//         description: prodDescriptionController.text,
//         discount: discount);
//
//     await apiProvider
//         .addProductWithHttp(
//         token: authController.userToken,
//         model: newProduct,
//         categoryFieldList: dynamicFieldsValuesList,
//         images: pickedImagesList)
//         .then((ApiResponse? response) async {
//       isLoading(false);
//       if (response != null) {
//         if (response.success!) {
//           //myProductsList.clear();
//           await fetchMyProducts();
//
//           Get.back();
//           clearControllers();
//           AppConstant.displaySnackBar(
//               langKey.success.tr, "${response.message}");
//         } else {
//           debugPrint('Error: ${response.toString()}');
//           AppConstant.displaySnackBar(
//             langKey.errorTitle.tr,
//             "${response.message != null ? response.message : someThingWentWrong.tr}",
//           );
//         }
//       }
//     }).catchError((e) {
//       debugPrint('Error: ${e.toString()}');
//       isLoading(false);
//       AppConstant.displaySnackBar(langKey.errorTitle, "${e.message}");
//     });
//   }
//
// }