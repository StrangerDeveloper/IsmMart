import 'dart:convert';

import 'package:ism_mart/api_helper/api_service.dart';
import 'package:ism_mart/models/exports_model.dart';

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
    this.attempt,
    this.loggedOutAt,
    this.gender,
    this.emailVerified,
    this.stripeCustomerId,
    this.createdAt,
    this.updatedAt,
    this.error,
    this.country,
    this.city,
    this.countryId,
    this.cityId,
    this.zipCode,
    this.defaultAddress = false,
    this.name,
    this.imageUrl,
  });

  int? id, attempt, countryId, cityId;
  String? firstName, lastName, name, email, token;
  String? address, phone, password, zipCode;
  String? role, gender, stripeCustomerId, imageUrl;
  bool? emailVerified, defaultAddress;
  DateTime? createdAt, loggedOutAt, updatedAt;
  CountryModel? country, city;

  String? error, message;

  factory UserModel.fromErrorJson(json) => UserModel(error: json);

  factory UserModel.fromJson(JSON json) => UserModel(
        id: json["id"],
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
        attempt: json["attempt"] == null ? null : json["attempt"],
        loggedOutAt: json["loggedOutAt"],
        gender: json["gender"],
        emailVerified: json["email_verified"],
        stripeCustomerId: json["stripeCustomerId"],
        country: json["Country"] == null
            ? null
            : CountryModel.fromJson(json["Country"]),
        city: json["City"] == null ? null : CountryModel.fromJson(json["City"]),
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
        "attempt": attempt == null ? null : attempt,
        "loggedOutAt": loggedOutAt,
        "gender": gender,
        "email_verified": emailVerified,
        "stripeCustomerId": stripeCustomerId,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}

/*UserResponse userResponseFromApi(Response? jsonResponse){
  if(jsonResponse.hasError)
  return UserResponse.fromResponse(jsonResponse);
}*/

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
    return UserResponse(
        success: response['success'] == null ? false : response['success'],
        message: response['message'] ?? "Something went wrong",
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
