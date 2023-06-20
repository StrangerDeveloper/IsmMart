import 'package:ism_mart/exports/exports_model.dart';

class SellerProductModel{
  int? totalProducts, pendingProducts, approvedProducts, rejectedProducts, disabledProducts;
  List<ProductModel>? products;

  SellerProductModel({
    this.totalProducts,
    this.pendingProducts,
    this.approvedProducts,
    this.rejectedProducts,
    this.disabledProducts,
    this.products});

  factory SellerProductModel.fromJson(Map<String, dynamic> json) => SellerProductModel(
    totalProducts: json["totalProducts"],
    pendingProducts: json["pendingProducts"],
    approvedProducts: json["approvedProducts"],
    rejectedProducts: json["rejectedProducts"],
    disabledProducts: json["disabledProducts"],
    products: List<ProductModel>.from(json["products"].map((x) => ProductModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "totalProducts": totalProducts,
    "pendingProducts": pendingProducts,
    "approvedProducts": approvedProducts,
    "rejectedProducts": rejectedProducts,
    "disabledProducts": disabledProducts,
    "products": List<dynamic>.from(products!.map((x) => x.toJson())),
  };
}