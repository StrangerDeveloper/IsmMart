import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ism_mart/exports/export_api_helper.dart';
import 'package:ism_mart/helper/global_variables.dart';
import 'package:ism_mart/exports/export_controllers.dart';
import 'package:ism_mart/exports/exports_model.dart';
import 'package:ism_mart/exports/exports_utils.dart';

import 'package:ism_mart/utils/languages/translations_key.dart' as langKey;

class ProductController extends GetxController with StateMixin {
  final ApiProvider _apiProvider;

  ProductController(this._apiProvider);

  TextEditingController questionController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  var pageController = PageController(initialPage: 0);
  var pageIndex = 0.obs;

  var count = 1.obs;

  var size = "".obs;
  var color = "".obs;

  // minimum Order Qty Limit
  var moq = 0.obs;

  ScrollController scrollController = ScrollController();
  var loadMoreVisibility = false.obs;

  get userModel => authController.userModel!;

  fetchProduct(int id) async {
    change(null, status: RxStatus.loading());

    await _apiProvider.getProductById(id).then((product) {
      change(product, status: RxStatus.success());
      GlobalVariable.showLoader.value = false;
      fetchProductBySubCategory(subCategoryId: product.subCategory!.id);
      //fetchProductReviewsById(productId: id);
      getProductQuestions(productId: id);

      setCountAndMOQ(productModel: product);
    }).catchError((error) {
      change(null, status: RxStatus.error(error));
      print(">>>FetchProduct $error");
    });
  }

  popSingleProductView() {
    pageIndex(0);
    Get.back();
  }

  popProductImageView() {
    imageIndex(0);
    Get.back();
  }

  setCountAndMOQ({ProductModel? productModel}) {
    count.value = 1;
    moq.value = productModel!.stock!;
    quantityController.text = count.value.toString();
  }

  var subCategoryProductList = <ProductModel>[].obs;
  var isLoading = false.obs;

  void fetchProductBySubCategory({int? subCategoryId}) async {
    isLoading(true);
    await _apiProvider
        .getProductsBySubCategory(subCategoryId!)
        .then((products) {
      subCategoryProductList.clear();
      subCategoryProductList.addAll(products);
      isLoading(false);
    }).catchError((error) {
      isLoading(false);
      debugPrint(">>>fetchProductBySubCategory $error");
    });
  }

  var _reviewResponse = ReviewModelResponse().obs;

  ReviewModelResponse? get reviewResponse => _reviewResponse.value;

  fetchProductReviewsById({productId}) async {
    isLoading(true);
    await _apiProvider
        .getProductReviews(productId: productId)
        .then((ReviewModelResponse? response) {
      isLoading(false);
      _reviewResponse(response);
    }).catchError((e) {
      debugPrint(">>>FetchProductReviews:  $e");
      isLoading(false);
    });
  }

  var sellerStoreResponse = SellerModelResponse().obs;
  //var vendorID = 0.obs;
  fetchStoreDetailsByID({storeID}) async {
    GlobalVariable.internetErr(false);
    isLoading(true);
    //change(null, status: RxStat)us.loading());
    await _apiProvider
        .getVendorStoreById(storeID: storeID, token: authController.userToken)
        .then((sellerModelResponse) {
      isLoading(false);
      sellerStoreResponse(sellerModelResponse);
      //change(sellerModelResponse, status: RxStatus.success());
      //vendorID.value = sellerModelResponse.vendorStore!.id!;
      page = 1;
      getVendorProducts(vendorId: sellerModelResponse.vendorStore!.id!);
    }).catchError((error) {
      GlobalVariable.internetErr(true);

      //change(null, status: RxStatus.empty());
      isLoading(false);
      print(">>>StoreDetails $error");
    });
  }

  var vendorProductList = <ProductModel>[].obs;
  int productLimit = 15;
  int page = 1;
  getVendorProducts({int? vendorId}) async {
    print(">>GetVendorPRoducts: $page, $productLimit");
    await _apiProvider
        .geVendorProductById(
            token: authController.userToken,
            storeID: vendorId,
            limit: productLimit,
            page: page)
        .then((value) {
      isLoading(false);
      loadMoreVisibility(false);
      vendorProductList.clear();
      vendorProductList.addAll(value);
    }).catchError((e) {
      isLoading(false);
      loadMoreVisibility(false);
      print(">>>>GetVendorProduct: $e");
    });
  }

  loadMoreVendorProducts() async {
    if (scrollController.hasClients &&
        loadMoreVisibility.isFalse &&
        scrollController.position.maxScrollExtent == scrollController.offset) {
      loadMoreVisibility(true);
      isLoading(true);
      productLimit = 20;
      page++;

      //getVendorProducts(vendorId: vendorID.value.toInt());
    }
  }

  var productQuestionsList = <QuestionModel>[].obs;

  getProductQuestions({productId}) async {
    await _apiProvider
        .geProductQuestionsById(productID: productId)
        .then((value) {
      productQuestionsList.clear();
      productQuestionsList.addAll(value);
    }).catchError((e) {
      print(">>>GetProductQuestions: $e");
    });
  }

  void changePage(int index) {
    pageIndex.value = index;
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOutCubicEmphasized,
    );
  }

  void increment() {
    print("Count: ${count.value} && MOQ: ${moq.value}");
    if (count.value >= moq.value) return;
    count.value++;

    quantityController.text = count.value.toString();
  }

  void decrement() {
    if (count.value == 1) return;
    count.value--;

    quantityController.text = count.value.toString();
  }

  var selectedFeatureIDsList = <int>[].obs;
  var selectedFeatureNamesList = <String>[].obs;

  //TOO: Add item to cart
  addItemLocalCart({ProductModel? product}) async {
    product!.totalPrice = int.parse(
            quantityController.text.isEmpty ? "1" : quantityController.text) *
        product.discountPrice!.toDouble();
    product.vendorId = product.sellerModel!.id;
    CartModel cart = CartModel(
      productId: product.id!,
      productModel: product,
      itemPrice: product.totalPrice,
      quantity: quantityController.text,
      featuresID: selectedFeatureIDsList,
      featuresName: selectedFeatureNamesList,
      onQuantityClicked: false,
    );

    await LocalStorageHelper.addItemToCart(cartModel: cart).then((value) {
      Get.back();
      // AppConstant.displaySnackBar(
      //     langKey.successTitle.tr, langKey.addToCart.tr);
      clearControllers();
      count(1);
    });
  }

  ///Product Full Image View Variables
  var imageChange = false.obs;
  var imageIndex = 0.obs;

  ///Product Full Image View End

  postQuestion({productId}) async {
    String question = questionController.text;
    if (question.isNotEmpty) {
      QuestionModel questionModel = QuestionModel(
        productId: productId,
        question: question,
      );

      await _apiProvider
          .postProductQuestion(
              token: authController.userToken, model: questionModel.toJson())
          .then((ApiResponse? responseModel) {
        if (responseModel != null) {
          if (responseModel.success!) {
            clearControllers();
            showSnackBar("success", responseModel.message);
            getProductQuestions(productId: productId);
          } else
            showSnackBar("success", responseModel.message);
        }
      }).catchError((e) {
        print(">>>PostQuestion: $e");
      });
    }
  }

  addItemToCart({ProductModel? product}) async {
    CartModel cart = CartModel(
      productModel: product,
      quantity: quantityController.text,
      //size: size.value,
      onQuantityClicked: false,
    );

    if (authController.isSessionExpired! && authController.userToken == null) {
      await LocalStorageHelper.addItemToCart(cartModel: cart).then((value) {
        AppConstant.displaySnackBar(langKey.added.tr, langKey.addToCart.tr,
            position: SnackPosition.TOP);
        clearControllers();
        count(1);
      });
    } else {
      var cartData = {"productId": product!.id, "quantity": cart.quantity};
      print("");
      await _apiProvider
          .addCart(token: authController.userToken, data: cartData)
          .then((ApiResponse? response) {
        if (response != null) {
          if (response.success!) {
            clearControllers();
            count(1);
            showSnackBar(langKey.success.tr, response.message);
          } else
            showSnackBar(langKey.errorTitle.tr, response.message);
        } else
          showSnackBar(langKey.errorTitle.tr, langKey.someThingWentWrong.tr);
      }).catchError((error) {
        debugPrint(">>>>addItemToCart $error");
      });
    }

    baseController.setCartItemCount();
  }

  showSnackBar(title, message) {
    AppConstant.displaySnackBar(title, message);
  }

  clearControllers() {
    quantityController.clear();
    questionController.clear();
  }

  @override
  void onClose() {
    super.onClose();

    clearControllers();
  }
}
