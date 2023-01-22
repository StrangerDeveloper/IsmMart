import 'package:ism_mart/models/exports_model.dart';

class QuestionModel {
  QuestionModel({
    this.id,
    this.productId,
    this.question,
    this.createdAt,
    this.user,
    this.answer,
  });

  int? id;
  int? productId;
  String? question;
  DateTime? createdAt;
  UserModel? user;
  Answer? answer;

  factory QuestionModel.fromJson(Map<String, dynamic> json) => QuestionModel(
    id: json["id"],
    productId: json["productId"],
    question: json["question"],
    createdAt: DateTime.parse(json["createdAt"]),
    user: UserModel.fromJson(json["User"]),
    answer: Answer.fromJson(json["Answer"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "productId": productId,
    "question": question,
    "createdAt": createdAt?.toIso8601String(),
    "User": user!.toJson(),
    "Answer": answer!.toJson(),
  };

}


