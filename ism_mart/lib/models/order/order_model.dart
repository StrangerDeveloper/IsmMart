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
  int? totalPrice, shippingPrice;
  DateTime? expectedDeliveryDate, createdAt, updatedAt;
  UserModel? billingDetail;
  List<OrderItem>? orderItems;

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        id: json["id"],
        paymentMethod: json["paymentMethod"],
        status: json["status"],
        expectedDeliveryDate: DateTime.parse(json["expectedDeliveryDate"]),
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
  OrderStats? data;

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
    this.completedOrders,
  });

  int? orderId, totalOrders, pendingOrders;
  int? activeOrders,completedOrders;

  factory OrderStats.fromJson(JSON json) => OrderStats(
    orderId: json["orderId"],
    totalOrders: json["totalOrders"],
    pendingOrders: json["pendingOrders"],
    activeOrders: json["activeOrders"],
    completedOrders: json["completedOrders"],
  );

  JSON toJson() => {
    "orderId": orderId,
    "totalOrders": totalOrders,
    "pendingOrders": pendingOrders,
    "activeOrders": activeOrders,
    "completedOrders": completedOrders,
  };
}

