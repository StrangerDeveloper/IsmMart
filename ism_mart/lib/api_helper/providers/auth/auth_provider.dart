import 'package:flutter/foundation.dart';
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

  Future<UserResponse> postStoreRegister(
      {token, SellerModel? sellerModel, bool? calledForUpdate = false}) async {
    final url = "${ApiConstant.baseUrl}auth/vendor/register";
    final request = http.MultipartRequest('POST', Uri.parse(url));
    request.headers['Authorization'] = '$token';
    request.headers['Content-Type'] = 'multipart/form-data';

    request.fields['storeName'] = sellerModel!.storeName!;
    request.fields['storeDesc'] = sellerModel.storeDesc!;
    request.fields['phone'] = sellerModel.phone!;
    request.fields['ownerName'] = sellerModel.ownerName!;
    request.fields['premium'] = sellerModel.premium!.toString();
    request.fields['membership'] = sellerModel.membership!;
    request.fields['accountTitle'] = sellerModel.accountTitle!;
    request.fields['accountNumber'] = sellerModel.accountNumber!;
    request.fields['bankName'] = sellerModel.bankName!;

    if (sellerModel.storeImage!.isNotEmpty) {
      request.files.add(await http.MultipartFile.fromPath(
        'storeImage',
        sellerModel.storeImage!,
        contentType: MediaType.parse('image/jpeg'),
      ));
    } else {
      request.fields['storeImage'] = sellerModel.storeName!;
    }
    if (sellerModel.coverImage!.isNotEmpty) {
      request.files.add(await http.MultipartFile.fromPath(
        'coverImage',
        sellerModel.coverImage!,
        contentType: MediaType.parse('image/jpeg'),
      ));
    } else {
      request.fields['coverImage'] = sellerModel.coverImage!;
    }
    final response = await request.send();
    if (response.statusCode == 200) {
      final responseData = await response.stream.bytesToString();
      final data = json.decode(responseData);
      return UserResponse.fromResponse(data);
    } else {
      //ODO: Still needs to test this one properly
      http.StreamedResponse res = handleStreamResponse(response);
      return UserResponse.fromResponse(
          json.decode(await res.stream.bytesToString()));
    }

    /* var jsonData = {
      "phone": phone,
      "storeName": storeName,
      "storeDesc": storeDesc,
      'ownerName': ownerName,
      'storeURL': websiteUrl
    };

    var response = await _authRepo.registerStore(token: token, data: jsonData);
    return UserResponse.fromResponse(response);*/
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
    debugPrint("UserResponse: ${response}");
    return UserResponse.fromResponse(response);
  }

  Future<UserResponse> updateUser({token, title, value}) async {
    var data = {'$title': '$value'};
    var response = await _authRepo.updateUser(token: token, data: data);
    return UserResponse.fromResponse(response);
  }

  Future<UserResponse> deActivateUser({token}) async {
    var response = await _authRepo.deActivateUserAccount(token: token);
    return UserResponse.fromResponse(response);
  }

  Future<UserResponse> forgotPassword({data}) async {
    var response = await _authRepo.forgotPassword(data: data);
    return UserResponse.fromResponse(response);
  }

  Future<UserResponse> forgotPasswordOtp({data}) async {
    var response = await _authRepo.recoverPasswordWithOtp(data: data);
    return UserResponse.fromResponse(response);
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
    return UserResponse.fromResponse(response);
  }

  Future<UserResponse> deleteShippingAddress({token, addressID}) async {
    var response =
        await _authRepo.deleteShippingDetails(token: token, id: addressID);
    return UserResponse.fromResponse(response);
  }

  /**
   *
   * Contact US
   *
   * */

  Future<UserResponse> contactUs({data}) async {
    var response = await _authRepo.postContactUs(data: data);
    return UserResponse.fromResponse(response);
  }

  /**
  *
  *  Coins Api
  *
  * */

  Future<CoinsResponse> getUserCoins({token}) async {
    var response = await _authRepo.fetchUserCoins(token: token);
    return CoinsResponse.fromJson(response);
  }
}
