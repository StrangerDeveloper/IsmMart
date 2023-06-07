import 'package:ism_mart/api_helper/api_service.dart';

class AuthRepository {
  final ApiService _apiService;

  AuthRepository(this._apiService);

  Future<List<dynamic>> getCountries() async {
    var response = await _apiService.get(endpoint: 'country');
    return response.body != null ? response.body['data'] : [];
  }

  Future<List<dynamic>> getCities({int? countryId}) async {
    var response = await _apiService.get(endpoint: 'city/$countryId');
    return response.body != null ? response.body['data'] : [];
  }

  Future<dynamic> login({email, password}) async {
    var body = {"email": email, "password": password};

    var response = await _apiService.post(
      endpoint: "auth/login",
      body: body, //UserModel(email: email, password: password).toJson(),
    );
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
    return response.body != null ? response.body['data'] : [];
  }

  Future<dynamic> updateUser({token, data}) async {
    var response = await _apiService.patch(
        endpoint: 'user/update',
        body: data,
        token: token,
        requiresAuthToken: true);

    return response.body;
  }

  Future<dynamic> fetchCurrentUser({String? token}) async {
    var response = await _apiService.get(
        endpoint: "user/profile", requiresAuthToken: true, token: token);
    return response.body;
  }

  Future<dynamic> recoverPasswordWithOtp({data}) async {
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
        endpoint: "user/getShippingDetails?limit=3",
        requiresAuthToken: true,
        token: token);
    return response.body != null ? response.body['data'] : [];
  }

  Future<dynamic> getDefaultShippingDetails({token}) async {
    var response = await _apiService.get(
        endpoint: "user/getDefaultShippingDetails",
        requiresAuthToken: true,
        token: token);
    return response.body != null ? response.body['data'] : null;
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
    var response = await _apiService.patch(
        endpoint: 'user/deleteShippingDetails/$id',
        token: token,
        requiresAuthToken: true);
    return response.body;
  }

  Future<dynamic> updateShippingDetails({token, data}) async {
    var response = await _apiService.put(
        endpoint: 'user/updateShippingDetails',
        body: data,
        token: token,
        requiresAuthToken: true);

    return response.body;
  }

  /**
   *
   * Contact US
   *
   * */

  Future<dynamic> postContactUs({data}) async {
    var response = await _apiService.post(endpoint: 'user/contact', body: data);
    return response.body;
  }

  ///Coins Api
  Future<dynamic> fetchUserCoins({token}) async {
    var response = await _apiService.get(
        endpoint: 'coin/getUserCoins', requiresAuthToken: true, token: token);
    return response.body;
  }
}
