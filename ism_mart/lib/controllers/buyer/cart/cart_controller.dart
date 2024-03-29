import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ism_mart/exports/export_api_helper.dart';
import 'package:ism_mart/exports/export_controllers.dart';
import 'package:ism_mart/exports/exports_model.dart';
import 'package:ism_mart/exports/exports_utils.dart';

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

    LocalStorageHelper.fetchCartItems().then((value) {
      cartItemsList.clear();
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
      for (CartModel? model in list) {
        var discountPrice = double.parse(
            model!.productModel!.discountPrice != null
                ? model.productModel!.discountPrice.toString()
                : "0");
        var qty = int.parse(model.quantity!);
        totalAmount += (discountPrice.round() * qty);
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
    //update();
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
