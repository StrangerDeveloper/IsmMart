import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ism_mart/api_helper/export_api_helper.dart';
import 'package:ism_mart/controllers/export_controllers.dart';
import 'package:ism_mart/models/exports_model.dart';
import 'package:ism_mart/utils/exports_utils.dart';
import 'package:ism_mart/utils/languages/translations_key.dart' as langKey;

/*class MyStates<T1, T2> {
  T1? state1;
  T2? state2;

  MyStates({this.state1, this.state2});
}

abstract class BaseCartController extends GetxController
    with StateMixin<MyStates<CartModel, ProductModel>> {}*/

class CartController extends GetxController
    with
        StateMixin /*with StateMixin<MyStates<List<CartModel>, ProductModel>>*/ {
  CartController(this._apiProvider);

  final ApiProvider _apiProvider;

  var quantityController = TextEditingController();
  var count = 1.obs;
  var onQuantityClick = false.obs;

  ///: minimum Order Qty Limit
  int moq = 10;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    quantityController.text = count.value.toString();
  }

  @override
  void onReady() {
    super.onReady();

    LocalStorageHelper.localStorage.listenKey(LocalStorageHelper.cartItemKey,
        (value) {
      debugPrint("Cart is listening....");
      fetchCartItemsFromLocal();
    });

    ever(cartItemsList, getTotalCartAmount);
  }

  //TDO: Start Cart Items

  var cartItemsList = <CartModel>[].obs;

  fetchCartItemsFromLocal() {
    change(null, status: RxStatus.loading());
    //isLoading(true);
    cartItemsList.clear();
    LocalStorageHelper.fetchCartItems().then((value) {
      cartItemsList.addAll(value);
      isLoading(false);
      change(value, status: RxStatus.success());
      //change(MyStates(state1: value,), status: RxStatus.success());
    });
  }

  fetchCartItems() async {
    isLoading(true);
    change(null, status: RxStatus.loading());
    await _apiProvider
        .getCartItems(token: authController.userToken)
        .then((data) {
      change(data, status: RxStatus.success());
      cartItemsList.clear();
      isLoading(false);
      cartItemsList.addAll(data);
      cartItemsList.refresh();
    }).catchError((error) {
      isLoading(false);
      debugPrint(">>>>FetchCartItems $error");
      change(null, status: RxStatus.error(error));
    });
    // ever(cartItemsList, getTotalCartAmount);
  }

  updateCart({cartItemId, quantity}) async {
    var cartData = {"cartItemId": "$cartItemId", "quantity": quantity};
    await LocalStorageHelper.getStoredUser().then((user) async {
      await _apiProvider
          .updateCartItem(token: user.token, data: cartData)
          .then((CartResponse? response) {
        if (response != null) {
          if (response.success!) {
            showSnackBar(langKey.success, response.message);
            fetchCartItems();
          } else
            showSnackBar(langKey.errorTitle, response.message);
        } else
          showSnackBar(langKey.errorTitle, langKey.someThingWentWrong);
      }).catchError((error) {
        debugPrint(">>>>updateCart $error");
      });
    });
  }

  deleteCartItem({cartItemId}) async {
    await LocalStorageHelper.getStoredUser().then((user) async {
      await _apiProvider
          .deleteCartItem(token: user.token, cartId: cartItemId)
          .then((CartResponse? response) {
        if (response != null) {
          if (response.success!) {
            showSnackBar(langKey.success, response.message);
            fetchCartItems();
          } else
            showSnackBar(langKey.errorTitle, response.message);
        } else
          showSnackBar(langKey.errorTitle, langKey.someThingWentWrong);
      }).catchError((error) {
        debugPrint(">>>>DeleteItem $error");
      });
    });
  }

  showSnackBar(title, message) {
    AppConstant.displaySnackBar(title, message);
  }

  var totalCartAmount = 0.0.obs;
  var totalQtyCart = 0.obs;

  getTotalCartAmount(List<CartModel> list) {
    baseController.setCartItemCount();
    double totalAmount = 0.0;
    int totalQty = 0;
    if (list.isNotEmpty) {
      for (var value in list) {
        double discountPrice = double.parse(
            value.productModel!.discountPrice != null
                ? value.productModel!.discountPrice.toString()
                : "0");
        var qty = int.parse(value.quantity.toString());
        totalAmount += (discountPrice * qty);
        totalQty += qty;
      }
    }

    totalCartAmount(totalAmount);
    totalQtyCart(totalQty);
  }

  CartModel? cartModel;
  int moqq = 10;
  var counter = 1.obs;
  void increment() async {
    if (counter.value == moqq) return;
    counter.value++;

    quantityController.text = counter.value.toString();
    quantityController.text = counter.value.toString();

    cartModel!.quantity = quantityController.text.toString();
    cartModel!.productModel!.totalPrice = totalCartAmount.value;
    await LocalStorageHelper.updateCartItems(cartModel: cartModel);
    update();
  }

  void decrement() async {
    if (counter.value == 1) return;
    counter.value--;

    quantityController.text = counter.value.toString();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
