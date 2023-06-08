class VendorOrderModel {
  int? id;
  String? title;
  String? text;
  String? createdAt;
  Order? order;

  VendorOrderModel(
      {this.id, this.title, this.text, this.createdAt, this.order});

  VendorOrderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    text = json['text'];
    createdAt = json['createdAt'];
    order = json['Order'] != null ? new Order.fromJson(json['Order']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['text'] = this.text;
    data['createdAt'] = this.createdAt;
    if (this.order != null) {
      data['Order'] = this.order!.toJson();
    }
    return data;
  }
}

class Order {
  int? id;
  String? paymentMethod;
  String? status;
  String? expectedDeliveryDate;
  int? totalPrice;
  int? shippingPrice;
  int? redeemedCoins;
  String? createdAt;

  Order(
      {this.id,
        this.paymentMethod,
        this.status,
        this.expectedDeliveryDate,
        this.totalPrice,
        this.shippingPrice,
        this.redeemedCoins,
        this.createdAt});

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    paymentMethod = json['paymentMethod'];
    status = json['status'];
    expectedDeliveryDate = json['expectedDeliveryDate'];
    totalPrice = json['totalPrice'];
    shippingPrice = json['shippingPrice'];
    redeemedCoins = json['redeemedCoins'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['paymentMethod'] = this.paymentMethod;
    data['status'] = this.status;
    data['expectedDeliveryDate'] = this.expectedDeliveryDate;
    data['totalPrice'] = this.totalPrice;
    data['shippingPrice'] = this.shippingPrice;
    data['redeemedCoins'] = this.redeemedCoins;
    data['createdAt'] = this.createdAt;
    return data;
  }
}
