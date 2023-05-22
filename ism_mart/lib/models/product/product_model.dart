import 'dart:convert';

import 'package:get/get.dart';
import 'package:ism_mart/api_helper/api_service.dart';
import 'package:ism_mart/models/exports_model.dart';

List<ProductModel> productModelFromJson(String str) => List<ProductModel>.from(
    json.decode(str).map((x) => ProductModel.fromJson(x)));

String productModelToJson(List<ProductModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

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
      this.status,
      this.images,
      this.categoryId,
      this.subCategoryId,
      this.productImageFile,
      this.isPopular,
      this.hasSalesOn,
      this.productFeatures});

  int? id, stock, sold, vendorId, categoryId, subCategoryId;
  num? price, discountPrice, discount, rating, totalPrice;
  String? name, thumbnail, description, status;
  String? brand, model, weight, sku;
  CategoryModel? category;
  SubCategory? subCategory;
  SellerModel? sellerModel; //Vendor
  //List<String>? colors, sizes;
  List<ProductImages>? images;
  MultipartFile? productImageFile;
  bool? isPopular, hasSalesOn;

  Map<String, List<ProductFeature>>? productFeatures;

  factory ProductModel.fromJson(JSON? json) {
    List<ProductImages> productImages = [];

    if (json?['ProductImages'] is List) {
      List list = json?['ProductImages'];
      if (list.isNotEmpty) {
        productImages.addAll(List<ProductImages>.from(
            list.map((e) => ProductImages.fromJson(e))));
      }
    }
    Map<String, dynamic>? productFeaturesJson =
        json?['ProductFeatures'] == null ? null : json?['ProductFeatures'];
    Map<String, List<ProductFeature>> productFeatures = {};
    if (productFeaturesJson != null) {
      productFeaturesJson.forEach((key, value) {
        List<ProductFeature> features = (value as List)
            .map((feature) => ProductFeature.fromJson(feature))
            .toList();
        if (!key.contains("undefined")) productFeatures[key] = features;
      });
    }

    return ProductModel(
        id: json?["id"],
        vendorId: json?['vendorId'],
        name: json?["name"],
        thumbnail: json?["thumbnail"],
        stock: json?["stock"],
        price: json?["price"],
        status: json?['status'],
        discount: json?["discount"],
        rating: json?["rating"] ?? 0.0,
        sold: json?["sold"] ?? 0,
        sku: json?["sku"] ?? "",
        brand: json?["brand"] ?? "",
        description: json?['description'] ?? "",
        discountPrice: json?["discountPrice"] ?? json?["discountedPrice"],
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
        productFeatures: productFeatures);
  }

  JSON toJson() => {
        "id": id,
        "vendorId": vendorId,
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

  JSON toOrderCheckoutJson() => {
        "name": name,
        "thumbnail": thumbnail,
        "vendorId": vendorId,
        "discountPrice": discountPrice,
        "totalPrice": totalPrice,
        "stock": stock,
      };

  JSON toUpdateProductJson() => {
        "id": id,
        "name": name,
        "description": description,
        "stock": stock,
        "price": price,
        "discount": discount,
      };

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is ProductModel && other.id == id && other.name == name;
  }

  @override
  String toString() {
    return 'ProductModel{id: $id, stock: $stock, sold: $sold, categoryId: $categoryId, subCategoryId: $subCategoryId, price: $price, discountPrice: $discountPrice, discount: $discount, rating: $rating, name: $name, thumbnail: $thumbnail, description: $description, brand: $brand, model: $model, weight: $weight, sku: $sku, category: $category, subCategory: $subCategory, sellerModel: $sellerModel, images: $images, productImageFile: $productImageFile, isPopular: $isPopular, hasSalesOn: $hasSalesOn}';
  }
}

List<ProductImages> productImagesFromJson(String str) =>
    List<ProductImages>.from(
        json.decode(str).map((x) => ProductImages.fromJson(x)));

String productImagesToJson(List<ProductImages> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductImages {
  String? url;
  int? id;

  ProductImages({this.url, this.id});

  factory ProductImages.fromJson(JSON? json) =>
      ProductImages(url: json?['url'], id: json?["id"]);

  JSON? toJson() => {'url': url, "id": id};
}

class ProductFeature {
  ProductFeature({
    this.id,
    this.value,
    this.categoryField,
  });

  int? id;
  String? value;
  ProductVariantsModel? categoryField;

  factory ProductFeature.fromJson(Map<String, dynamic> json) => ProductFeature(
        id: json["id"],
        value: json["value"],
        categoryField: json["CategoryField"] == null
            ? null
            : ProductVariantsModel.fromJson(json["CategoryField"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "value": value,
        "CategoryField": categoryField?.toJson(),
      };

//   ProductFeature({
//     this.colors,
//     this.sizes,
//   });

//   //List<Feature>? colors;
//  // List<Feature>? sizes;

//   factory ProductFeature.fromJson(Map<String, dynamic> json) {
//     return ProductFeature();
//   }

//   factory ProductFeature.fromJson(Map<String, dynamic> json) => ProductFeature(
//         colors: json["Colors"] == null
//             ? []
//             : List<Feature>.from(
//                 json["Colors"]!.map((x) => Feature.fromJson(x))),
//         sizes: json["Sizes"] == null
//             ? []
//             : List<Feature>.from(
//                 json["Sizes"]!.map((x) => Feature.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "Colors": colors == null
//             ? []
//             : List<dynamic>.from(colors!.map((x) => x.toJson())),
//         "Sizes": sizes == null
//             ? []
//             : List<dynamic>.from(sizes!.map((x) => x.toJson())),
//       };
}

// class Feature {
//   Feature({
//     this.id,
//     this.value,
//     this.categoryField,
//   });

//   int? id;
//   String? value;
//   ProductVariantsModel? categoryField;

//   factory Feature.fromJson(Map<String, dynamic> json) => Feature(
//         id: json["id"],
//         value: json["value"],
//         categoryField: json["CategoryField"] == null
//             ? null
//             : ProductVariantsModel.fromJson(json["CategoryField"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "value": value,
//         "CategoryField": categoryField?.toJson(),
//       };
// }
