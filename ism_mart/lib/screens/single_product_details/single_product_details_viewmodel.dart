import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ism_mart/helper/api_base_helper.dart';
import 'package:ism_mart/models/exports_model.dart';
import 'package:ism_mart/models/questions/questions_model.dart';
import '../../api_helper/local_storage/local_storage_helper.dart';
import '../../models/order/cart/cart_model.dart';
import '../../models/product/product_model.dart';
import '../../utils/constants.dart';
import 'package:ism_mart/utils/languages/translations_key.dart' as langKey;

import '../single_product_full_image/single_product_full_image_view.dart';

class SingleProductDetailsViewModel extends GetxController{

  var selectedFeatureIDsList = <int>[].obs;
  var selectedFeatureNamesList = <String>[].obs;
  final productID = RxInt(0);
  final productModel = ProductModel().obs;
  final pageIndex = RxInt(0);
  final imageIndex = RxInt(0);
  final viewCheck = RxBool(true);
  final productFoundCheck = RxBool(true);
  var pageController = PageController(initialPage: 0);
  final productQuestions = <QuestionModel>[].obs;
  var quantityController = TextEditingController();
  final count = RxInt(1);
  final reviewResponse = ReviewModelResponse().obs;

  @override
  void onInit() {
    productID.value = int.parse(Get.arguments[0]['productID']);
    fetchProduct();
    super.onInit();
  }

  @override
  void onClose() {
    productID.value = 0;
    productModel.value = ProductModel();
    pageIndex.value = 0;
    imageIndex.value = 0;
    viewCheck.value = true;
    productQuestions.clear();
    quantityController.clear();
    count.value = 1;
    selectedFeatureIDsList.clear();
    selectedFeatureNamesList.clear();
    reviewResponse.value = ReviewModelResponse();
    super.onClose();
  }

  void changePage(int index) {
    pageIndex.value = index;
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOutCubicEmphasized,
    );
  }

  increment() {
    if (count.value == int.parse(productModel.value.stock.toString())) {
      return ;
    }
    else {
      count.value++;
      quantityController.text = count.value.toString();
    }
  }

  decrement() {
    if (count.value == 1) {
      return;
    } else {
      count.value--;

      quantityController.text = count.value.toString();
    }
  }

  void moveToProductImageView(int index){
    imageIndex(index);
    Get.to(() => SingleProductFullImageView(
      productImages: productModel.value.images!,
      initialImage: index,
    ));
  }

  getProductQuestions() async {
    await ApiBaseHelper().getMethod(url: 'product/questions/${productModel.value.id}')
        .then((value) {
       if(value['success'] == true && value['data'] != null) {
        productQuestions.clear();
        var data = value['data'] as List;
        productQuestions.addAll(data.map((e) => QuestionModel.fromJson(e)));
       }
    }).catchError((e){
      AppConstant.displaySnackBar(langKey.errorTitle.tr, e.toString());
    });
  }

  String getRating() {
    return reviewResponse.value.rating != null
        ? reviewResponse.value.rating!.toStringAsFixed(1)
        : "0.0";
  }

  addItemLocalCart() async {
    productModel.value.totalPrice = int.parse(
        quantityController.text.isEmpty ? "1" : quantityController.text) *
        productModel.value.discountPrice!.toDouble();
    productModel.value.vendorId = productModel.value.sellerModel!.id;
    CartModel cart = CartModel(
      productId: productModel.value.id,
      productModel: productModel.value,
      itemPrice: productModel.value.totalPrice,
      quantity: quantityController.text,
      featuresID: selectedFeatureIDsList,
      featuresName: selectedFeatureNamesList,
      onQuantityClicked: false,
    );

    await LocalStorageHelper.addItemToCart(cartModel: cart).then((value) {
      Get.back();
      count(1);
    });
  }

  fetchProduct() async {
    await ApiBaseHelper().getMethod(url: 'products/${productID.value}').then((response)async {
      if (response['success'] == true && response['data'] != null) {
        productModel.value = ProductModel.fromJson(response['data']);
        await getProductQuestions();
        print('>>product Feature: ${productModel.value.productFeatures?.length}');
      } else if(response['success'] == false){
        productFoundCheck.value = false;
      }else{
        productFoundCheck.value = false;
        AppConstant.displaySnackBar(langKey.errorTitle.tr, langKey.errorMsg.tr);
      }
    }).catchError((error) {
      AppConstant.displaySnackBar(langKey.errorTitle.tr, langKey.errorMsg.tr);
      viewCheck.value = false;
    });
  }

  popSingleProductView() {
    pageIndex(0);
    Get.back();
  }
}