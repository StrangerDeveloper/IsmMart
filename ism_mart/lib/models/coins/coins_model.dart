// class CoinsResponse {
//   CoinsResponse({
//     this.success,
//     this.message,
//     this.coinsModel,
//   });

//   bool? success;
//   String? message;
//   CoinsModel? coinsModel;

//   factory CoinsResponse.fromJson(Map<String, dynamic> json) => CoinsResponse(
//         success: json["success"],
//         message: json["message"],
//         coinsModel:
//             json["data"] == null ? null : CoinsModel.fromJson(json["data"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "success": success,
//         "message": message,
//         "data": coinsModel?.toJson(),
//       };
// }

class CoinsModel {
  CoinsModel({
    this.id,
    this.userId,
    this.vendorId,
    this.gold,
    this.silver,
    this.createdAt,
    this.updatedAt,
  });

  int? id, userId, vendorId;
  num? gold, silver;
  DateTime? createdAt, updatedAt;

  factory CoinsModel.fromJson(Map<String, dynamic> json) => CoinsModel(
        id: json["id"],
        userId: json["userId"],
        vendorId: json["vendorId"],
        gold: json["gold"],
        silver: json["silver"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "vendorId": vendorId,
        "gold": gold,
        "silver": silver,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}
