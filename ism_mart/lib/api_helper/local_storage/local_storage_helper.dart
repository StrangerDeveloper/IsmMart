import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:ism_mart/helper/global_variables.dart';
import 'package:ism_mart/models/exports_model.dart';

class LocalStorageHelper {
  LocalStorageHelper._();

  static const searchHistoryKey = "searchHistory";
  static const currentUserKey = "currentUser";

  static const cartItemKey = "cartItem";

  static final localStorage = GetStorage();

  static const tag = "LocalStorage:";
  static const currCurrencyKey = "currCurrencyKey";

  static Future<void> initUserStorage() async {
    if (localStorage.read(currentUserKey) == null) {
      print(">>>FirstTimeUserTokenKeyInMemory: ");
      await localStorage.write(currentUserKey, UserModel().toJson());
    } else
      print(">>>SecondTimeUserTokenKeyInMemory: ");
  }

  static Future<void> storeCurrency({CurrencyModel? currencyModel}) async {
    localStorage.write(currCurrencyKey, currencyModel!.toLocalStorageJson());
  }

  static Future<CurrencyModel> getStoredCurrency() async {
    if (localStorage.read(currCurrencyKey) != null) {
      return CurrencyModel.fromLocalStorageJson(
          localStorage.read(currCurrencyKey));
    }
    return CurrencyModel(exchangeRate: 1, from: "pkr", to: "pkr");
  }

  static Future<void> storeUser({UserModel? userModel}) async {
    localStorage.write(currentUserKey, userModel!.toJson()).then((value) {});
  }

  static Future<UserModel> getStoredUser() async {
    if (localStorage.read(currentUserKey) != null) {
      return UserModel.fromJson(localStorage.read(currentUserKey));
    }
    return UserModel();
  }
////////////////// Search History ////////////////////////////////////////////////

  static Future<void> saveHistory({String? history}) async {
    getHistory().then((List<String> list) {
      if (!list.contains(history)) {
        list.add(history!);
      }
      print("SaveHistory: ${list.toString()}");
      localStorage.write(searchHistoryKey, jsonEncode(list));
    });
  }

  static Future<List<String>> getHistory() async {
    if (localStorage.read(searchHistoryKey) != null) {
      return List<String>.from(jsonDecode(localStorage.read(searchHistoryKey)));
    }
    return [];
  }

  static Future<void> clearHistory() async {
    localStorage.remove(searchHistoryKey);
  }

///////////////// Cart Section //////////////////////////////////////////////////
  static Future<void> addItemToCart({CartModel? cartModel}) async {
    var list = <CartModel>[];

    if (localStorage.read(cartItemKey) != null) {
      list = getCartItems();

      if (isItemExistsInCart(cartModel)) {
        list.removeWhere(
            (element) => element.productId! == cartModel!.productId);
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
    print(">>>UpdateCartItem: ${cartModel!.toJson()}");
    if (localStorage.read(cartItemKey) != null) {
      List<CartModel> list = getCartItems();
      final index = list
          .indexWhere((element) => element.productId == cartModel.productId);
      if (index != -1) {
        list[index].quantity = cartModel.quantity;
        list[index].itemPrice = cartModel.itemPrice!;
        String carts = cartModelToJson(list);
        await saveCart(carts);
      }

      // list.removeWhere((element) => element.productId == cartModel!.productId);
      // list.add(cartModel);
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
        .where((element) => element.productModel == cartModel!.productModel)
        .isNotEmpty;
  }

  static clearAllCart() {
    localStorage.remove(cartItemKey);
  }

  static deleteUserData() {
    localStorage.remove(currentUserKey);
    GlobalVariable.userModel = null;
  }

  static storeEmailVerificationDetails() {
    DateTime time = DateTime.now();
    localStorage.write('emailVerificationTime', time.toIso8601String());
  }

  static getEmailVerificationDetails() async {
    var emailVerificationDetails =
        await localStorage.read('emailVerificationTime');
    return emailVerificationDetails;
  }
}
