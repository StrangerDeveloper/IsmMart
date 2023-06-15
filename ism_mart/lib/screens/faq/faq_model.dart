class FaqModel {
  int? id;
  String? questions;
  String? answer;
  String? createdAt;
  String? updatedAt;

  FaqModel(
      {this.id, this.questions, this.answer, this.createdAt, this.updatedAt});

  FaqModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    questions = json['questions'];
    answer = json['answer'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['questions'] = this.questions;
    data['answer'] = this.answer;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
