import 'package:flutter/foundation.dart';
import 'package:ism_mart/api_helper/export_api_helper.dart';
import 'package:ism_mart/models/exports_model.dart';

class AuthProvider {
  final AuthRepository _authRepo;

  AuthProvider(this._authRepo);

  Future<List<CountryModel>> getCountries() async {
    var response = await _authRepo.getCountries();
    return response.map((e) => CountryModel.fromJson(e)).toList();
  }

  Future<List<CountryModel>> getCities({int? countryId}) async {
    var response = await _authRepo.getCities(countryId: countryId);
    return response.map((e) => CountryModel.fromJson(e)).toList();
  }

  Future<UserResponse> postLogin({email, password}) async {
    var response = await _authRepo.login(email: email, password: password);
    return UserResponse.fromResponse(response);
  }

  Future<UserResponse> postRegister({UserModel? userModel}) async {
    var response = await _authRepo.register(userModel: userModel);
    return UserResponse.fromResponse(response);
  }

  Future<UserResponse> resendVerificationLink({email}) async {
    var response = await _authRepo.resendVerificationLink(email: email);

    return UserResponse.fromResponse(response);
  }

  Future<UserResponse> postStoreRegister({token, storeName, storeDesc}) async {
    var response = await _authRepo.registerStore(
        token: token, data: {"storeName": storeName, "storeDesc": storeDesc});
    return UserResponse.fromResponse(response);
  }

  Future<UserResponse> getCurrentUser({String? token}) async {
    var response = await _authRepo.fetchCurrentUser(token: token);
    debugPrint("UserResponse: ${response}");
    return UserResponse.fromResponse(response);
  }

  /*
  *
  * Shipping address CRUD
  * */

  Future<List<UserModel>> getShippingAddress({token}) async {
    var response = await _authRepo.getShippingDetails(token: token);
    return response
        .map((data) => data != null ? UserModel.fromJson(data) : UserModel())
        .toList();
  }

  Future<UserModel> getDefaultShippingAddress({token}) async {
    var response = await _authRepo.getDefaultShippingDetails(token: token);
    return UserModel.fromJson(response);
  }

  Future<UserResponse> changeDefaultAddress({token, addressId}) async {
    var response = await _authRepo.changeDefaultShippingAddress(
        token: token, addressId: addressId);
    return UserResponse.fromResponse(response);
  }

  Future<UserResponse> addShippingAddress({UserModel? userModel}) async {
    Map<String, dynamic> jsonData = {
      "name": "${userModel?.name}",
      "address": "${userModel?.address}",
      "phoneNumber": "${userModel?.phone}",
      "zipCode": "${userModel?.zipCode}",
      "countryId": userModel?.countryId,
      "cityId": userModel?.cityId
    };
    var response = await _authRepo.addShippingDetails(
        token: userModel?.token, data: jsonData);
    return UserResponse.fromResponse(response);
  }

  Future<UserResponse> updateShippingAddress(
      {int? addressId, UserModel? userModel}) async {
    Map<String, dynamic> jsonData = {
      "id": addressId,
      "name": "${userModel?.name}",
      "address": "${userModel?.address}",
      "phoneNumber": "${userModel?.phone}",
      "zipCode": "${userModel?.zipCode}",
      "countryId": userModel?.countryId,
      "cityId": userModel?.cityId
    };
    var response = await _authRepo.updateShippingDetails(
        token: userModel?.token, data: jsonData);
    return UserResponse.fromResponse(response);
  }

  Future<UserResponse> deleteShippingAddress({token, addressID}) async {
    var response =
        await _authRepo.deleteShippingDetails(token: token, id: addressID);
    return UserResponse.fromResponse(response);
  }
}
