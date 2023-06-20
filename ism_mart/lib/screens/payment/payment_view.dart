import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ism_mart/screens/payment/payment_viewmodel.dart';
import 'package:ism_mart/utils/languages/translations_key.dart' as langKey;
import 'package:ism_mart/widgets/custom_appbar.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentView extends StatelessWidget {
  PaymentView({
    super.key,
    required this.orderId,
    required this.amount,
  });
  final int? orderId;
  final double? amount;
  final PaymentViewModel viewModel = Get.put(PaymentViewModel());
  @override
  Widget build(BuildContext context) {
    viewModel.orderId!(orderId);
    viewModel.amount!(amount);
    return Scaffold(
      backgroundColor: Colors.grey[100]!,
      appBar: CustomAppBar(title: langKey.checkout.tr,),
      body: WebViewWidget(
        controller: viewModel.webViewController,
      ),
    );
  }
}