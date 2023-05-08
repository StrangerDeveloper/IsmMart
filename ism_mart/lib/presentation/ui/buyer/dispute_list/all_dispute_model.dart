class AllDisputeModel {
  int? id;
  String? title;
  String? description;
  String? status;

  AllDisputeModel({this.id, this.title, this.description, this.status});

  AllDisputeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['status'] = this.status;
    return data;
  }
}