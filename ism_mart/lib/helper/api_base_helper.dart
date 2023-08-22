import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:ism_mart/api_helper/api_constant.dart';
import 'package:ism_mart/helper/errors.dart';
import 'package:ism_mart/helper/global_variables.dart';
import 'package:ism_mart/controllers/controllers.dart';
import 'package:ism_mart/helper/languages/translations_key.dart' as langKey;
import 'package:ism_mart/widgets/getx_helper.dart';
import 'constants.dart';

class ApiBaseHelper {
  final String _baseUrl = ApiConstant.baseUrl;
  final String token = authController.userToken!;

  Future<dynamic> postMethod({
    required String url,
    Object? body,
    bool withBearer = false,
    bool withAuthorization = false,
  }) async {
    try {
      Map<String, String> header = {'Content-Type': 'application/json'};
      if (withAuthorization) {
        header['Authorization'] = withBearer ? 'Bearer $token' : token;
      }
      if (body != null) {
        body = jsonEncode(body);
      }
      Uri urlValue = Uri.parse(_baseUrl + url);
      print('*********************** Request ********************************');
      print(urlValue);
      print(body);

      http.Response response = await http
          .post(urlValue, headers: header, body: body)
          .timeout(Duration(seconds: 30));

      print(
          '*********************** Response ********************************');
      print(urlValue);
      print(response.body);
      AppConstant.colorConsole(
          '****************************************************************************************');

      Map<String, dynamic> parsedJSON = jsonDecode(response.body);
      return parsedJSON;
    } on SocketException catch (_) {
      GlobalVariable.showLoader.value = false;
      // GetxHelper.showSnackBar(title: 'Error', message: Errors.noInternetError);
    //  throw Errors.noInternetError;
      GlobalVariable.internetErr(true);
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

  Future<dynamic> putMethod({
    required String url,
    Object? body,
    bool withBearer = false,
    bool withAuthorization = false,
  }) async {
    try {
      Map<String, String> header = {'Content-Type': 'application/json'};
      if (withAuthorization) {
        header['Authorization'] = withBearer ? 'Bearer $token' : token;
      }
      if (body != null) {
        body = jsonEncode(body);
      }
      Uri urlValue = Uri.parse(_baseUrl + url);
      print('*********************** Request ********************************');
      print(urlValue);
      print(body);

      http.Response response = await http
          .put(urlValue, headers: header, body: body)
          .timeout(Duration(seconds: 30));

      print(
          '*********************** Response ********************************');
      print(urlValue);
      print(response.body);
      AppConstant.colorConsole(
          '****************************************************************************************');

      Map<String, dynamic> parsedJSON = jsonDecode(response.body);
      return parsedJSON;
    } on SocketException catch (_) {
      GlobalVariable.showLoader.value = false;
      // GetxHelper.showSnackBar(title: 'Error', message: Errors.noInternetError);
      GlobalVariable.internetErr(true);
      //throw Errors.noInternetError;
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

  Future<dynamic> patchMethod({
    required String url,
    Object? body,
    bool withBearer = false,
    bool withAuthorization = false,
  }) async {
    try {
      Map<String, String> header = {'Content-Type': 'application/json'};
      if (withAuthorization) {
        header['Authorization'] = withBearer ? 'Bearer $token' : token;
      }
      if (body != null) {
        body = jsonEncode(body);
      }
      Uri urlValue = Uri.parse(_baseUrl + url);
      print('*********************** Request ********************************');
      print(urlValue);
      print(body);

      http.Response response = await http
          .patch(urlValue, headers: header, body: body)
          .timeout(Duration(seconds: 30));

      print(
          '*********************** Response ********************************');
      print(urlValue);
      print(response.body);
      AppConstant.colorConsole(
          '****************************************************************************************');

      Map<String, dynamic> parsedJSON = jsonDecode(response.body);
      return parsedJSON;
    } on SocketException catch (_) {
      GlobalVariable.showLoader.value = false;
      GlobalVariable.internetErr(true);
      //  GetxHelper.showSnackBar(title: 'Error', message: Errors.noInternetError);
    //  throw Errors.noInternetError;
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

  Future<dynamic> getMethod({
    required String url,
    bool withBearer = false,
    bool withAuthorization = false,
  }) async {
    try {
      Map<String, String> header = {
        'Content-Type': 'application/json',
        'Cookie': 'XSRF-token=$token'
      };
      if (withAuthorization) {
        header['Authorization'] = withBearer ? 'Bearer $token' : token;
      }
      Uri urlValue = Uri.parse(_baseUrl + url);
      print('*********************** Request ********************************');
      print(urlValue);

      http.Response response = await http
          .get(urlValue, headers: header)
          .timeout(Duration(seconds: 50));

      print(
          '*********************** Response ********************************');
      print(urlValue);
      print(response.body);
      AppConstant.colorConsole(
          '****************************************************************************************');

      Map<String, dynamic> parsedJSON = jsonDecode(response.body);
      return parsedJSON;
    } on SocketException {
      GlobalVariable.showLoader.value = false;
      GlobalVariable.internetErr(true);
      //  GetxHelper.showSnackBar(title: langKey.errorTitle.tr, message: Errors.noInternetError);
    //  throw Errors.noInternetError;
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

  Future<dynamic> deleteMethod({
    required String url,
    bool withBearer = false,
    bool withAuthorization = false,
  }) async {
    try {
      Map<String, String> header = {'Content-Type': 'application/json'};
      if (withAuthorization) {
        header['Authorization'] = withBearer ? 'Bearer $token' : token;
      }
      Uri urlValue = Uri.parse(_baseUrl + url);
      print('*********************** Request ********************************');
      print(urlValue);

      http.Response response = await http
          .delete(urlValue, headers: header)
          .timeout(Duration(seconds: 50));

      print(
          '*********************** Response ********************************');
      print(urlValue);
      print(response.body);
      AppConstant.colorConsole(
          '****************************************************************************************');
      Map<String, dynamic> parsedJSON = jsonDecode(response.body);
      return parsedJSON;
    } on SocketException {
      GlobalVariable.showLoader.value = false;
      GlobalVariable.internetErr(true);
      // GetxHelper.showSnackBar(title: langKey.errorTitle.tr, message: Errors.noInternetError);
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

  Future<dynamic> postMethodForImage({
    required String url,
    required List<http.MultipartFile> files,
    required Map<String, String> fields,
    bool withBearer = false,
    bool withAuthorization = false,
  }) async {
    try {
      Map<String, String> header = {'Content-Type': 'multipart/form-data'};
      if (withAuthorization) {
        header['Authorization'] = withBearer ? 'Bearer $token' : token;
      }
      Uri urlValue = Uri.parse(_baseUrl + url);
      print('*********************** Request ********************************');
      print(urlValue);

      http.MultipartRequest request = http.MultipartRequest('POST', urlValue);
      request.headers.addAll(header);
      request.fields.addAll(fields);
      request.files.addAll(files);
      http.StreamedResponse response = await request.send();
      Map<String, dynamic> parsedJson =
          await jsonDecode(await response.stream.bytesToString());

      print(
          '*********************** Response ********************************');
      print(urlValue);
      print(parsedJson.toString());
      AppConstant.colorConsole(
          '****************************************************************************************');
      return parsedJson;
    } on SocketException catch (_) {
      GlobalVariable.showLoader.value = false;
      GlobalVariable.internetErr(true);
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

  Future<dynamic> patchMethodForImage({
    required String url,
    required List<http.MultipartFile> files,
    required Map<String, String> fields,
    bool withBearer = false,
    bool withAuthorization = false,
  }) async {
    try {
      Map<String, String> header = {'Content-Type': 'multipart/form-data'};

      if (withAuthorization) {
        header['Authorization'] = withBearer ? 'Bearer $token' : token;
      }
      Uri urlValue = Uri.parse(_baseUrl + url);
      print('*********************** Request ********************************');
      print(urlValue);

      http.MultipartRequest request = http.MultipartRequest('PATCH', urlValue);

      request.headers.addAll(header);
      request.fields.addAll(fields);
      request.files.addAll(files);
      http.StreamedResponse response = await request.send();
      Map<String, dynamic> parsedJson =
          await jsonDecode(await response.stream.bytesToString());

      print(
          '*********************** Response ********************************');
      print(urlValue);
      print(parsedJson.toString());
      AppConstant.colorConsole(
          '****************************************************************************************');
      return parsedJson;
    } on SocketException catch (_) {
      GlobalVariable.showLoader.value = false;
      GlobalVariable.internetErr(true);
      //GetxHelper.showSnackBar(title: 'Error', message: Errors.noInternetError);
     // throw Errors.noInternetError;
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
