import 'dart:convert';

import 'package:ism_mart/api_helper/api_service.dart';
import 'package:ism_mart/models/exports_model.dart';

List<OrderModel> orderModelFromJson(String str) =>
    List<OrderModel>.from(json.decode(str).map((x) => OrderModel.fromJson(x)));

String orderModelToJson(List<OrderModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OrderModel {
  OrderModel({
    this.id,
    this.paymentMethod,
    this.status,
    this.expectedDeliveryDate,
    this.totalPrice,
    this.shippingPrice,
    this.createdAt,
    this.updatedAt,
    this.billingDetail,
    this.vendorDetails,
    this.orderItems,
  });

  int? id;
  String? paymentMethod, status;
  num? totalPrice, shippingPrice;
  DateTime? expectedDeliveryDate, createdAt, updatedAt;
  UserModel? billingDetail, vendorDetails;
  List<OrderItem>? orderItems;

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
    id: json["id"],
    paymentMethod: json["paymentMethod"],
    status: json["status"],
    expectedDeliveryDate: json["expectedDeliveryDate"] == null
        ? null
        : DateTime.parse(json["expectedDeliveryDate"]),
    totalPrice: json["totalPrice"],
    shippingPrice: json["shippingPrice"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null
        ? null
        : DateTime.parse(json["updatedAt"]),
    billingDetail: json["BillingDetail"] == null
        ? null
        : UserModel.fromJson(json["BillingDetail"]),
    vendorDetails:
    json["User"] == null ? null : UserModel.fromJson(json["User"]),
    orderItems: json["OrderItems"] == null
        ? null
        : List<OrderItem>.from(
        json["OrderItems"].map((x) => OrderItem.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "paymentMethod": paymentMethod,
    "status": status,
    "expectedDeliveryDate": expectedDeliveryDate!.toIso8601String(),
    "totalPrice": totalPrice,
    "shippingPrice": shippingPrice,
    "createdAt": createdAt!.toIso8601String(),
    "updatedAt": updatedAt == null ? null : updatedAt!.toIso8601String(),
    "BillingDetail": billingDetail == null ? null : billingDetail!.toJson(),
    "OrderItems": orderItems == null
        ? null
        : List<dynamic>.from(orderItems!.map((x) => x.toJson())),
  };
}

class OrderItem {
  int? id;
  String? quantity;
  double? price;
  bool? reviewed;
  ProductModel? product;
  List<Tickets>? tickets;

  OrderItem(
      {this.id,
        this.quantity,
        this.price,
        this.reviewed,
        this.product,
        this.tickets});

  OrderItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantity = json['quantity'];
    price = json['price'].toDouble();
    reviewed = json['reviewed'];
    product = json['Product'] != null
        ? new ProductModel.fromJson(json['Product'])
        : null;
    if (json['Tickets'] != null) {
      tickets = <Tickets>[];
      json['Tickets'].forEach((v) {
        tickets!.add(new Tickets.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "quantity": quantity,
    "price": price,
    "reviewed": reviewed,
    "product": product!.toJson(),
    "Tickets": tickets!.map((v) => v.toJson()).toList()
  };
}

class Tickets {
  int? id;
  String? title;
  String? description;
  int? orderItemsId;
  int? userId;
  String? status;
  String? createdAt;
  String? updatedAt;

  Tickets(
      {this.id,
        this.title,
        this.description,
        this.orderItemsId,
        this.userId,
        this.status,
        this.createdAt,
        this.updatedAt});

  Tickets.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    orderItemsId = json['orderItemsId'];
    userId = json['userId'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['orderItemsId'] = this.orderItemsId;
    data['userId'] = this.userId;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class OrderResponse {
  OrderResponse({
    this.success,
    this.message,
    this.data,
  });

  bool? success;
  String? message;
  dynamic data;

  factory OrderResponse.fromJson(Map<String, dynamic> json) => OrderResponse(
      success: json["success"], message: json["message"], data: json["data"]);

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data!.toJson(),
  };
}

class OrderStats {
  OrderStats(
      {this.orderId,
        this.totalOrders,
        this.pendingOrders,
        this.activeOrders,
        this.deliveredOrders,
        this.silverCoin});

  num? orderId, totalOrders, pendingOrders;
  num? activeOrders, deliveredOrders, silverCoin;

  factory OrderStats.fromJson(JSON json) => OrderStats(
      orderId: json["orderId"],
      totalOrders: json["totalOrders"],
      pendingOrders: json["pendingOrders"],
      activeOrders: json["activeOrders"],
      deliveredOrders: json["deliveredOrders"],
      silverCoin: json['sliver']);

  JSON toJson() => {
    "orderId": orderId,
    "totalOrders": totalOrders,
    "pendingOrders": pendingOrders,
    "activeOrders": activeOrders,
    "deliveredOrders": deliveredOrders,
    "sliver": silverCoin,
  };
}

class VendorStats {
  num? totalOrders, pendingOrders, activeOrders, deliveredOrders;
  num? totalEarning, pendingAmount, cMonthEarning, goldCoin;

  VendorStats({
    this.totalOrders,
    this.pendingOrders,
    this.activeOrders,
    this.deliveredOrders,
    this.totalEarning,
    this.pendingAmount,
    this.cMonthEarning,
    this.goldCoin,
  });

  factory VendorStats.fromJson(Map<String, dynamic> json) => VendorStats(
    totalOrders: json["totalOrders"],
    pendingOrders: json["pendingOrders"],
    activeOrders: json["activeOrders"],
    deliveredOrders: json["deliveredOrders"],
    totalEarning: json["totalEarning"],
    pendingAmount: json["pendingAmount"],
    cMonthEarning: json["cmonthEarning"],
    goldCoin: json['gold'],
  );

  Map<String, dynamic> toJson() => {
    "totalOrders": totalOrders,
    "pendingOrders": pendingOrders,
    "activeOrders": activeOrders,
    "deliveredOrders": deliveredOrders,
    "totalEarning": totalEarning,
    "pendingAmount": pendingAmount,
    "cmonthEarning": cMonthEarning,
    "gold": goldCoin
  };
}

class VendorOrder {
  int? id;
  String? title;
  String? text;
  DateTime? createdAt;
  OrderModel? orderModel;

  VendorOrder({
    this.id,
    this.title,
    this.text,
    this.createdAt,
    this.orderModel,
  });

  factory VendorOrder.fromJson(Map<String, dynamic> json) => VendorOrder(
    id: json["id"],
    title: json["title"],
    text: json["text"],
    createdAt: json["createdAt"] == null
        ? null
        : DateTime.parse(json["createdAt"]),
    orderModel:
    json["Order"] == null ? null : OrderModel.fromJson(json["Order"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "text": text,
    "createdAt": createdAt?.toIso8601String(),
    "Order": orderModel?.toJson(),
  };
}
