import 'dart:convert';

FaqResponse faqModelFromJson(String str) => FaqResponse.fromJson(json.decode(str));

String faqModelToJson(FaqResponse data) => json.encode(data.toJson());

class FaqResponse {
  FaqResponse({
    this.success,
    this.message,
    this.data,
  });

  bool? success;
  String? message;
  List<FAQModel>? data;

  factory FaqResponse.fromJson(Map<String, dynamic> json) => FaqResponse(
    success: json["success"],
    message: json["message"],
    data: List<FAQModel>.from(json["data"].map((x) => FAQModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class FAQModel {
  FAQModel({
    this.id,
    this.questions,
    this.answer,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? questions, answer;
  DateTime? createdAt, updatedAt;

  factory FAQModel.fromJson(Map<String, dynamic> json) => FAQModel(
    id: json["id"],
    questions: json["questions"],
    answer: json["answer"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "questions": questions,
    "answer": answer,
    "createdAt": createdAt!.toIso8601String(),
    "updatedAt": updatedAt!.toIso8601String(),
  };
}
