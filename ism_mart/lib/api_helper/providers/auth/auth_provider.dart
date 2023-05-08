import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
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

  Future<ApiResponse> postRegister({UserModel? userModel}) async {
    var response = await _authRepo.register(userModel: userModel);
    return ApiResponse.fromJson(response);
  }

  Future<ApiResponse> resendVerificationLink({email}) async {
    var response = await _authRepo.resendVerificationLink(email: email);

    return ApiResponse.fromJson(response);
  }

  Future<ApiResponse> postStoreRegister(
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

    if(sellerModel.storeImage!.isNotEmpty) {
      request.files.add(await http.MultipartFile.fromPath(
        'storeImage',
        sellerModel.storeImage!,
        contentType: MediaType.parse('image/jpeg'),
      ));
    }else {
      request.fields['storeImage'] = sellerModel.storeName!;
    }
if(sellerModel.coverImage!.isNotEmpty){
      request.files.add(await http.MultipartFile.fromPath(
        'coverImage',
        sellerModel.coverImage!,
        contentType: MediaType.parse('image/jpeg'),
      ));
    }else{
  request.fields['coverImage'] = sellerModel.coverImage!;
    }
    final response = await request.send();
    if (response.statusCode == 200) {
      final responseData = await response.stream.bytesToString();
      final data = json.decode(responseData);
      return ApiResponse.fromJson(data);
    } else {
      //TODO: Still needs to test this one properly
      http.StreamedResponse res = handleStreamResponse(response);
<<<<<<< Updated upstream
      return UserResponse.fromResponse(json.decode(await res.stream.bytesToString()));
      throw Exception('Failed to upload image');
=======
      return ApiResponse.fromJson(
          json.decode(await res.stream.bytesToString()));
>>>>>>> Stashed changes
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

  Future<ApiResponse> addBankAccount({token, SellerModel? sellerModel}) async {
    var jsonData = {
      "accountTitle": '${sellerModel!.accountTitle}',
      "accountNumber": '${sellerModel.accountNumber}',
      "bankName": '${sellerModel.bankName}',
    };
    var response = await _authRepo.registerStore(token: token, data: jsonData);
    return ApiResponse.fromJson(response);
  }

  Future<ApiResponse> getCurrentUser({String? token}) async {
    var response = await _authRepo.fetchCurrentUser(token: token);
    debugPrint("UserResponse: ${response}");
    return ApiResponse.fromJson(response);
  }

  Future<UserResponse> updateUser({token, title, value}) async {
    var data = {'$title': '$value'};
<<<<<<< Updated upstream
    var response = await _authRepo.updateUser(token: token, data: data);
=======
    print("title is api => field $field $title  $value");

    // var response = await _authRepo.updateUser(token: token, data: data);
    var headers = {
      'authorization': 'Bearer $token',
      'Cookie': 'XSRF-token=$token'
    };
    var request = http.MultipartRequest(
        'PATCH', Uri.parse('https://ismmart-api.com/api/user/update'));
    request.fields.addAll({'$field': title.toString()});

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    var res = http.Response.fromStream(response);

    // if (response.statusCode == 200) {
    //   print(await response.stream.bytesToString());
    // } else {
    //   print(response.reasonPhrase);
    // }
>>>>>>> Stashed changes
    return UserResponse.fromResponse(response);
  }

  Future<ApiResponse> deActivateUser({token}) async {
    var response = await _authRepo.deActivateUserAccount(token: token);
    return ApiResponse.fromJson(response);
  }

  Future<ApiResponse> forgotPassword({data}) async {
    var response = await _authRepo.forgotPassword(data: data);
    return ApiResponse.fromJson(response);
  }

  Future<ApiResponse> forgotPasswordOtp({data}) async {
    var response = await _authRepo.recoverPasswordWithOtp(data: data);
    return ApiResponse.fromJson(response);
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

<<<<<<< Updated upstream
  Future<CoinsResponse> getUserCoins({token})async{
=======
  Future<ApiResponse> getUserCoins({token}) async {
>>>>>>> Stashed changes
    var response = await _authRepo.fetchUserCoins(token: token);
    return ApiResponse.fromJson(response);
  }
}
