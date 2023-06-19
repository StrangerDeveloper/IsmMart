// To parse this JSON data, do
//
//     final categoryModel = categoryModelFromJson(jsonString);

import 'dart:convert';

import 'package:ism_mart/api_helper/api_service.dart';
import 'package:ism_mart/models/exports_model.dart';

List<CategoryModel> categoryModelFromJson(String str) =>
    List<CategoryModel>.from(
        json.decode(str).map((x) => CategoryModel.fromJson(x)));

String categoryModelToJson(List<CategoryModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CategoryModel {
  CategoryModel(
      {this.id,
      this.name,
      this.subCategories,
      this.updatedAt,
      this.createdAt,
      this.image,
      this.isPressed = false});

  String? name, image;
  int? id;
  List<SubCategory>? subCategories;
  DateTime? updatedAt, createdAt;
  bool? isPressed;

  factory CategoryModel.fromJson(JSON json) => CategoryModel(
        id: json["id"],
        name: json["name"],
        subCategories: json["SubCategories"] != null
            ? List<SubCategory>.from(
                json["SubCategories"].map((x) => SubCategory.fromJson(x)))
            : [],
        updatedAt: json["updatedAt"] != null
            ? DateTime.parse(json["updatedAt"])
            : null,
        createdAt: json["createdAt"] != null
            ? DateTime.parse(json["createdAt"])
            : null,
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "SubCategories":
            List<dynamic>.from(subCategories!.map((x) => x.toJson())),
        "updatedAt": updatedAt?.toIso8601String(),
        "createdAt": createdAt?.toIso8601String(),
        "image": image,
      };
}
