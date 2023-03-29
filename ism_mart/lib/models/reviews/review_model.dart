import 'package:ism_mart/models/exports_model.dart';

class ReviewModelResponse {
  ReviewModelResponse({
    this.count,
    this.rating,
    this.reviewsList,

  });

  num? count, rating;
  List<ReviewModel>? reviewsList;

  factory ReviewModelResponse.fromJson(Map<String, dynamic> json) =>
      ReviewModelResponse(
        count: json["count"],
        rating: json['rating'] == null ? 0.0: json['rating'],
        reviewsList: json["rows"] == null
            ? []
            : List<ReviewModel>.from(
                json["rows"]!.map((x) => ReviewModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "rows": reviewsList == null
            ? []
            : List<dynamic>.from(reviewsList!.map((x) => x!.toJson())),
      };
}

class ReviewModel {
  ReviewModel({
    this.id,
    this.text,
    this.rating,
    this.user,
  });

  int? id;
  String? text;
  num? rating;
  UserModel? user;

  factory ReviewModel.fromJson(Map<String, dynamic> json) => ReviewModel(
        id: json["id"],
        text: json["text"],
        rating: json["rating"],
        user: UserModel.fromJson(json["User"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "text": text,
        "rating": rating,
        "User": user!.toJson(),
      };
}
