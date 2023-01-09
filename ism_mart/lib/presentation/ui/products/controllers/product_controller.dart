import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ism_mart/api_helper/export_api_helper.dart';
import 'package:ism_mart/controllers/export_controllers.dart';
import 'package:ism_mart/models/exports_model.dart';
import 'package:ism_mart/utils/exports_utils.dart';

class ProductController extends GetxController with StateMixin {
  final ApiProvider _apiProvider;

  ProductController(this._apiProvider);

  var pageController = PageController(initialPage: 0);
  var pageIndex = 0.obs;

  var quantityController = TextEditingController();

  var count = 1.obs;

  var size = "L".obs;
  var color = "Black".obs;

  //TODO: minimum Order Qty Limit
  int moq = 10;

  ///end Lists
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    quantityController.text = count.value.toString();


  }

  void fetchProduct(int id) {
    change(null, status: RxStatus.loading());
    _apiProvider.getProductById(id).then((product) {
      change(product, status: RxStatus.success());
      fetchProductBySubCategory(subCategoryId: product.subCategory!.id);
    }).catchError((error) {
      change(null, status: RxStatus.error(error));
    });
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

  void changePage(int index) {
    pageIndex.value = index;
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOutCubicEmphasized,
    );
  }

  void increment() {
    if (count.value == moq) return;
    count.value++;

    quantityController.text = count.value.toString();
  }

  void decrement() {
    if (count.value == 1) return;
    count.value--;

    quantityController.text = count.value.toString();
  }

  //TODO: Add item to cart

  addItemToCart({ProductModel? product}) async {

    CartModel cart = CartModel(
        productModel: product,
        quantity: quantityController.text,
        size: size.value,
        onQuantityClicked: false,
        color: color.value);

    if (authController.isSessionExpired!) {
      debugPrint(">>>AddItemToCart: Session is expired");
      await LocalStorageHelper.addItemToCart(cartModel: cart).then((value) {
        AppConstant.displaySnackBar("Added", "Added to Cart!",
            position: SnackPosition.TOP);
        clearControllers();
        count(1);
      });
    } else {
      await LocalStorageHelper.getStoredUser().then((user) async {
        var cartData = {"productId": product!.id, "quantity": cart.quantity};
        await _apiProvider
            .addCart(token: user.token, data: cartData)
            .then((CartResponse? response) {
          if (response != null) {
            if (response.success!) {
              clearControllers();
              count(1);
              showSnackBar('success', response.message);
            } else
              showSnackBar('error', response.message);
          } else
            showSnackBar('error', 'Something went wrong!');
        }).catchError((error) {
          debugPrint(">>>>addItemToCart $error");
        });
      });
    }

    baseController.setCartItemCount();
  }

  showSnackBar(title, message) {
    AppConstant.displaySnackBar(title, message);
  }

  clearControllers() {
    quantityController.clear();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();

    clearControllers();
  }
}
