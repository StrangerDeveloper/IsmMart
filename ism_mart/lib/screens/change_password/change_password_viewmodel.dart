import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ism_mart/api_helper/api_constant.dart';
import 'package:ism_mart/models/api_response/api_response_model.dart';
import '../../api_helper/local_storage/local_storage_helper.dart';
import '../../models/user/user_model.dart';
import 'package:http/http.dart' as http;

class ChangePasswordViewModel extends GetxController {


  var currentPasswordController = TextEditingController();
  var newPasswordController = TextEditingController();
  var confirmPasswordController = TextEditingController();

  final changePasswordFormKey = GlobalKey<FormState>();

  var passwordNotMatched = false.obs;

  var currentPasswordIconVisibility = true.obs;
  var newPasswordIconVisibility = true.obs;
  var confirmPasswordIconVisibility = true.obs;

  @override
  void onClose(){
    clearControllers();
    super.onClose();
  }

  changeIcon(RxBool Icon) {
    Icon.value = !Icon.value;
  }

  Future<dynamic> updatePassword({String? email}) async {
    final UserModel userDetails = await LocalStorageHelper.getStoredUser();

    var url=ApiConstant.baseUrl;
    var headers = {
      'Content-Type': 'application/json',
      'Cookie': 'XSRF-token=${userDetails.token}'
    };
    var request = http.Request('PATCH', Uri.parse('$url/user/updatePassword'));
    request.body = json.encode({
      "email": "${userDetails.email}",
      "password": newPasswordController.text.trim().toString(),
      "confirmPassword": confirmPasswordController.text.trim().toString(),
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    var data = await http.Response.fromStream(response);
    var res = jsonDecode(data.body);

    if (response.statusCode == 200) {
      return ApiResponse.fromJson(res);
    }
  }

  clearControllers(){
    currentPasswordController.clear();
    newPasswordController.clear();
    confirmPasswordController.clear();
  }
}