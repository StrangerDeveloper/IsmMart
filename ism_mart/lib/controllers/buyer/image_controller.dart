import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../api_helper/local_storage/local_storage_helper.dart';
import '../../models/user/user_model.dart';
import 'package:http/http.dart' as http;

class ImageController extends GetxController {
  var editingTextController = TextEditingController();

//token
  var _currUserToken = "".obs;

  getToken() async {
    await LocalStorageHelper.getStoredUser().then((user) async {
      _currUserToken.value = user.token ?? '';
    }).onError((error, stackTrace) {
      print(">>>Token: $error, $stackTrace");
    });

    //update();
  }
  //String? get userToken => "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjQ4LCJpYW0iOiJ2ZW5kb3IiLCJ2aWQiOjQzLCJpYXQiOjE2NzgwNzY4MTE2MjcsImV4cCI6MTY3ODI0OTYxMTYyN30.eWj8W9zsP_mDBf81ho08HGmtwz8ufDpKUP2YBghyCN8";

  //user Model
  var _userModel = UserModel().obs;
  setUserModel(UserModel? userModel) => _userModel(userModel);
  UserModel? get userModel => _userModel.value;

  updateUser({title, value, field}) async {
    getToken();
    title = editingTextController.text;
    if (field == "firstName") {
      userModel!.firstName = title;
    } else if (field == "lastName") {
      userModel!.lastName = title;
    } else if (field == "phone") {
      userModel!.phone = title;
    } else if (field == "address") {
      userModel!.address = title;
    }

    if (userModel!.token != null) {
      // print(" image model token ${userModel!.token}");

      // var headers = {
      //   'authorization': 'Bearer ${_currUserToken.value}',
      //   'Cookie': 'XSRF-token=${_currUserToken.value}'
      // };
      // var request = http.MultipartRequest(
      //     'PATCH', Uri.parse('https://ismmart-api.com/api/user/update'));
      // request.fields.addAll({'firstName': 'Hasnain'});
      // request.files.add(await http.MultipartFile.fromPath(
      //     'image', '/C:/Users/Hasnain/Pictures/bottom_pic.jpeg'));
      // request.headers.addAll(headers);

      // http.StreamedResponse response = await request.send();

      // if (response.statusCode == 200) {
      //   print(await response.stream.bytesToString());
      // } else {
      //   print(response.reasonPhrase);
      // }
      Future<UserResponse> updateUser({token, title, value, field}) async {
        var data = {'$title': '$value'};
        print("title is api => field $field $title  $value");

        // var response = await _authRepo.updateUser(token: token, data: data);

        var headers = {
          'authorization': 'Bearer $token',
          'Cookie': 'XSRF-token=$token'
        };
        var request = http.MultipartRequest(
            'PATCH', Uri.parse('https://ismmart-api.com/api/user/update'));
        request.fields.addAll({'firstName': "title.toString()"});
        request.headers.addAll(headers);
        http.StreamedResponse response = await request.send();
        var res = http.Response.fromStream(response);

        // if (response.statusCode == 200) {
        //   print(await response.stream.bytesToString());
        // } else {
        //   print(response.reasonPhrase);
        // }
        return UserResponse.fromResponse(response);
      }

      // isLoading(true);
    }
  }
}
