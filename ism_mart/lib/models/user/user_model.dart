import 'dart:convert';
import 'package:get/get.dart';
import 'package:ism_mart/api_helper/api_service.dart';
import 'package:ism_mart/exports/exports_model.dart';

import 'package:ism_mart/helper/languages/translations_key.dart' as langKey;

List<UserModel> userModelFromJson(String str) =>
    List<UserModel>.from(json.decode(str).map((x) => UserModel.fromJson(x)));

String userModelToJson(List<UserModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserModel {
  UserModel({
    this.id,
    this.firstName,
    this.lastName,
    this.token,
    this.email,
    this.address,
    this.phone,
    this.password,
    this.role,
    this.emailVerified,
    this.createdAt,
    this.updatedAt,
    this.error,
    this.country,
    this.city,
    this.countryId,
    this.cityId,
    this.zipCode,
    this.infoCompleted,
    this.defaultAddress = false,
    this.name,
    this.imageUrl,
    this.vendor,
  });

  int? id, countryId, cityId, infoCompleted;
  String? firstName, lastName, name, email, token;
  String? address, phone, password, zipCode;
  String? role, imageUrl;
  bool? emailVerified, defaultAddress;
  DateTime? createdAt, updatedAt;
  CountryModel? country, city;
  String? error, message;
  SellerModel? vendor;

  factory UserModel.fromErrorJson(json) => UserModel(error: json);

  factory UserModel.fromJson(JSON json) => UserModel(
        id: json["id"] ?? null,
        firstName: json["firstName"] ?? "",
        lastName: json["lastName"] ?? "",
        name: json['name'] == null ? null : json['name'],
        email: json["email"],
        token: json['token'],
        address: json["address"] == null ? null : json["address"],
        phone: json["phone"] == null
            ? json["phoneNumber"] == null
                ? null
                : json["phoneNumber"]
            : json["phone"],
        imageUrl: json['image'] == null ? "" : json['image'],
        password: json["password"],
        role: json["role"],
        emailVerified: json["email_verified"],
        infoCompleted: json["infoCompleted"],
        city: json["City"] == null ? null : CountryModel.fromJson(json["City"]),
        country: json["Country"] == null
            ? null
            : CountryModel.fromJson(json["Country"]),
        vendor: json['Vendor'] != null
            ? SellerModel.fromJson(json['Vendor'])
            : null,
        zipCode: json['zipCode'] == null ? null : json['zipCode'],
        defaultAddress: json['default'] == null ? false : json['default'],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
      );

  JSON toJson() => {
        "id": id,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "token": token,
        "address": address == null ? null : address,
        "phone": phone,
        "password": password,
        "role": role,
        "country": country?.toJson(),
        "city": city?.toJson(),
        "infoCompleted": infoCompleted,
        "email_verified": emailVerified,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        'Vendor': vendor?.toJson()
      };

  JSON toTokenJson() => {
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "token": token,
      };

  JSON toAddressJson() => {
        "id": id,
        "name": name,
        "phoneNumber": phone,
        "address": address,
        "zipCode": zipCode,
        "default": defaultAddress,
        "Country": country?.toJson(),
        "City": city?.toJson(),
      };
}

class UserResponse {
  bool? success, key;
  String? message, error;
  UserModel? userModel;
  List<String>? errors;

  UserResponse(
      {this.success = false,
      this.key,
      this.message,
      this.error,
      this.errors,
      this.userModel});

  factory UserResponse.fromResponse(response) {
    // print(">>Body: ${response.toString()}");
    String? message = "";
    if (response['message'] == null) {
      message = langKey.someThingWentWrong.tr;
    } else if (response['message'] is List<dynamic>) {
      message = (response['message'] as List).first;
    } else {
      message = response['message'];
    }
    return UserResponse(
        success: response['success'] == null ? false : response['success'],
        message: message,
        error: response['error'],
        errors: response['errors'] != null
            ? List<String>.from(response["errors"].map((x) => x))
            : null,
        userModel: response['data'] == null ||
                response['data'] is String ||
                response['data'] is List
            ? null
            : UserModel.fromJson(response['data']));
  }
}