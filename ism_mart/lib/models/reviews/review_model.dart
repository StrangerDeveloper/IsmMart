import 'package:ism_mart/models/exports_model.dart';

class ReviewModel {
  ReviewModel({
    this.count,
    this.reviewsList,
  });

  int? count;
  List<Review?>? reviewsList;

  factory ReviewModel.fromJson(Map<String, dynamic> json) => ReviewModel(
        count: json["count"],
    reviewsList: json["rows"] == null
            ? []
            : List<Review?>.from(json["rows"]!.map((x) => Review.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "rows": reviewsList == null
            ? []
            : List<dynamic>.from(reviewsList!.map((x) => x!.toJson())),
      };
}

class Review {
  Review({
    this.id,
    this.text,
    this.rating,
    this.user,
  });

  int? id;
  String? text;
  int? rating;
  UserModel? user;

  factory Review.fromJson(Map<String, dynamic> json) => Review(
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
