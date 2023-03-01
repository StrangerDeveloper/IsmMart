import 'package:ism_mart/models/exports_model.dart';

class ProductVariantsModel {
  ProductVariantsModel({
    this.id,
    this.name,
    this.label,
    this.placeholder,
    this.required,
    this.multiple,
    this.type,
    this.createdAt,
    this.updatedAt,
    this.category,
    this.subCategory,
  });

  int? id;
  String? name, label, placeholder, type;
  bool? required, multiple;
  DateTime? createdAt;
  DateTime? updatedAt;
  CategoryModel? category;
  SubCategory? subCategory;

  factory ProductVariantsModel.fromJson(Map<String, dynamic> json) =>
      ProductVariantsModel(
        id: json["id"],
        name: json["name"],
        label: json["label"],
        placeholder: json["placeholder"] == null ? null : json["placeholder"],
        required: json["required"] == null ? false : json["required"],
        multiple: json["multiple"] == null ? false : json["multiple"],
        type: json["type"] == null ? null : json["type"],
        category: json["Category"] == null
            ? null
            : CategoryModel.fromJson(json["Category"]),
        subCategory: json["SubCategory"] == null
            ? null
            : SubCategory.fromJson(json["SubCategory"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "label": label,
        "placeholder": placeholder,
        "required": required,
        "multiple": multiple,
        "type": type,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "Category": category!.toJson(),
        "SubCategory": subCategory!.toJson(),
      };
}
