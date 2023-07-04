import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ism_mart/screens/payment/payment_viewmodel.dart';
import 'package:ism_mart/helper/languages/translations_key.dart' as langKey;
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
    print("hasnain html page ${orderId} payment $amount ");
    viewModel.webViewController.reload();
    viewModel.orderId(orderId);
    viewModel.amount(amount);

    print(
        "hasnain html page after value assign ${viewModel.orderId.value} payment ${viewModel.amount.value}");
    return Scaffold(
      backgroundColor: Colors.grey[100]!,
      appBar: CustomAppBar(
        title: langKey.checkout.tr,
      ),
      body: WebViewWidget(
        controller: viewModel.webViewController,
      ),
    );
  }
}
