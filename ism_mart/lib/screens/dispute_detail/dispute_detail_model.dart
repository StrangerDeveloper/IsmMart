class DisputeDetailModel {
  int? id;
  String? title;
  String? description;
  String? status;
  List<TicketImages>? ticketImages;

  DisputeDetailModel(
      {this.id, this.title, this.description, this.status, this.ticketImages});

  DisputeDetailModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    status = json['status'];
    if (json['TicketImages'] != null) {
      ticketImages = <TicketImages>[];
      json['TicketImages'].forEach((v) {
        ticketImages!.add(new TicketImages.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['status'] = this.status;
    if (this.ticketImages != null) {
      data['TicketImages'] = this.ticketImages!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TicketImages {
  String? url;

  TicketImages({this.url});

  TicketImages.fromJson(Map<String, dynamic> json) {
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    return data;
  }
}
