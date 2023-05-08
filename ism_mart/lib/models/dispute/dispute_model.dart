// class DisputeResponse {
//   bool? success;
//   String? message;
//   dynamic data;

//   DisputeResponse({this.success, this.message, this.data});

//   factory DisputeResponse.fromJson(Map<String, dynamic> json) =>
//       DisputeResponse(
//           success: json["success"],
//           message: json["message"]);

//   Map<String, dynamic> toJson() => {
//         "success": success,
//         "message": message,
//       };
// }

class DisputeModel {
  DisputeModel({
    this.id,
    this.title,
    this.description,
    this.orderItemsId,
    this.userId,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  int? id, orderItemsId, userId;
  String? title, description, status;
  DateTime? createdAt, updatedAt;

  factory DisputeModel.fromJson(Map<String, dynamic> json) => DisputeModel(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        orderItemsId: json["orderItemsId"],
        userId: json["userId"],
        status: json["status"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "orderItemsId": orderItemsId,
        "userId": userId,
        "status": status,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}
