import 'package:ism_mart/api_helper/export_api_helper.dart';

import 'user_model.dart';

class SellerModel {
  /* "phone": "+923435995776",
  "storeName": "wehire",
  "storeDesc": "Software House",
  "storeURL": "https://www.google.com",
  "ownerName": "Moiz-Ur-Rehman"*/

  int? id;
  String? storeName, storeDescription, storeUrl;
  UserModel? user;

  SellerModel({this.id, this.storeName, this.storeDescription, this.storeUrl, this.user});

  factory SellerModel.fromJson(JSON? json) => SellerModel(
        id: json?['id'],
        storeName: json?['storeName'],
        storeDescription: json?['storeDesc']??"",
        storeUrl: json?['storeURL']??"",
        user: json?['User']!=null ? UserModel.fromJson(json?['User']) : null
      );
}
