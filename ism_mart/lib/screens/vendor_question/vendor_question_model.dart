class VendorQuestionModel {
  int? id;
  String? question;
  int? userId;
  String? createdAt;
  Product? product;
  User? user;
  Answer? answer;

  VendorQuestionModel(
      {this.id,
        this.question,
        this.userId,
        this.createdAt,
        this.product,
        this.user,
        this.answer});

  VendorQuestionModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    question = json['question'];
    userId = json['userId'];
    createdAt = json['createdAt'];
    product =
    json['Product'] != null ? new Product.fromJson(json['Product']) : null;
    user = json['User'] != null ? new User.fromJson(json['User']) : null;
    answer =
    json['Answer'] != null ? new Answer.fromJson(json['Answer']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['question'] = this.question;
    data['userId'] = this.userId;
    data['createdAt'] = this.createdAt;
    if (this.product != null) {
      data['Product'] = this.product!.toJson();
    }
    if (this.user != null) {
      data['User'] = this.user!.toJson();
    }
    if (this.answer != null) {
      data['Answer'] = this.answer!.toJson();
    }
    return data;
  }
}

class Product {
  int? id;
  String? name;
  String? thumbnail;

  Product({this.id, this.name, this.thumbnail});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    thumbnail = json['thumbnail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['thumbnail'] = this.thumbnail;
    return data;
  }
}

class User {
  int? id;
  String? firstName;
  String? lastName;

  User({this.id, this.firstName, this.lastName});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    return data;
  }
}

class Answer {
  int? id;
  String? answer;
  int? vendorId;
  String? createdAt;

  Answer({this.id, this.answer, this.vendorId, this.createdAt});

  Answer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    answer = json['answer'];
    vendorId = json['vendorId'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['answer'] = this.answer;
    data['vendorId'] = this.vendorId;
    data['createdAt'] = this.createdAt;
    return data;
  }
}
