import 'package:ism_mart/api_helper/export_api_helper.dart';
import 'package:ism_mart/models/exports_model.dart';

class OrderProvider {
  final OrderRepository _orderRepo;

  OrderProvider(this._orderRepo);

  Future<OrderModel> getBuyerOrdersDetails({token, orderId}) async {
    var response = await _orderRepo.fetchBuyerOrdersDetails(
        token: token, orderId: orderId);
    return OrderModel.fromJson(response);
  }

  Future<OrderModel> getVendorOrdersDetails({token, orderId}) async {
    var response = await _orderRepo.fetchVendorOrdersDetails(
        token: token, orderId: orderId);
    return OrderModel.fromJson(response);
  }

  Future<OrderResponse> createOrder({token, data}) async {
    print(">>>CreateOrder: ${data.toString()}");
    var response = await _orderRepo.postOrder(token: token, data: data);

    return OrderResponse.fromJson(response);
  }

  Future<ApiResponse> createPaymentIntent({token, data}) async {
    var response = await _orderRepo.postPaymentIntent(token: token, data: data);
    return ApiResponse.fromJson(response);
  }

  Future<ApiResponse> createReview({token, data}) async {
    var response = await _orderRepo.postReview(token: token, data: data);
    return ApiResponse.fromJson(response);
  }
}
