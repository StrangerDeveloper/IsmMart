import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:ism_mart/api_helper/api_constant.dart';
import 'package:ism_mart/api_helper/errors.dart';
import 'package:ism_mart/api_helper/global_variables.dart';
import 'package:ism_mart/controllers/controllers.dart';
import 'package:ism_mart/widgets/getx_helper.dart';
import 'package:ism_mart/utils/languages/translations_key.dart' as langKey;

class ApiBaseHelper {
  final String _baseUrl = ApiConstant.baseUrl;
  final String token = authController.userToken!;

  // Future<dynamic> postMethod({required String url, dynamic body}) async {
  //   Map<String, String> header = {
  //     'Authorization': 'Bearer $token',
  //     'Content-Type': 'application/json'
  //   };
  //
  //   try {
  //     body = jsonEncode(body);
  //     print('*********************** Request ********************************');
  //     print(body);
  //     print(_baseUrl + url);
  //     Uri urlValue = Uri.parse(_baseUrl + url);
  //     http.Response response = await http
  //         .post(urlValue, headers: header, body: body)
  //         .timeout(Duration(seconds: 30));
  //
  //     print(response.body);
  //
  //     Map<String, dynamic> parsedJSON = jsonDecode(response.body);
  //     print(
  //         '*********************** Response **********************************');
  //     print(urlValue.toString());
  //     print('body => ' + body);
  //     print(parsedJSON);
  //     print('&&&&&&&&&&&&&&&&&&&&&&& End of Response &&&&&&&&&&&&&&&&&&&&&&\n');
  //     return parsedJSON;
  //   } on SocketException catch (_) {
  //     GlobalVariable.showLoader.value = false;
  //     //GetxHelper.showSnackBar(title: 'Error', message: Errors.noInternetError);
  //     throw Errors.noInternetError;
  //   } on TimeoutException catch (_) {
  //     GlobalVariable.showLoader.value = false;
  //     GetxHelper.showSnackBar(title: 'Error', message: Errors.timeOutException);
  //     throw Errors.timeOutException;
  //   } on FormatException catch (_) {
  //     GlobalVariable.showLoader.value = false;
  //     GetxHelper.showSnackBar(title: 'Error', message: Errors.formatException);
  //     throw Errors.formatException;
  //   } catch (e) {
  //     GlobalVariable.showLoader.value = false;
  //     GetxHelper.showSnackBar(title: 'Error', message: Errors.generalApiError);
  //     throw e.toString();
  //   }
  // }

  Future<dynamic> getMethod(
      {required String url, bool withBearer = true}) async {
    Map<String, String> header = {
      'Authorization': withBearer ? 'Bearer $token' : token,
      'Content-Type': 'application/json'
    };

    try {
      Uri urlValue = Uri.parse(_baseUrl + url);
      print(urlValue);
      http.Response response = await http
          .get(urlValue, headers: header)
          .timeout(Duration(seconds: 50));

      Map<String, dynamic> parsedJSON = jsonDecode(response.body);
      print(
          '*********************** Response **********************************');
      print(urlValue.toString());
      print(parsedJSON);
      print('&&&&&&&&&&&&&&&&&&&&&&& End of Response &&&&&&&&&&&&&&&&&&&&&&\n');
      return parsedJSON;
    } on SocketException {
      GlobalVariable.showLoader.value = false;
      GetxHelper.showSnackBar(
          title: langKey.errorTitle.tr, message: Errors.noInternetError);
      throw Errors.noInternetError;
    } on TimeoutException {
      GlobalVariable.showLoader.value = false;
      GetxHelper.showSnackBar(
          title: langKey.errorTitle.tr, message: Errors.timeOutException);
      throw Errors.timeOutException + url;
    } catch (e) {
      GlobalVariable.showLoader.value = false;
      print(e);
      GetxHelper.showSnackBar(
          title: langKey.errorTitle.tr, message: e.toString());
      throw e.toString();
    }
  }

  Future<dynamic> deleteMethod(
      {required String url, bool withBearer = true}) async {
    print('hayat');
    print(token);

    Map<String, String> header = {
      'Authorization': withBearer ? 'Bearer $token' : token,
      'Content-Type': 'application/json'
    };

    try {
      Uri urlValue = Uri.parse(_baseUrl + url);
      print(urlValue);
      http.Response response = await http
          .delete(urlValue, headers: header)
          .timeout(Duration(seconds: 50));

      Map<String, dynamic> parsedJSON = jsonDecode(response.body);
      print(
          '*********************** Response **********************************');
      print(urlValue.toString());
      print(parsedJSON);
      print('&&&&&&&&&&&&&&&&&&&&&&& End of Response &&&&&&&&&&&&&&&&&&&&&&\n');
      return parsedJSON;
    } on SocketException {
      GlobalVariable.showLoader.value = false;
      GetxHelper.showSnackBar(
          title: langKey.errorTitle.tr, message: Errors.noInternetError);
      throw Errors.noInternetError;
    } on TimeoutException {
      GlobalVariable.showLoader.value = false;
      GetxHelper.showSnackBar(
          title: langKey.errorTitle.tr, message: Errors.timeOutException);
      throw Errors.timeOutException + url;
    } catch (e) {
      GlobalVariable.showLoader.value = false;
      print(e);
      GetxHelper.showSnackBar(
          title: langKey.errorTitle.tr, message: e.toString());
      throw e.toString();
    }
  }

  Future<dynamic> postMethodForImage(
      {required String url,
      required List<http.MultipartFile> files,
      required Map<String, String> fields}) async {
    try {
      Uri urlValue = Uri.parse(_baseUrl + url);
      http.MultipartRequest request = http.MultipartRequest('POST', urlValue);
      Map<String, String> header = {
        'authorization': token,
        'Content-Type': 'multipart/form-data'
      };
      request.headers.addAll(header);
      request.fields.addAll(fields);
      request.files.addAll(files);
      http.StreamedResponse response = await request.send();
      Map<String, dynamic> parsedJson =
          await jsonDecode(await response.stream.bytesToString());

      print('********************** Response ********************************');
      print(urlValue.toString());
      print(parsedJson.toString());
      print('&&&&&&&&&&&&&&&&&&&&&&& End of Response &&&&&&&&&&&&&&&&&&&&&&\n');
      return parsedJson;
    } on SocketException catch (_) {
      GlobalVariable.showLoader.value = false;
      //GetxHelper.showSnackBar(title: 'Error', message: Errors.noInternetError);
      throw Errors.noInternetError;
    } on TimeoutException catch (_) {
      GlobalVariable.showLoader.value = false;
      GetxHelper.showSnackBar(title: 'Error', message: Errors.timeOutException);
      throw Errors.timeOutException;
    } on FormatException catch (_) {
      GlobalVariable.showLoader.value = false;
      GetxHelper.showSnackBar(title: 'Error', message: Errors.formatException);
      throw Errors.formatException;
    } catch (e) {
      GlobalVariable.showLoader.value = false;
      GetxHelper.showSnackBar(title: 'Error', message: Errors.generalApiError);
      throw e.toString();
    }
  }
}
