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
    this.orderItems,
  });

  int? id;
  String? paymentMethod, status;
  num? totalPrice, shippingPrice;
  DateTime? expectedDeliveryDate, createdAt, updatedAt;
  UserModel? billingDetail;
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
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        billingDetail: json["BillingDetail"] == null
            ? null
            : UserModel.fromJson(json["BillingDetail"]),
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
  OrderItem({
    this.id,
    this.quantity,
    this.price,
    this.reviewed,
    this.product,
  });

  int? id;
  String? quantity;
  double? price;
  bool? reviewed;
  ProductModel? product;

  factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
        id: json["id"],
        quantity: json["quantity"],
        price: json["price"].toDouble(),
        reviewed: json["reviewed"],
        product: ProductModel.fromJson(json["Product"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "quantity": quantity,
        "price": price,
        "reviewed": reviewed,
        "Product": product!.toJson(),
      };
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
        success: json["success"],
        message: json["message"],
        data: OrderStats.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data!.toJson(),
      };
}

class OrderStats {
  OrderStats({
    this.orderId,
    this.totalOrders,
    this.pendingOrders,
    this.activeOrders,
    this.deliveredOrders,
  });

  int? orderId, totalOrders, pendingOrders;
  int? activeOrders, deliveredOrders;

  factory OrderStats.fromJson(JSON json) => OrderStats(
        orderId: json["orderId"],
        totalOrders: json["totalOrders"],
        pendingOrders: json["pendingOrders"],
        activeOrders: json["activeOrders"],
        deliveredOrders: json["deliveredOrders"],
      );

  JSON toJson() => {
        "orderId": orderId,
        "totalOrders": totalOrders,
        "pendingOrders": pendingOrders,
        "activeOrders": activeOrders,
        "deliveredOrders": deliveredOrders,
      };
}

class VendorStats {
  int? totalOrders, pendingOrders;
  int? activeOrders, deliveredOrders;
  int? totalEarning, pendingAmount;
  int? cMonthEarning;

  VendorStats({
    this.totalOrders,
    this.pendingOrders,
    this.activeOrders,
    this.deliveredOrders,
    this.totalEarning,
    this.pendingAmount,
    this.cMonthEarning,
  });

  factory VendorStats.fromJson(Map<String, dynamic> json) => VendorStats(
        totalOrders: json["totalOrders"],
        pendingOrders: json["pendingOrders"],
        activeOrders: json["activeOrders"],
        deliveredOrders: json["deliveredOrders"],
        totalEarning: json["totalEarning"],
        pendingAmount: json["pendingAmount"],
        cMonthEarning: json["cmonthEarning"],
      );

  Map<String, dynamic> toJson() => {
        "totalOrders": totalOrders,
        "pendingOrders": pendingOrders,
        "activeOrders": activeOrders,
        "deliveredOrders": deliveredOrders,
        "totalEarning": totalEarning,
        "pendingAmount": pendingAmount,
        "cmonthEarning": cMonthEarning,
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
