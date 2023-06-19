class SubCategory {
  SubCategory({
    this.id,
    this.name,
    this.categoryId,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? name;
  int? categoryId;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory SubCategory.fromJson(Map<String, dynamic> json) => SubCategory(
        id: json["id"],
        name: json["name"],
        categoryId: json["categoryId"],
        createdAt: json["createdAt"]!=null?DateTime.parse(json["createdAt"]):null,
        updatedAt: json["updatedAt"]!=null?DateTime.parse(json["updatedAt"]):null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "categoryId": categoryId,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}
