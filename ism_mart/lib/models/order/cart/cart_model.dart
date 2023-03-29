import 'dart:convert';

import 'package:ism_mart/api_helper/api_service.dart';
import 'package:ism_mart/models/exports_model.dart';

List<CartModel> cartModelFromJson(String str) =>
    List<CartModel>.from(json.decode(str).map((x) => CartModel.fromJson(x)));

String cartModelToJson(List<CartModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CartResponse {
  bool? success;
  String? message;
  List<String>? errors;

  CartResponse({
    this.success,
    this.message,
    this.errors,
  });

  factory CartResponse.fromJson(Map<String, dynamic> json) => CartResponse(
    success: json["success"],
    message: json["message"],
    errors: json["errors"] == null
        ? []
        : List<String>.from(json["errors"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "errors": List<dynamic>.from(errors!.map((x) => x)),
  };
}
class CartModel {
  int? id, productId;

  ProductModel? productModel;
  String? quantity;
  bool? onQuantityClicked;
  List<String>? errors;
  List<int>? featuresID;
  List<String>? featuresName;

  CartModel({
    this.id,
    this.productId,
    this.productModel,
    this.quantity,
    this.featuresID,
    this.featuresName,
    this.errors,
    this.onQuantityClicked = false,
  });

  factory CartModel.fromJson(JSON value) {
    return CartModel(
      id: value['id'],
      productId: value['productId'],
      productModel: ProductModel.fromJson(value['Product']),
      quantity: value['quantity'].toString(),
      featuresName: List<String>.from(value['featuresName'].map((x) => x)),
      featuresID: List<int>.from(value["features"].map((x) => x)),
      //onQuantityClicked: json['onQuantityClicked'],
    );
  }

  JSON toJson() =>
      {
        'Product': productModel!.toOrderCheckoutJson(),
        'features': featuresID,
        'featuresName': featuresName,
        'productId': productId,
        'quantity': quantity,
        'onQuantityClicked': onQuantityClicked
      };
  JSON toOrderCreationJson()=>{
    "productId": productId,
    "quantity": quantity,
    "features": featuresID,
    "Product": productModel!.toOrderCheckoutJson()
  };
}


