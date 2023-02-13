import 'dart:convert';

import 'package:ism_mart/api_helper/api_service.dart';
import 'package:ism_mart/models/exports_model.dart';

List<CartModel> cartModelFromJson(String str) =>
    List<CartModel>.from(json.decode(str).map((x) => CartModel.fromJson(x)));

String cartModelToJson(List<CartModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CartModel {
  int? id, productId;

  ProductModel? productModel;
  String? quantity, size, color;
  bool? onQuantityClicked;
  List<String>? errors;

  CartModel({
    this.id,
    this.productId,
    this.productModel,
    this.quantity,
    this.size,
    this.color,
    this.errors,
    this.onQuantityClicked = false,
  });

  factory CartModel.fromJson(JSON json) {
    if (json is List<String>) {
      return CartModel(errors: List<String>.from(json["data"].map((x) => x)));
    }

    return CartModel(
      id: json['id'],
      productId: json['productId'],
      productModel: ProductModel.fromJson(json['Product']),
      color: json['color'],
      size: json['size'],
      quantity: json['quantity'].toString(),
      //onQuantityClicked: json['onQuantityClicked'],
    );
  }

  JSON toJson() =>
      {
        'Product': productModel!.toJson(),
        'color': color,
        'productId': productId,
        'size': size,
        'quantity': quantity,
        'onQuantityClicked': onQuantityClicked
      };
  JSON toOrderCreationJson()=>{
    "productId": productId,
    "quantity": quantity,
    "Product": productModel!.toOrderCheckoutJson()
  };
}

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
