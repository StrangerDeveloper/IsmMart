import 'package:ism_mart/api_helper/export_api_helper.dart';

import 'user_model.dart';

class SellerModel {
  int? id, userId;
  String? storeName, storeDesc, storeUrl;
  String? ownerName, status, visibility;
  num? rating;
  String? stripeCustomerId, phone, membership;
  bool? premium;
  DateTime? createdAt, updatedAt;
  UserModel? user;

  SellerModel({
    this.id,
    this.storeName,
    this.storeDesc,
    this.storeUrl,
    this.ownerName,
    this.status,
    this.visibility,
    this.rating,
    this.stripeCustomerId,
    this.phone,
    this.premium,
    this.membership,
    this.createdAt,
    this.userId,
    this.updatedAt,
    this.user,
  });

  factory SellerModel.fromJson(JSON json) => SellerModel(
      id: json["id"],
      storeName: json["storeName"] == null ? null : json["storeName"],
      storeDesc: json["storeDesc"] == null ? null : json["storeDesc"],
      storeUrl: json["storeURL"] == null ? null : json["storeURL"],
      ownerName: json["ownerName"] == null ? null : json["ownerName"],
      status: json["status"],
      visibility: json["visibility"],
      rating: json["rating"],
      stripeCustomerId:
          json["stripeCustomerId"] == null ? null : json["stripeCustomerId"],
      phone: json["phone"] == null ? null : json["phone"],
      premium: json["premium"],
      membership: json["membership"],
      createdAt: DateTime.parse(json["createdAt"]),
      userId: json["userId"] == null ? null : json["userId"],
      updatedAt:
          json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
      user: json['User'] != null ? UserModel.fromJson(json['User']) : null);

  Map<String, dynamic> toJson() => {
        "id": id,
        "storeName": storeName == null ? null : storeName,
        "storeDesc": storeDesc == null ? null : storeDesc,
        "storeURL": storeUrl == null ? null : storeUrl,
        "ownerName": ownerName == null ? null : ownerName,
        "status": status,
        "visibility": visibility,
        "rating": rating,
        "stripeCustomerId": stripeCustomerId == null ? null : stripeCustomerId,
        "phone": phone == null ? null : phone,
        "premium": premium,
        "membership": membership,
        "createdAt": createdAt!.toIso8601String(),
        "userId": userId == null ? null : userId,
        "updatedAt": updatedAt == null ? null : updatedAt!.toIso8601String(),
      };
}
