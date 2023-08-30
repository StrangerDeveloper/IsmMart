import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ism_mart/helper/api_base_helper.dart';
import 'package:ism_mart/helper/global_variables.dart';
import 'package:ism_mart/helper/languages/translations_key.dart' as langKey;
import 'package:ism_mart/models/product/product_model.dart';
import 'package:ism_mart/screens/cart/cart_viewmodel.dart';

import '../../api_helper/local_storage/local_storage_helper.dart';
import '../../helper/constants.dart';
import '../../helper/routes.dart';
import '../../models/order/cart/cart_model.dart';

class ProductDetailViewModel extends GetxController {
  PageController pageController = PageController(initialPage: 0);
  RxInt productID = 0.obs;
  bool isBuyer = true;
  Rx<ProductModel> productModel = ProductModel().obs;
  List<String> imageList = <String>[].obs;
  RxInt indicatorIndex = 0.obs;

  // RxInt selectedSize = 0.obs;
  // List<String> sizeList = <String>['S', 'M', 'L', 'XL', 'S', 'M', 'L', 'XL'].obs;
  // RxInt selectedColor = 0.obs;
  // List<String> colorList = <String>['FFFFFF', '000000', 'CADCA7', 'F79F1F'].obs;
  // RxInt productQuantity = 1.obs;
  // RxBool productAlreadyAdded = false.obs;
  List<int> selectedFeatureIDsList = <int>[].obs;
  List<String> selectedFeatureNamesList = <String>[].obs;

  //RxBool viewCheck = true.obs;
  // List<QuestionModel> productQuestions = <QuestionModel>[].obs;
  //RxInt count = 1.obs;
  // Rx<ReviewModelResponse> reviewResponse = ReviewModelResponse().obs;

  @override
  void onInit() {
    productID.value = Get.arguments['productID'];
    isBuyer = Get.arguments['isBuyer'];
    super.onInit();
  }

  @override
  void onReady() {
    fetchProduct();
    super.onReady();
  }

  @override
  void onClose() {
    productID.value = 0;
    productModel.value = ProductModel();
    //pageIndex.value = 0;
    // imageIndex.value = 0;
    //viewCheck.value = true;
    // productQuestions.clear();
    //quantityController.clear();
    //count.value = 1;
    selectedFeatureIDsList.clear();
    selectedFeatureNamesList.clear();
    // reviewResponse.value = ReviewModelResponse();
    super.onClose();
  }

  // checkCartForThisItem() {
  //   CartViewModel cartViewModel = Get.find();
  //
  //   int index = cartViewModel.cartItemsList.indexWhere((e) => e.productId == productModel.value.id);
  //   if (index != -1) {
  //     productAlreadyAdded.value = true;
  //     productQuantity.value = int.parse(cartViewModel.cartItemsList[index].quantity ?? '1');
  //   }
  // }

  // increment() {
  //   if (int.parse(productModel.value.stock.toString()) >
  //       productQuantity.value) {
  //     productQuantity.value++;
  //   }
  // }

  // decrement() {
  //   if (productQuantity.value > 1) {
  //     productQuantity.value--;
  //   }
  // }

  void viewImageEnlarge(int index) {
    //imageIndex(index);
    Get.toNamed(Routes.singleProductFullImage, arguments: [
      {
        "initialImage": index,
        "productImages": (productModel.value.images?.isNotEmpty ?? false)
            ? productModel.value.images
            : [ProductImages(url: productModel.value.thumbnail)],
      }
    ]);
  }

  // String getRating() {
  //   return reviewResponse.value.rating != null
  //       ? reviewResponse.value.rating!.toStringAsFixed(1)
  //       : "0.0";
  // }

  addUpdateItemToLocalCart() async {
    // productModel.value.totalPrice = productQuantity.value * productModel.value.discountPrice!.toDouble();
    productModel.value.totalPrice =
        productModel.value.discountPrice?.toDouble();
    productModel.value.vendorId = productModel.value.sellerModel?.id;

    CartModel cart = CartModel(
      productId: productModel.value.id,
      productModel: productModel.value,
      itemPrice: productModel.value.totalPrice,
      quantity: '1',
      featuresID: selectedFeatureIDsList,
      featuresName: selectedFeatureNamesList,
      onQuantityClicked: false,
    );

    await LocalStorageHelper.addItemToCart(cartModel: cart).then((value) {
      CartViewModel cartModel = Get.find();
      cartModel.fetchCartItemsFromLocal();
      //productAlreadyAdded.value = true;
    });
  }

  fetchProduct() async {
    GlobalVariable.showLoader.value = true;
    GlobalVariable.internetErr(false);
    await ApiBaseHelper()
        .getMethod(url: 'products/${productID.value}')
        .then((response) async {
      GlobalVariable.showLoader.value = false;
      if (response['success'] == true && response['data'] != null) {
        productModel.value = ProductModel.fromJson(response['data']);

        //Moving thumbnail at zero index...

        if (productModel.value.images?.isEmpty ?? false) {
          imageList.add(productModel.value.thumbnail ?? '');
        } else {
          productModel.value.images?.forEach((e) {
            if (e.url != null) {
              if (e.url == productModel.value.thumbnail) {
                imageList.insert(0, productModel.value.thumbnail!);
              } else {
                imageList.add(e.url!);
              }
            }
          });
        }

        // await getProductQuestions();
      } else {
        Get.back();
        AppConstant.displaySnackBar(
            langKey.errorTitle.tr, langKey.productRejected.tr);
      }

      // if(isBuyer == true){
      //   checkCartForThisItem();
      // }
    }).catchError((error) {
      GlobalVariable.showLoader.value = false;
      GlobalVariable.internetErr(true);
      // AppConstant.displaySnackBar(langKey.errorTitle.tr, langKey.errorMsg.tr);
      //viewCheck.value = false;
    });
  }

// getProductQuestions() async {
//   await ApiBaseHelper()
//       .getMethod(url: 'product/questions/${productModel.value.id}')
//       .then((value) {
//     if (value['success'] == true && value['data'] != null) {
//       productQuestions.clear();
//       var data = value['data'] as List;
//       productQuestions.addAll(data.map((e) => QuestionModel.fromJson(e)));
//     }
//   }).catchError((e) {
//     AppConstant.displaySnackBar(langKey.errorTitle.tr, e.toString());
//   });
// }

// popSingleProductView() {
//   pageIndex(0);
//   Get.back();
// }
}
