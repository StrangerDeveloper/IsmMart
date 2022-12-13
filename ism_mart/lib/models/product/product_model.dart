import 'dart:convert';

import 'package:get/get.dart';
import 'package:ism_mart/api_helper/api_service.dart';
import 'package:ism_mart/models/exports_model.dart';

List<ProductModel> productModelFromJson(String str) => List<ProductModel>.from(
    json.decode(str).map((x) => ProductModel.fromJson(x)));

String productModelToJson(List<ProductModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductResponse {
  bool? success, key;
  String? message, error;
  ProductModel? productModel;
  List<String>? errors;

  ProductResponse(
      {this.success,
      this.key,
      this.message,
      this.error,
      this.errors,
      this.productModel});

  factory ProductResponse.fromResponse(response) => ProductResponse(
        success: response['success'] == null ? false : response['success'],
        message: response['message'] ?? "",
        error: response['error'],
        errors: response['errors'] != null
            ? List<String>.from(response["errors"].map((x) => x))
            : null,
        /*productModel: response['data'] == null && response['data'].isBlank!
          ? null
          : ProductModel.fromJson(response['data'])*/
      );

  @override
  String toString() {
    return 'ProductResponse{success: $success, key: $key, message: $message, error: $error, productModel: $productModel, errors: $errors}';
  }
}

class ProductModel {
  ProductModel(
      {this.id,
      this.vendorId,
      this.stock,
      this.sold,
      this.price,
      this.discountPrice,
      this.discount,
        this.totalPrice,
      this.rating,
      this.name,
      this.thumbnail,
      this.description,
      this.brand,
      this.model,
      this.weight,
      this.sku,
      this.category,
      this.subCategory,
      this.sellerModel,
      this.colors,
      this.sizes,
      this.images,
      this.categoryId,
      this.subCategoryId,
      this.productImageFile,
      this.isPopular,
      this.hasSalesOn});

  int? id, stock, sold, vendorId, categoryId, subCategoryId;
  num? price, discountPrice, discount, rating, totalPrice;
  String? name, thumbnail, description;
  String? brand, model, weight, sku;
  CategoryModel? category;
  SubCategory? subCategory;
  SellerModel? sellerModel; //Vendor
  List<String>? colors, sizes;
  List<ProductImages>? images;
  MultipartFile? productImageFile;
  bool? isPopular, hasSalesOn;

  factory ProductModel.fromJson(JSON? json) {
    List<ProductImages> productImages = [];

    if (json?['ProductImages'] is List) {
      List list = json?['ProductImages'];
      if (list.isNotEmpty) {
        productImages.addAll(List<ProductImages>.from(
            list.map((e) => ProductImages.fromJson(e))));
      }
    }

    return ProductModel(
      id: json?["id"],
      vendorId: json?['vendorId'],
      name: json?["name"],
      thumbnail: json?["thumbnail"],
      stock: json?["stock"],
      price: json?["price"],
      discount: json?["discount"],
      rating: json?["rating"] ?? 0.0,
      sold: json?["sold"] ?? 0,
      sku: json?["sku"] ?? "",
      brand: json?["brand"] ?? "",
      discountPrice: json?["discountPrice"]??json?["discountedPrice"],
      totalPrice: json?["totalPrice"],
      images: productImages,
      sellerModel: json?['Vendor'] == null
          ? null
          : SellerModel.fromJson(json?['Vendor']),
      category: json?["Category"] == null
          ? null
          : CategoryModel.fromJson(json?["Category"]),
      subCategory: json?["SubCategory"] == null
          ? null
          : SubCategory.fromJson(json?["SubCategory"]),
    );
  }

  JSON toJson() => {
        "id": id,
        "vendorId":vendorId,
        "name": name,
        "thumbnail": thumbnail,
        "description": description,
        "sku": sku ?? name,
        "stock": stock,
        "discountPrice": discountPrice,
        "price": price,
        "discount": discount,
        "brand": brand ?? "SGMC",
        "categoryId": categoryId,
        "subCategoryId": subCategoryId,
      };

  @override
  bool operator ==(Object other) {
    if (other is! ProductModel) return false;
    if (id != other.id) return false;
    return true;
  }

  @override
  String toString() {
    return 'ProductModel{id: $id, stock: $stock, sold: $sold, categoryId: $categoryId, subCategoryId: $subCategoryId, price: $price, discountPrice: $discountPrice, discount: $discount, rating: $rating, name: $name, thumbnail: $thumbnail, description: $description, brand: $brand, model: $model, weight: $weight, sku: $sku, category: $category, subCategory: $subCategory, sellerModel: $sellerModel, colors: $colors, sizes: $sizes, images: $images, productImageFile: $productImageFile, isPopular: $isPopular, hasSalesOn: $hasSalesOn}';
  }
}

List<ProductImages> productImagesFromJson(String str) =>
    List<ProductImages>.from(
        json.decode(str).map((x) => ProductImages.fromJson(x)));

String productImagesToJson(List<ProductImages> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductImages {
  String? url;

  ProductImages({this.url});

  factory ProductImages.fromJson(JSON? json) =>
      ProductImages(url: json?['url']);

  JSON? toJson() => {'url': url};
}
