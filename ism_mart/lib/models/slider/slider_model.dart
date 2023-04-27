// To parse this JSON data, do
//
//     final sliderModel = sliderModelFromJson(jsonString);

import 'dart:convert';

List<SliderModel> sliderModelFromJson(String str) => List<SliderModel>.from(
    json.decode(str).map((x) => SliderModel.fromJson(x)));

String sliderModelToJson(List<SliderModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SliderModel {
  SliderModel({
    this.id,
    this.image,
    this.type,
    this.status,
    this.title,
    this.info,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? image, type, status, title, info;
  DateTime? createdAt, updatedAt;

  factory SliderModel.fromJson(Map<String, dynamic> json) => SliderModel(
        id: json["id"],
        image: json["image"],
        type: json["type"],
        status: json["status"],
        title: json["title"],
        info: json["info"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "type": type,
        "status": status,
        "title": title,
        "info": info,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
      };
}
