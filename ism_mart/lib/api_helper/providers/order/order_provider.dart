import 'package:ism_mart/api_helper/export_api_helper.dart';
import 'package:ism_mart/models/exports_model.dart';

class OrderProvider {
  final OrderRepository _orderRepo;

  OrderProvider(this._orderRepo);


  Future<List<OrderModel>> getBuyerOrders({token}) async {
    var response = await _orderRepo.fetchBuyerOrders(token: token);
    return response.map((e) => OrderModel.fromJson(e)).toList();
  }
  Future<List<OrderModel>> getVendorOrders({token, status}) async {
    var response = await _orderRepo.fetchVendorOrders(token: token, status: status);
    return response.map((e) => OrderModel.fromJson(e)).toList();
  }



  Future<OrderModel> getMyOrdersDetails({token, orderId}) async {
    var response = await _orderRepo.fetchMyOrdersDetails( token: token, orderId: orderId);
    return OrderModel.fromJson(response);
  }

  Future<OrderResponse> getOrderStats({token}) async{
    var response = await _orderRepo.fetchOrderStats(token: token);
    return OrderResponse.fromJson(response);
  }


  Future<OrderResponse> createOrder({token, data})async{
    var response = await _orderRepo.postOrder(token: token, data: data);
    return OrderResponse.fromJson(response);
  }


}
