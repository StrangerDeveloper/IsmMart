import 'package:http_parser/http_parser.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ism_mart/helper/api_base_helper.dart';
import 'package:ism_mart/api_helper/global_variables.dart';
import 'package:ism_mart/screens/my_products/my_products_viewmodel.dart';
import '../../models/category/category_model.dart';
import '../../models/category/product_variants_model.dart';
import '../../models/category/sub_category_model.dart';
import '../../models/product/product_model.dart';
import 'package:http/http.dart' as http;
import 'package:ism_mart/utils/languages/translations_key.dart' as langKey;
import '../../utils/constants.dart';

class AddProductViewModel extends GetxController {
  TextEditingController prodNameController = TextEditingController();
  TextEditingController prodStockController = TextEditingController();
  TextEditingController prodBrandController = TextEditingController();
  TextEditingController prodDiscountController = TextEditingController();
  TextEditingController prodDescriptionController = TextEditingController();
  TextEditingController prodSKUController = TextEditingController();
  TextEditingController prodPriceController = TextEditingController();

  RxInt priceAfterCommission = 1.obs;
  RxString chooseCategory = "Select Category".obs;
  RxString chooseSubCategory = "Select sub categories".obs;
  List<File> productImages = <File>[].obs;
  Rx<SubCategory> selectedSubCategory = SubCategory().obs;
  RxInt selectedSubCategoryID = 1.obs;
  List<SubCategory> subCategoriesList = <SubCategory>[].obs;
  Rx<CategoryModel> selectedCategory = CategoryModel().obs;
  RxInt selectedCategoryID = 0.obs;
  List<CategoryModel> categoriesList = <CategoryModel>[].obs;
  RxMap<String, dynamic> dynamicFieldsValuesList = Map<String, dynamic>().obs;
  List<ProductVariantsModel> productVariantsFieldsList =
      <ProductVariantsModel>[].obs;
  Map<String, String>? categoryFieldList;
  var formKey = GlobalKey<FormState>();

  RxString discountMessage = "".obs;
  RxDouble imagesSizeInMb = 0.0.obs;
  RxBool uploadImagesError = false.obs;
  double fieldsPaddingSpace = 12.0;

  @override
  void onReady() {
    fetchCategories();
    super.onReady();
  }

  void onPriceFieldChange(String value) {
    if (value.isNotEmpty) {
      int amount = int.parse(value);
      int totalAfter = amount + (amount * 0.05).round();
      priceAfterCommission(totalAfter);
    } else {
      priceAfterCommission(0);
    }
  }

  void totalTax() {
    int price = int.parse(prodPriceController.text.toString());
    var a = (5 / 100) * price;
    priceAfterCommission.value = priceAfterCommission.value + a.toInt();
  }

  void fetchCategories() async {
    categoriesList.clear();
    categoriesList.insert(0, CategoryModel(name: chooseCategory.value, id: 0));
    await ApiBaseHelper().getMethod(url: 'category/all').then((parsedJson) {
      if (parsedJson['success'] == true) {
        var parsedJsonData = parsedJson['data'] as List;
        categoriesList
            .addAll(parsedJsonData.map((e) => CategoryModel.fromJson(e)));
      }
    }).catchError((e) {
      print(e);
    });
  }

  fetchSubCategories(int categoryID) async {
    await ApiBaseHelper()
        .getMethod(url: 'subcategory/$categoryID')
        .then((parsedJson) {
      if (parsedJson['success'] == true) {
        var parsesJsonData = parsedJson['data'] as List;
        selectedSubCategory(SubCategory(name: chooseSubCategory.value, id: 0));
        subCategoriesList.insert(
            0, SubCategory(name: chooseSubCategory.value, id: 0));
        subCategoriesList
            .addAll(parsesJsonData.map((e) => SubCategory.fromJson(e)));
      }
    }).catchError((e) {
      print(e);
    });
  }

  void setSelectedCategory({CategoryModel? category}) async {
    selectedCategory.value = category!;
    if (!category.name!.contains(chooseCategory)) {
      dynamicFieldsValuesList.clear();
      selectedCategoryID(category.id!);
      subCategoriesList.clear();
      await fetchSubCategories(category.id!);
      //  await populateSubCategoriesList();
    }
  }

  void setSelectedSubCategory({SubCategory? subCategory}) {
    selectedSubCategory.value = subCategory!;
    if (!subCategory.name!.contains(chooseSubCategory)) {
      selectedSubCategoryID(subCategory.id!.isNaN ? 1 : subCategory.id!);
      getVariantsFields();
    }
  }

  void setDiscount(int? discount) {
    if (discount! > 0 && discount < 10) {
      discountMessage(langKey.discountMinValue.tr);
    } else if (discount > 90) {
      discountMessage(langKey.discountMaxValue.tr);
    } else {
      discountMessage("");
    }
  }

  void getVariantsFields() async {
    ApiBaseHelper()
        .getMethod(
            url:
                'categoryFields?categoryId=$selectedCategoryID&subcategoryId=$selectedSubCategoryID')
        .then((parsedJson) {
      if (parsedJson['success'] == true) {
        var parsedJsonData = parsedJson['data'] as List;
        productVariantsFieldsList.clear();
        productVariantsFieldsList.addAll(parsedJsonData
            .map((e) => ProductVariantsModel.fromJson(e))
            .toList());
      }
    }).catchError((e) {
      print(e);
    });
  }

  void onDynamicFieldsValueChanged(String? value, ProductVariantsModel? model) {
    if (dynamicFieldsValuesList.containsValue(value))
      dynamicFieldsValuesList.removeWhere((key, v) => v == value);
    dynamicFieldsValuesList.addIf(
        !dynamicFieldsValuesList.containsValue(value), "${model!.id}", value);
  }

  void addProdBtnPress() {
    if (formKey.currentState!.validate()) {
      if (subCategoriesList.isNotEmpty) {
        if (discountMessage.isEmpty) {
          if (!uploadImagesError.value) {
            addProduct();
          } else {
            uploadImagesError.value = true;
          }
        } else {
          AppConstant.displaySnackBar(
            langKey.errorTitle,
            langKey.yourDiscountShould.tr,
          );
        }
      } else {
        AppConstant.displaySnackBar(
            langKey.errorTitle, langKey.plzSelectSubCategory.tr);
      }
    }
  }

  void addProduct() async {
    GlobalVariable.showLoader.value = true;
    num discount = prodDiscountController.text.isEmpty
        ? 0
        : num.parse(prodDiscountController.text);
    ProductModel newProduct = ProductModel(
        name: prodNameController.text.trim(),
        price: priceAfterCommission.value,
        stock: int.parse(prodStockController.text),
        categoryId: selectedCategoryID.value,
        subCategoryId: selectedSubCategoryID.value,
        description: prodDescriptionController.text,
        discount: discount);

    Map<String, String> body = {
      'name': newProduct.name.toString(),
      'price': newProduct.price.toString(),
      'stock': newProduct.stock.toString(),
      'categoryId': newProduct.categoryId.toString(),
      'subCategoryId': newProduct.subCategoryId.toString(),
      if (newProduct.discount != null &&
          newProduct.discount! >= 10 &&
          newProduct.discount! <= 90)
        'discount': newProduct.discount.toString(),
      'description': newProduct.description.toString(),
    };

    if (dynamicFieldsValuesList.isNotEmpty) {
      for (int i = 0; i < dynamicFieldsValuesList.entries.length; i++) {
        body.addAll({
          'features[$i][id]': "${dynamicFieldsValuesList.entries.elementAt(i).key}",
          'features[$i][value]':
              "${dynamicFieldsValuesList.entries.elementAt(i).value}"
        });
      }
    } else {
      body.addAll({'features': '[]'});
    }

    print(body);

    List<http.MultipartFile> filesList = [];
    for (File image in productImages) {
      filesList.add(await http.MultipartFile.fromPath(
        'images',
        image.path,
        contentType: MediaType.parse('image/jpeg'),
      ));
    }

    await ApiBaseHelper()
        .postMethodForImage(
      url: 'vendor/products/add',
      files: filesList,
      fields: body,
      withAuthorization: true,
    )
        .then((value) async {
      GlobalVariable.showLoader.value = false;
      if (value['success'] == true) {
        MyProductsViewModel myProductsViewModel = Get.find();
        myProductsViewModel.loadInitialProducts();
        // await sellersController.fetchMyProducts();
        Get.back();
        AppConstant.displaySnackBar(langKey.success.tr, value['message']);
      } else {
        debugPrint('Error: ${value.toString()}');
        AppConstant.displaySnackBar(
          langKey.errorTitle.tr,
          "${value['message'] != null ? value['message'] : langKey.someThingWentWrong.tr}",
        );
      }
    }).catchError((e) {
      debugPrint('Error: ${e.toString()}');
      AppConstant.displaySnackBar(langKey.errorTitle, "${e.message}");
    });
  }
}
