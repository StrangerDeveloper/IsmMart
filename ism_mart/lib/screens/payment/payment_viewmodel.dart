import 'dart:convert';

import 'package:get/get.dart';
//import 'package:webview_flutter/webview_flutter.dart';
import '../../api_helper/api_constant.dart';
import '../../controllers/controllers.dart';
import '../../helper/constants.dart';
import '../../helper/urls.dart';
import '../checkout/checkout_viewmodel.dart';
import 'package:http/http.dart' as http;
import 'package:ism_mart/helper/languages/translations_key.dart' as langKey;

class PaymentViewModel extends GetxController {
  final CheckoutViewModel viewModel = Get.put(CheckoutViewModel());
  //late WebViewController webViewController;

  RxInt orderId = 0.obs;
  RxDouble amount = (0.0).obs;
  RxString currencyCode = "Rs".obs;
  RxInt no = 0.obs;
  testMethod() {
    no.value++;
  }

  @override
  void onInit() {
    orderId.value = viewModel.orderId.value;
    amount.value = viewModel.totalAmount.value;
    print("hasnain totalAmount => ${viewModel.totalAmount.value}");

    super.onInit();
    //webViewController = WebViewController();
  }

//Update order status

  void updateOrderStatus(status) async {
    print("hasnain current order id is ==> ${orderId.value}  status  $status");

    var headers = {
      'authorization': 'Bearer ${authController.userToken}',
      'Content-Type': 'application/json',
      'Cookie': 'XSRF-token=${authController.userToken}'
    };
    var request = await http.Request(
        'PATCH', Uri.parse('${ApiConstant.baseUrl}${Urls.updateOrderStatus}'));
    request.body =
        await json.encode({"id": orderId.value, "status": "$status"});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    var res = await http.Response.fromStream(response);
    var data = jsonDecode(res.body);
    print("hasnain $data");
    if (response.statusCode == 200) {
      AppConstant.displaySnackBar(
          langKey.successTitle.tr, "Payment Successful");
      print(await response.stream.bytesToString());
    } else {
      AppConstant.displaySnackBar(
          langKey.errorTitle.tr, "Payment Failed try Again");
      print(response.reasonPhrase);
    }
  }

//create order id api   /api/order/createOrder

  // getProductQuestions() async {
  //   await ApiBaseHelper()
  //       .getMethod(url: 'product/questions/${productModel.value.id}')
  //       .then((value) {
  //     if (value['success'] == true && value['data'] != null) {
  //       productQuestions.clear();
  //       var data = value['data'] as List;
  //       productQuestions.addAll(data.map((e) => QuestionModel.fromJson(e)));
  //     }
  //   }).catchError((e) {
  //     AppConstant.displaySnackBar(langKey.errorTitle.tr, e.toString());
  //   });
}

//InAapp WebView

