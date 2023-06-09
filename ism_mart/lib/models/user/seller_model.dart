import 'package:ism_mart/api_helper/export_api_helper.dart';
import 'user_model.dart';

class SellerModelResponse {
  SellerModelResponse({
    this.totalProducts,
    this.totalCustomers,
    this.vendorStore,
  });

  int? totalProducts;
  int? totalCustomers;
  SellerModel? vendorStore;

  factory SellerModelResponse.fromJson(Map<String, dynamic> json) =>
      SellerModelResponse(
        totalProducts: json["totalProducts"],
        totalCustomers: json["totalCustomers"],
        vendorStore: json["vendorStore"] == null
            ? null
            : SellerModel.fromJson(json["vendorStore"]),
      );

  Map<String, dynamic> toJson() => {
    "totalProducts": totalProducts,
    "totalCustomers": totalCustomers,
    "vendorStore": vendorStore?.toJson(),
  };
}

class SellerModel {
  int? id, userId, cityId;
  String? storeName, storeDesc, storeUrl, cityName;
  String? ownerName, status, visibility, address;
  num? rating;
  String? stripeCustomerId, phone, membership;
  bool? premium;
  DateTime? createdAt, updatedAt;
  UserModel? user;
  String? bankName, accountTitle, accountNumber;
  String? storeImage, coverImage, totalSold;

  SellerModel({
    this.id,
    this.storeName,
    this.storeDesc,
    this.cityName,
    this.storeUrl,
    this.ownerName,
    this.cityId,
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
    this.accountNumber,
    this.accountTitle,
    this.bankName,
    this.coverImage,
    this.storeImage,
    this.address,
    this.user,
    this.totalSold});

  factory SellerModel.fromJson(JSON json) => SellerModel(
        id: json["id"],
        storeName: json["storeName"] == null ? null : json["storeName"],
        cityName: json["cityName"] == null ? null : json["cityName"],
        cityId: json["cityId"] == null ? null : json["cityId"],
        storeDesc: json["storeDesc"] == null ? null : json["storeDesc"],
        storeUrl: json["storeURL"] == null ? null : json["storeURL"],
        ownerName: json["ownerName"] == null ? null : json["ownerName"],
        status: json["status"],
        visibility: json["visibility"],
        rating: json["rating"] == null ? 0.0 : json["rating"],
        stripeCustomerId:
        json["stripeCustomerId"] == null ? null : json["stripeCustomerId"],
        phone: json["phone"] == null ? null : json["phone"],
        premium: json["premium"],
        membership: json["membership"],
        createdAt:
        json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        userId: json["userId"] == null ? null : json["userId"],
        updatedAt:
        json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        address: json["address"] == null ? null : json["updatedAt"],
        bankName: json["bankName"],
        accountTitle: json["accountTitle"],
        accountNumber: json["accountNumber"],
        storeImage: json["storeImage"],
        coverImage: json["coverImage"],
        totalSold: json["totalSold"],
        user: json['User'] != null ? UserModel.fromJson(json['User']) : null);

  JSON toJson() => {
        "id": id,
        "storeName": storeName == null ? null : storeName,
        "cityName": cityName == null ? null : cityName,
        "cityId": cityId == null ? null : cityId,
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
        "bankName": bankName,
        "accountTitle": accountTitle,
        "accountNumber": accountNumber,
        "storeImage": storeImage,
        "coverImage": coverImage,
        "updatedAt": updatedAt == null ? null : updatedAt!.toIso8601String(),
      };
}