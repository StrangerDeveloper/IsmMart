import 'package:ism_mart/exports/exports_model.dart';

class ProductVariantsModel {
  ProductVariantsModel(
      {this.id,
      this.name,
      this.label,
      this.placeholder,
      this.required,
      this.multiple,
      this.isNewField = false,
      this.type,
      this.createdAt,
      this.updatedAt,
      this.category,
      this.subCategory,
      this.categoryFieldOptions,
      this.moreFieldOptionList});

  int? id;
  String? name, label, placeholder, type;
  bool? required, multiple, isNewField;
  DateTime? createdAt;
  DateTime? updatedAt;
  CategoryModel? category;
  SubCategory? subCategory;
  List<ProductVariantsModel>? categoryFieldOptions;
  List<ProductVariantsModel>?
      moreFieldOptionList; // used for when users press on add/remove btn

  factory ProductVariantsModel.fromJson(Map<String, dynamic> json) =>
      ProductVariantsModel(
        id: json["id"],
        name: json["name"],
        label: json["label"],
        placeholder: json["placeholder"] == null ? null : json["placeholder"],
        required: json["required"] == null ? false : json["required"],
        multiple: json["multiple"] == null ? false : json["multiple"],
        type: json["type"] == null ? null : json["type"],
        isNewField: false,
        category: json["Category"] == null
            ? null
            : CategoryModel.fromJson(json["Category"]),
        subCategory: json["SubCategory"] == null
            ? null
            : SubCategory.fromJson(json["SubCategory"]),
        moreFieldOptionList: [],
        categoryFieldOptions: json["CategoryFieldOptions"] == null
            ? []
            : List<ProductVariantsModel>.from(json["CategoryFieldOptions"]!
                .map((x) => ProductVariantsModel.fromJson(x))),
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
        "CategoryFieldOptions": categoryFieldOptions == null
            ? []
            : List<dynamic>.from(categoryFieldOptions!.map((x) => x.toJson())),
      };

  Map<String, dynamic> toJsonPrint() => {
        "id": id,
        "name": name,
        "label": label,
        "type": type,
        "isNew": isNewField
      };
}
