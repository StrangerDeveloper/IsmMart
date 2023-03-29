class Answer {
  Answer({
    this.id,
    this.answer,
    this.vendorId,
    this.createdAt,
  });

  int? id;
  String? answer;
  int? vendorId;
  DateTime? createdAt;

  factory Answer.fromJson(Map<String, dynamic> json) => Answer(
        id: json["id"],
        answer: json["answer"],
        vendorId: json["vendorId"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "answer": answer,
        "vendorId": vendorId,
        "createdAt": createdAt?.toIso8601String(),
      };
}
