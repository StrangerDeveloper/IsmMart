import 'package:ism_mart/api_helper/api_service.dart';
import 'package:ism_mart/models/exports_model.dart';

class AuthRepository {
  final ApiService _apiService;

  AuthRepository(this._apiService);

  Future<List<dynamic>> getCountries() async {
    var response = await _apiService.get(endpoint: 'country');
    return response.body['data'];
  }

  Future<List<dynamic>> getCities({int? countryId}) async {
    var response = await _apiService.get(endpoint: 'city/$countryId');
    return response.body['data'];
  }

  Future<dynamic> login({email, password}) async {
    var body = {"email": email, "password": password};

    var response = await _apiService.post(
      endpoint: "auth/login",
      body: body, //UserModel(email: email, password: password).toJson(),
    );
    return response.body;
  }

  Future<dynamic> register({UserModel? userModel}) async {
    var response = await _apiService.post(
        endpoint: "auth/register", body: userModel?.toJson());
    return response.body;
  }

  Future<dynamic> resendVerificationLink({String? email}) async {
    var queryParam = {"email": email};
    var response = await _apiService.get(
        endpoint: "auth/resendVerificationLink", query: queryParam);
    return response.body;
  }

  Future<dynamic> registerStore({token, data}) async {
    var response = await _apiService.post(
        endpoint: "auth/vendor/register",
        requiresAuthToken: true,
        token: token,
        body: data);
    return response.body;
  }

  Future<List<dynamic>> getUsers() async {
    var response = await _apiService.get(endpoint: "auth/users");
    return response.body['data'];
  }

  Future<dynamic> fetchCurrentUser({String? token}) async {
    var response = await _apiService.get(
        endpoint: "user/profile", requiresAuthToken: true, token: token);
    return response.body;
  }

  Future<dynamic> forgotPassword({data}) async{
    var response = await _apiService.post(
      endpoint: "auth/forgetPassword",
      body: data,
    );
    return response.body;
  }

  Future<dynamic> recoverPasswordWithOtp({data}) async{
    var response = await _apiService.post(
      endpoint: "auth/forgetPasswordOtp",
      body: data,
    );
    return response.body;
  }



  /**
   *
   * Shipping Details of current User
   *
   * */

  Future<dynamic> addShippingDetails({String? token, data}) async {
    var response = await _apiService.post(
        endpoint: 'user/addShippingDetails',
        token: token,
        requiresAuthToken: true,
        body: data);
    return response.body;
  }

  Future<List<dynamic>> getShippingDetails({token}) async {
    var response = await _apiService.get(
        endpoint: "user/getShippingDetails", requiresAuthToken: true, token: token);
    return response.body['data'];
  }

  Future<dynamic> getDefaultShippingDetails({token}) async {
    var response = await _apiService.get(
        endpoint: "user/getDefaultShippingDetails", requiresAuthToken: true, token: token);
    return response.body['data'];
  }


  Future<dynamic> changeDefaultShippingAddress({int? addressId, token}) async {
    var response = await _apiService.get(
      endpoint: 'user/changeDefaultAddress/$addressId',
      requiresAuthToken: true,
      token: token,
    );
    return response.body;
  }


  Future<dynamic> deleteShippingDetails({token, id}) async {
    var response = await _apiService.delete(
        endpoint: 'user/deleteShippingDetails/$id', token: token, requiresAuthToken: true);
    return response.body;
  }

  Future<dynamic> updateShippingDetails({token, data}) async {
    var response = await _apiService.patch(
        endpoint: 'user/updateShippingDetails',
        body: data,
        token: token,
        requiresAuthToken: true);
    return response.body;
  }

}
