import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:http_parser/src/media_type.dart';
import 'package:ism_mart/exports/export_api_helper.dart';
import 'package:ism_mart/screens/my_products/my_products_viewmodel.dart';
import '../../helper/api_base_helper.dart';
import '../../helper/global_variables.dart';
import '../../models/product/product_model.dart';
import '../../helper/constants.dart';
import 'package:ism_mart/helper/languages/translations_key.dart' as langKey;
import 'package:http/http.dart' as http;

class UpdateProductViewModel extends GetxController {
  // @override
  // void onInit() {
  //   getProductById(Get.arguments[0]['productId']);
  //   super.onInit();
  // }
  //
  @override
  void onReady() {
    getProductById(Get.arguments[0]['productId']);
    super.onReady();
  }

  @override
  void onClose() {
    thumbnailNotAvailable(false);
    thumbnailImageSizeInMb.value = 0.0;
    imagesToDelete.clear();
    imagesToUpdate.clear();
    prodNameController.dispose();
    prodStockController.dispose();
    prodBrandController.dispose();
    prodDiscountController.dispose();
    prodSKUController.dispose();
    prodPriceController.dispose();
    prodWeightController.dispose();
    prodLengthController.dispose();
    prodWidthController.dispose();
    prodHeightController.dispose();
    priceAfterCommission(0);
    imagesSize(0.0);
    super.onClose();
  }

  ProductModel? productModel;
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

  RxString userToken = ''.obs;
  RxBool thumbnailNotAvailable = false.obs;
  RxDouble thumbnailImageSizeInMb = 0.0.obs;
  List imagesToDelete = [].obs;
  List<File> imagesToUpdate = <File>[].obs;
  RxBool showPriceAfterCommission = false.obs;
  RxInt priceAfterCommission = 0.obs;
  RxString thumbnailUrl = ''.obs;
  Rx<File?> thumbnailSelectedImage = File('').obs;
  RxString discountMessage = "".obs;
  RxBool isLoading = false.obs;
  RxInt imageIndex = 0.obs;
  RxDouble imagesSize = 0.0.obs;
  RxList<ProductImages> productImages = <ProductImages>[].obs;
  var formKey = GlobalKey<FormState>();

  getUserToken() async {
    GlobalVariable.userModel = await LocalStorageHelper.getStoredUser();
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

  void getProductById(id) async {
    GlobalVariable.showLoader.value = true;
    await ApiBaseHelper().getMethod(url: 'products/$id').then((response) {
      if (response['success'] == true && response['data'] != null) {
        productModel = ProductModel.fromJson(response['data']);
        productImages.clear();
        GlobalVariable.showLoader.value = false;
        initializeValues();
      } else {
        GlobalVariable.showLoader.value = false;
        AppConstant.displaySnackBar(langKey.errorTitle.tr, langKey.errorMsg.tr);
      }
    }).catchError((error) {
      GlobalVariable.showLoader.value = false;
      AppConstant.displaySnackBar(langKey.errorTitle.tr, langKey.errorMsg.tr);
    });
  }

  void initializeValues() {
    if (productModel != null) {
      prodNameController.text = productModel!.name!;
      prodPriceController.text = productModel!.price!.toString();
      prodStockController.text = productModel!.stock!.toString();
      prodDiscountController.text =
          productModel!.discount == 0 ? '' : productModel!.discount!.toString();
      prodDescriptionController.text = productModel!.description!;
      priceAfterCommission(productModel!.price!.toInt());
      thumbnailUrl.value = productModel!.thumbnail.toString();
      prodWeightController.text = productModel!.weight == null ? '' : productModel!.weight.toString();
      prodHeightController.text = productModel!.height == null ? '' : productModel!.height.toString();
      prodWidthController.text = productModel!.width == null ? '' : productModel!.width.toString();
      prodLengthController.text = productModel!.length == null ? '' : productModel!.length.toString();

      if (productModel!.images!.isNotEmpty) {
        productImages.addAll(productModel!.images!);
      }
      imagesToDelete.clear();
      imagesToUpdate.clear();
    }
  }

  void totalTax() {
    var price = int.parse(prodPriceController.text.toString());
    var a = (5 / 100) * price;
    priceAfterCommission.value = priceAfterCommission.value + a.toInt();
  }

  void productDiscountOnChange(String value) {
    if (value.isNotEmpty || value != '') {
      int discount = int.parse(value);
      setDiscount(discount);
    } else {
      int discount = 0;
      setDiscount(discount);
    }
  }

  void thumbnailCheck() {
    if (thumbnailUrl.value != '') {
      thumbnailUrl.value = '';
    } else {
      thumbnailSelectedImage.value = File('');
    }
    thumbnailNotAvailable(true);
  }

  void productPriceOnChange(String value) {
    if (value == '') {
      showPriceAfterCommission.value = false;
    } else {
      showPriceAfterCommission.value = true;
      totalTax();
      if (value.isNotEmpty) {
        priceAfterCommission.value = int.parse(value);
        totalTax();
        productModel!.price = priceAfterCommission.value;
      }
    }
  }

  updateButtonPress() {
    if (formKey.currentState!.validate()) {
      if (thumbnailNotAvailable.value) {
        return;
      } else {
        if (discountMessage.isEmpty) {
          updateProduct(model: productModel);
        } else {
          AppConstant.displaySnackBar(
            langKey.errorTitle.tr,
            langKey.yourDiscountShould.tr,
          );
        }
      }
    }
  }

  void updateProduct({ProductModel? model}) async {
    GlobalVariable.showLoader.value = true;
    model!.name = prodNameController.text;
    model.price = int.parse("${priceAfterCommission.value}");
    model.discount =
        prodDiscountController.text == '' || prodDiscountController.text.isEmpty
            ? 0
            : int.parse(prodDiscountController.text);
    model.description = prodDescriptionController.text;
    model.stock = int.parse("${prodStockController.text}");
    model.weight = double.parse(prodWeightController.text);
    model.length = prodLengthController.text.isEmpty ? null : double.parse(prodLengthController.text);
    model.height = prodHeightController.text.isEmpty ? null : double.parse(prodHeightController.text);
    model.width = prodWidthController.text.isEmpty ? null : double.parse(prodWidthController.text);

    Map<String, String> body = {
      'name': '${model.name}',
      'id': '${model.id}',
      'price': '${model.price}',
      'stock': '${model.stock}',
      'description': '${model.description}',
      if (model.discount != null &&
              model.discount! >= 10 &&
              model.discount! <= 90 ||
          model.discount == 0)
        'discount': '${model.discount}',
      if (imagesToDelete != [])
        for (int i = 0; i < imagesToDelete.length; i++)
          'deleteImages[$i]': "${imagesToDelete[i]}",

      if(model.length != null)
        'length': model.length.toString(),
      if(model.width != null)
        'length': model.width.toString(),
      if(model.height != null)
        'length': model.height.toString(),
    };

    List<http.MultipartFile> fileList = [];
    if (thumbnailSelectedImage.value!.path == '') {
      null;
    } else {
      fileList.add(await http.MultipartFile.fromPath(
        'thumbnail',
        thumbnailSelectedImage.value!.path.toString(),
        contentType: MediaType.parse('image/jpeg'),
      ));
    }

    if (imagesToUpdate != []) {
      for (File image in imagesToUpdate) {
        fileList.add(await http.MultipartFile.fromPath(
          'addImages',
          image.path,
          contentType: MediaType.parse('image/jpeg'),
        ));
      }
    }
    ApiBaseHelper()
        .patchMethodForImage(
            url: 'vendor/products/update',
            withAuthorization: true,
            files: fileList,
            fields: body)
        .then((parsedJson) async {
      GlobalVariable.showLoader.value = false;
      if (parsedJson['message'] == "Product updated successfully") {
        GlobalVariable.showLoader.value = false;
        MyProductsViewModel myProductsViewModel = Get.find();
        myProductsViewModel.loadInitialProducts();
        // await sellersController.fetchMyProducts();
        Get.back();
        AppConstant.displaySnackBar(langKey.success.tr, parsedJson['message']);
      } else {
        GlobalVariable.showLoader.value = false;
        AppConstant.displaySnackBar(
            langKey.errorTitle.tr, parsedJson['message']);
      }
    }).catchError((e) {
      GlobalVariable.showLoader.value = false;
      print(e);
    });
  }
}
