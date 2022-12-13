import 'package:flutter/foundation.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ism_mart/models/exports_model.dart';

class LocalStorageHelper {
  LocalStorageHelper._();

  static const currentUserKey = "currentUser";

  static const cartItemKey = "cartItem";
  static final localStorage = GetStorage();
  static const tag = "LocalStorage:";



  static Future<void> storeUser({UserModel? userModel}) async {
    localStorage.write(currentUserKey, userModel!.toJson()).then((value) {});
  }

  static Future<UserModel> getStoredUser() async {
    if (localStorage.read(currentUserKey) != null) {
      return UserModel.fromJson(localStorage.read(currentUserKey));

    }
    return UserModel();
  }

  static Future<void> addItemToCart({CartModel? cartModel}) async {
    var list = <CartModel>[];
    if (localStorage.read(cartItemKey) != null) {
      list = getCartItems();
      if (isItemExistsInCart(cartModel)) {
        list.removeWhere(
            (element) => element.productModel! == cartModel!.productModel);
      }
    }
    list.add(cartModel!);
    String carts = cartModelToJson(list);
    await saveCart(carts);
  }

  static removeSingleItem({List<CartModel>? cartList}) async {
    String carts = cartModelToJson(cartList!);
    await saveCart(carts);
  }

  static saveCart(cartItems) {
    localStorage.write(cartItemKey, cartItems).then((value) {});
  }

  static updateCartItems({CartModel? cartModel}) async {
    debugPrint("SaveCart UpdateCartItems: ${cartModel!.quantity}");
    if (localStorage.read(cartItemKey) != null) {
      List<CartModel> list = getCartItems();
      list.removeWhere(
          (element) => element.productModel == cartModel.productModel);
      list.add(cartModel);
      String carts = cartModelToJson(list);
      await saveCart(carts);
    }
  }

  static List<CartModel> getCartItems() {
    if (localStorage.read(cartItemKey) == null) return [];
    String data = localStorage.read(cartItemKey);
    return cartModelFromJson(data);
  }

  static Future<List<CartModel>> fetchCartItems() async {
    return getCartItems();
  }

  static int getCartItemsCount() {
    return getCartItems().length;
  }

  static bool isItemExistsInCart(CartModel? cartModel) {
    return getCartItems()
        .where((element) => element.productModel == cartModel!.productModel!)
        .isNotEmpty;
  }

  static deleteAllCart() {
    localStorage.remove(cartItemKey);
  }

  static deleteUserData(){
    localStorage.remove(currentUserKey);
  }
}
