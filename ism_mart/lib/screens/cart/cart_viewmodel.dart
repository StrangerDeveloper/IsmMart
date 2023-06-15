import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../api_helper/local_storage/local_storage_helper.dart';
import '../../models/order/cart/cart_model.dart';

class CartViewModel extends GetxController {

  final cartItemsList = <CartModel>[].obs;
  var quantityController = TextEditingController();
  final count = RxInt(1);
  final onQuantityClick = RxBool(false);
  final totalCartAmount = RxDouble(0.0);
  final totalQtyCart = RxInt(0);

  ///: minimum Order Qty Limit
  int moq = 10;

  @override
  void onInit() {
    fetchCartItemsFromLocal();
    super.onInit();
  }

  @override
  void onReady() {
    getTotalCartAmount();
    super.onReady();
  }

  fetchCartItemsFromLocal() async {
    await LocalStorageHelper.fetchCartItems().then((value) {
      cartItemsList.clear();
      cartItemsList.addAll(value);
      getTotalCartAmount();
    });
  }

  getTotalCartAmount() {
    double totalAmount = 0.0;
    int totalQty = 0;
    if (cartItemsList.isNotEmpty) {
      for (var item in cartItemsList) {
        var discountPrice = double.parse(
            item.productModel!.discountPrice != null
                ? item.productModel!.discountPrice.toString()
                : "0");
        var qty = int.parse(item.quantity.toString());
        totalAmount += (discountPrice.round() * qty);
        totalQty += qty;
      }
    }
    totalCartAmount(totalAmount);
    totalQtyCart(totalQty);
  }

  incrementQuantity(int index)async{
    int quantity = int.parse(cartItemsList[index].quantity!);
    if (quantity >= cartItemsList[index].productModel!.stock!)
      return;
    cartItemsList[index].quantity = "${quantity + 1}";
    cartItemsList[index].productModel!.totalPrice = totalCartAmount.value;
    cartItemsList[index].itemPrice = (quantity + 1) *
    cartItemsList[index].productModel!.discountPrice!.round();
    cartItemsList.refresh();
    getTotalCartAmount();
    await LocalStorageHelper.updateCartItems(
        cartModel: cartItemsList[index]);
  }

  decrementQuantity(int index)async{
    int quantity = int.parse(cartItemsList[index].quantity!);
    if (quantity <= 1) return;
    cartItemsList[index].quantity = "${quantity - 1}";
    cartItemsList[index].productModel!.totalPrice = totalCartAmount.value;
    cartItemsList[index].itemPrice = ((quantity - 1) * cartItemsList[index].productModel!.discountPrice!.round());
    cartItemsList.refresh();
    getTotalCartAmount();
    await LocalStorageHelper.updateCartItems(cartModel: cartItemsList[index]);
  }

  deleteItem(int index){
    cartItemsList.removeAt(index);
    getTotalCartAmount();
    LocalStorageHelper.removeSingleItem(cartList: cartItemsList);
  }

  // void increment() async {
  //   if (count.value == moq) {
  //     return;
  //   }
  //   else {
  //     count.value++;
  //     quantityController.text = count.value.toString();
  //   }
  // }
  //
  // void decrement() async {
  //   if (count.value == 1) return;
  //   count.value--;
  //   quantityController.text = count.value.toString();
  // }
}
