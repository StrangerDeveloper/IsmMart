import 'package:ism_mart/api_helper/export_api_helper.dart';
import 'package:ism_mart/models/exports_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:http_parser/http_parser.dart';

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

  Future<ApiResponse> resendVerificationLink({email}) async {
    var response = await _authRepo.resendVerificationLink(email: email);

    return ApiResponse.fromJson(response);
  }

  Future<UserResponse> addBankAccount({token, SellerModel? sellerModel}) async {
    var jsonData = {
      "accountTitle": '${sellerModel!.accountTitle}',
      "accountNumber": '${sellerModel.accountNumber}',
      "bankName": '${sellerModel.bankName}',
    };
    var response = await _authRepo.registerStore(token: token, data: jsonData);
    return UserResponse.fromResponse(response);
  }

  Future<UserResponse> getCurrentUser({String? token}) async {
    var response = await _authRepo.fetchCurrentUser(token: token);
    // debugPrint("UserResponse: ${response}");
    return UserResponse.fromResponse(response);
  }

  Future<UserResponse> updateUser({token, title, value, field}) async {
    var headers = {'authorization': '$token', 'Cookie': 'XSRF-token=$token'};
    var request = http.MultipartRequest(
        'PATCH', Uri.parse('${ApiConstant.baseUrl}user/update'));
    if (field.contains("image")) {
      print(">>>Caled...");
      request.files.add(await http.MultipartFile.fromPath(
        '$field',
        value,
        contentType: MediaType.parse('image/jpeg'),
      ));
    } else
      request.fields.addAll({'$field': value.toString()});
    request.headers.addAll(headers);
    http.StreamedResponse response =
        await handleStreamResponse(await request.send());

    return UserResponse.fromResponse(
        json.decode(await response.stream.bytesToString()));
  }

  /*
  *
  * Shipping address CRUD
  * */

  Future<List<UserModel>> getShippingAddress({token}) async {
    var response = await _authRepo.getShippingDetails(token: token);
    return response.map((data) => UserModel.fromJson(data)).toList();
  }

  Future<UserModel> getDefaultShippingAddress({token}) async {
    var response = await _authRepo.getDefaultShippingDetails(token: token);
    return UserModel.fromJson(response);
  }

  Future<ApiResponse> changeDefaultAddress({token, addressId}) async {
    var response = await _authRepo.changeDefaultShippingAddress(
        token: token, addressId: addressId);
    return ApiResponse.fromJson(response);
  }

  Future<ApiResponse> addShippingAddress({UserModel? userModel}) async {
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
    return ApiResponse.fromJson(response);
  }

  Future<ApiResponse> updateShippingAddress(
      {int? addressId, UserModel? userModel}) async {
    Map<String, dynamic> jsonData = {
      "id": "${userModel?.id}",
      "name": "${userModel?.name}",
      "address": "${userModel?.address}",
      "phoneNumber": "${userModel?.phone}",
      "zipCode": "${userModel?.zipCode}",
      "countryId": "${userModel?.country!.id}",
      "cityId": "${userModel?.city!.id}"
    };
    var response = await _authRepo.updateShippingDetails(
        token: userModel?.token, data: jsonData);
    return ApiResponse.fromJson(response);
  }

  Future<ApiResponse> deleteShippingAddress({token, addressID}) async {
    var response =
        await _authRepo.deleteShippingDetails(token: token, id: addressID);
    return ApiResponse.fromJson(response);
  }

  /**
   *
   * Contact US
   *
   * */

  Future<ApiResponse> contactUs({data}) async {
    var response = await _authRepo.postContactUs(data: data);
    return ApiResponse.fromJson(response);
  }

  /**
  *
  *  Coins Api
  *
  * */

  Future<ApiResponse> getUserCoins({token}) async {
    var response = await _authRepo.fetchUserCoins(token: token);
    return ApiResponse.fromJson(response);
  }
}
