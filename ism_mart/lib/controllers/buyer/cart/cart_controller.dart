import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ism_mart/api_helper/export_api_helper.dart';
import 'package:ism_mart/controllers/export_controllers.dart';
import 'package:ism_mart/models/exports_model.dart';
import 'package:ism_mart/utils/exports_utils.dart';

/*class MyStates<T1, T2> {
  T1? state1;
  T2? state2;

  MyStates({this.state1, this.state2});
}

abstract class BaseCartController extends GetxController
    with StateMixin<MyStates<CartModel, ProductModel>> {}*/

class CartController extends GetxController with StateMixin
/*with StateMixin<MyStates<List<CartModel>, ProductModel>>*/ {
  CartController(this._apiProvider);

  final ApiProvider _apiProvider;

  var quantityController = TextEditingController();
  var count = 1.obs;
  var onQuantityClick = false.obs;

  //TODO: minimum Order Qty Limit
  int moq = 10;
  var isLoading = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    quantityController.text = count.value.toString();


  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    ever(cartItemsList, getTotalCartAmount);
  }

  //TODO: Start Cart Items

  var cartItemsList = <CartModel>[].obs;

  fetchCartItemsFromLocal() {
    change(null, status: RxStatus.loading());
    //isLoading(true);
    cartItemsList.clear();
    LocalStorageHelper.fetchCartItems().asStream().listen((value) {
      cartItemsList.addAll(value);
      isLoading(false);
      change(value, status: RxStatus.success());
      //change(MyStates(state1: value,), status: RxStatus.success());
    });

  }

  fetchCartItems() async {

    isLoading(true);
    change(null, status: RxStatus.loading());
    await LocalStorageHelper.getStoredUser().then((user) async {
        await _apiProvider.getCartItems(token: user.token).then((data) {
          change(data, status: RxStatus.success());
          cartItemsList.clear();
          isLoading(false);
          cartItemsList.addAll(data);
          cartItemsList.refresh();

        }).catchError((error) {
          isLoading(false);
          debugPrint(">>>>FetchCartItems $error");
          //change(null, status: RxStatus.error(error));
        });
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
            showSnackBar('success', response.message);
            fetchCartItems();
          } else
            showSnackBar('error', response.message);
        } else
          showSnackBar('error', 'Something went wrong!');
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
            showSnackBar('success', response.message);
            fetchCartItems();
          } else
            showSnackBar('error', response.message);
        } else
          showSnackBar('error', 'Something went wrong!');
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
    double totalAmount = 0.0;
    int totalQty = 0;
    if (list.isNotEmpty) {
      for (var value in list) {
        double discountPrice = double.parse(value.productModel!.discountPrice!=null
            ? value.productModel!.discountPrice.toString()
            : 0.0
                .toString()); //double.parse(value.productModel!.discountPrice!.replaceAll("\$", ""));
        int qty = int.parse(value.quantity!);

        totalAmount += (discountPrice * qty);
        totalQty += qty;
      }
    }
    totalCartAmount(totalAmount);
    totalQtyCart(totalQty);
  }

  //ENd Cart Items

  void increment({CartModel? cartModel}) {
    if (count.value == moq) return;
    count.value++;

    quantityController.text = count.value.toString();
    cartModel!.quantity = quantityController.text;
    LocalStorageHelper.updateCartItems(cartModel: cartModel);
  }

  void decrement({CartModel? cartModel}) {
    if (count.value == 1) return;
    count.value--;

    quantityController.text = count.value.toString();
    cartModel!.quantity = quantityController.text;
    LocalStorageHelper.updateCartItems(cartModel: cartModel);
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}
