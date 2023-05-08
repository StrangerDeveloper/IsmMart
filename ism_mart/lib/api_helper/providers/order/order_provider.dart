import 'package:ism_mart/api_helper/export_api_helper.dart';
import 'package:ism_mart/models/dispute/dispute_model.dart';
import 'package:ism_mart/models/exports_model.dart';

class OrderProvider {
  final OrderRepository _orderRepo;

  OrderProvider(this._orderRepo);

  Future<List<OrderModel>> getBuyerOrders({token}) async {
    var response = await _orderRepo.fetchBuyerOrders(token: token);
    return response.map((e) => OrderModel.fromJson(e)).toList();
  }

  Future<List<VendorOrder>> getVendorOrders({token, status}) async {
    var response =
        await _orderRepo.fetchVendorOrders(token: token, status: status);
    return response.map((e) => VendorOrder.fromJson(e)).toList();
  }

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

  Future<OrderResponse> getBuyerOrderStats({token}) async {
    var response = await _orderRepo.fetchBuyerOrderStats(token: token);
    return OrderResponse.fromJson(response);
  }

  Future<OrderResponse> getVendorOrderStats({token}) async {
    var response = await _orderRepo.fetchVendorOrderStats(token: token);
    return OrderResponse.fromJson(response);
  }

  Future<OrderResponse> createOrder({token, data}) async {
    print(">>>CreateOrder: ${data.toString()}");
    var response = await _orderRepo.postOrder(token: token, data: data);

    return OrderResponse.fromJson(response);
  }

  Future<ApiResponse> createDispute(
      token, title, description, orderItemId, imagesList) async {
    var response = await _orderRepo.postDispute(
        token: token,
        title: title,
        description: description,
        orderItemId: orderItemId,
        imagesList: imagesList);
    return ApiResponse.fromJson(response);
  }

<<<<<<< Updated upstream
  Future<PaymentIntentResponse> createPaymentIntent({token, data}) async{
=======
  Future<ApiResponse> createPaymentIntent({token, data}) async {
>>>>>>> Stashed changes
    var response = await _orderRepo.postPaymentIntent(token: token, data: data);
    return ApiResponse.fromJson(response);
  }

<<<<<<< Updated upstream


=======
  Future<ApiResponse> createReview({token, data}) async {
    var response = await _orderRepo.postReview(token: token, data: data);
    return ApiResponse.fromJson(response);
  }
>>>>>>> Stashed changes
}
