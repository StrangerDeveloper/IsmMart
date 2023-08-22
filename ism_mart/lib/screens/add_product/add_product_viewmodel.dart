import 'package:http_parser/http_parser.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ism_mart/helper/api_base_helper.dart';
import 'package:ism_mart/helper/global_variables.dart';
import 'package:ism_mart/screens/my_products/my_products_viewmodel.dart';
import '../categories/model/category_model.dart';
import '../categories/model/product_variants_model.dart';
import '../categories/model/sub_category_model.dart';
import '../../models/product/product_model.dart';
import 'package:http/http.dart' as http;
import 'package:ism_mart/helper/languages/translations_key.dart' as langKey;
import '../../helper/constants.dart';

class AddProductViewModel extends GetxController {
  TextEditingController prodNameController = TextEditingController();
  TextEditingController prodStockController = TextEditingController();
  TextEditingController prodBrandController = TextEditingController();
  TextEditingController prodDiscountController = TextEditingController();
  TextEditingController prodDescriptionController = TextEditingController();
  TextEditingController prodSKUController = TextEditingController();
  TextEditingController prodPriceController = TextEditingController();
  TextEditingController prodWeightController = TextEditingController();
  TextEditingController prodLengthController = TextEditingController();
  TextEditingController prodWidthController = TextEditingController();
  TextEditingController prodHeightController = TextEditingController();

  TextEditingController prodWeightController = TextEditingController();
  TextEditingController prodLengthController = TextEditingController();
  TextEditingController prodWidthController = TextEditingController();
  TextEditingController prodHeightController = TextEditingController();

  RxInt priceAfterCommission = 1.obs;
  RxInt selectedCategoryID = 0.obs;
  RxInt selectedSubCategoryID = 1.obs;

  RxString chooseCategory = "Select Category".obs;
  RxString chooseSubCategory = "Select sub categories".obs;

  Rx<SubCategory> selectedSubCategory = SubCategory().obs;
  Rx<CategoryModel> selectedCategory = CategoryModel().obs;

  List<SubCategory> subCategoriesList = <SubCategory>[].obs;
  List<File> productImages = <File>[].obs;
  List<CategoryModel> categoriesList = <CategoryModel>[].obs;
  RxList<ProductVariantsModel> productVariantsFieldsList =
      <ProductVariantsModel>[].obs;

  RxMap<String, dynamic> dynamicFieldsValuesList = Map<String, dynamic>().obs;

  Map<String, String>? categoryFieldList;

  var formKey = GlobalKey<FormState>();
  var formKeyCategoryField = GlobalKey<FormState>();

  RxString discountMessage = "".obs;
  RxDouble imagesSizeInMb = 0.0.obs;
  RxBool uploadImagesError = false.obs;
  double fieldsPaddingSpace = 12.0;
  RxBool isStockContainsInVariants = false.obs;

  @override
  void onReady() {
    fetchCategories();
    super.onReady();
  }

  void onPriceFieldChange(String value) {
    if (value.isNotEmpty) {
      int amount = int.parse(value);
      priceAfterCommission(amount); // Updating priceAfterCommission directly
    } else {
      priceAfterCommission(0);
    }
  }

  // void onPriceFieldChange(String value) {
  //   if (value.isNotEmpty) {
  //     int amount = int.parse(value);
  //     int totalAfter = amount + (amount * 0.05).round();
  //     priceAfterCommission(totalAfter);
  //   } else {
  //     priceAfterCommission(0);
  //   }
  // }

  // void totalTax() {
  //   int price = int.parse(prodPriceController.text.toString());
  //   var a = (5 / 100) * price;
  //   priceAfterCommission.value = priceAfterCommission.value + a.toInt();
  // }

  void fetchCategories() async {
    categoriesList.clear();
    categoriesList.insert(0, CategoryModel(name: chooseCategory.value, id: 0));
    await ApiBaseHelper().getMethod(url: 'category/all').then((parsedJson) {
      if (parsedJson['success'] == true) {
        GlobalVariable.internetErr(false);
        var parsedJsonData = parsedJson['data'] as List;
        categoriesList
            .addAll(parsedJsonData.map((e) => CategoryModel.fromJson(e)));
      }
    }).catchError((e) {
   //   GlobalVariable.internetErr(true);
      print(e);
    });
  }

  fetchSubCategories(int categoryID) async {
    await ApiBaseHelper()
        .getMethod(url: 'subcategory/$categoryID')
        .then((parsedJson) {
      if (parsedJson['success'] == true) {
        GlobalVariable.internetErr(false);
        var parsesJsonData = parsedJson['data'] as List;
        selectedSubCategory(SubCategory(name: chooseSubCategory.value, id: 0));
        subCategoriesList.insert(
            0, SubCategory(name: chooseSubCategory.value, id: 0));
        subCategoriesList
            .addAll(parsesJsonData.map((e) => SubCategory.fromJson(e)));
      }
    }).catchError((e) {
     // GlobalVariable.internetErr(true);

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
    GlobalVariable.showLoader.value = true;
    ApiBaseHelper()
        .getMethod(
            url:
                'categoryFields?categoryId=$selectedCategoryID&subcategoryId=$selectedSubCategoryID')
        .then((parsedJson) {
      if (parsedJson['success'] == true) {
        GlobalVariable.internetErr(false);
        var parsedJsonData = parsedJson['data'] as List;
        productVariantsFieldsList.clear();
        productVariantsFieldsList.addAll(parsedJsonData
            .map((e) => ProductVariantsModel.fromJson(e))
            .toList());
        checkStockFieldInVariantList();
      }
    }).catchError((e) {
    //  GlobalVariable.internetErr(true);
      print(e);
    });
  }

  checkStockFieldInVariantList() {
    isStockContainsInVariants.value = false;
    if (productVariantsFieldsList.isNotEmpty) {
      productVariantsFieldsList.forEach((element) {
        if (element.categoryFieldOptions!.isNotEmpty) {
          element.categoryFieldOptions!.forEach((fieldOptionObj) {
            if (fieldOptionObj.name!.toLowerCase().contains("stock")) {
              isStockContainsInVariants.value = true;
            }
          });
        }
      });
    }
    GlobalVariable.showLoader.value = false;
  }

  void onDynamicFieldsValueChanged(String? value, ProductVariantsModel? model) {
    //if (dynamicFieldsValuesList.containsValue(value))
    //dynamicFieldsValuesList.removeWhere((key, v) => v == value);
    dynamicFieldsValuesList.addIf(
        !dynamicFieldsValuesList.containsValue(value), "${model!.id}", value);

    print("dynamicValue: ${dynamicFieldsValuesList.toJson()}");
  }

  void addProdBtnPress() {
    GlobalVariable.internetErr(false);
    if (formKeyCategoryField.currentState!.validate()) {
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
        weight: double.parse(prodWeightController.text),
        length: prodLengthController.text.isNotEmpty ? double.parse(prodLengthController.text) : null,
        width: prodWidthController.text.isNotEmpty ? double.parse(prodWidthController.text) : null,
        height: prodHeightController.text.isNotEmpty ? double.parse(prodHeightController.text) : null,
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
      'weight': newProduct.weight.toString(),
      if(newProduct.width != null)
        'width': newProduct.width.toString(),
      if(newProduct.length != null)
        'length': newProduct.length.toString(),
      if(newProduct.height != null)
        'height': newProduct.height.toString(),
    };

    if (dynamicFieldsValuesList.isNotEmpty) {
      for (int i = 0; i < dynamicFieldsValuesList.entries.length; i++) {
        body.addAll({
          'features[$i][id]':
              "${dynamicFieldsValuesList.entries.elementAt(i).key}",
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
        GlobalVariable.internetErr(false);
        MyProductsViewModel myProductsViewModel = Get.find();
        myProductsViewModel.loadInitialProducts();

        Get.back();
        AppConstant.displaySnackBar(langKey.success.tr, value['message']);
      } else {
        debugPrint('Error: ${value.toString()}');
        GlobalVariable.internetErr(false);

        AppConstant.displaySnackBar(
          langKey.errorTitle.tr,
          "${value['message'] != null ? value['message'] : langKey.someThingWentWrong.tr}",
        );
      }
    }).catchError((e) {
    //  GlobalVariable.internetErr(true);
      debugPrint('Error: ${e.toString()}');
      //   AppConstant.displaySnackBar(langKey.errorTitle, "${e.message}");
    });
  }
}
