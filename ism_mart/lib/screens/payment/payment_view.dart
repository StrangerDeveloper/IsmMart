import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ism_mart/screens/payment/payment_viewmodel.dart';
import 'package:ism_mart/helper/languages/translations_key.dart' as langKey;
import 'package:ism_mart/widgets/custom_appbar.dart';
import 'package:ism_mart/widgets/loader_view.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentView extends StatelessWidget {
  PaymentView({
    super.key,
    required this.orderId,
    required this.amount,
    required this.currencyCode,
  });
  final int? orderId;
  final double? amount;
  final String? currencyCode;

  final PaymentViewModel viewModel = Get.put(PaymentViewModel());

  @override
  Widget build(BuildContext context) {
    viewModel.webViewController.reload();
    viewModel.orderId(orderId);
    viewModel.amount(amount);
    viewModel.currencyCode(currencyCode);

    return Scaffold(
      backgroundColor: Colors.grey[100]!,
      appBar: CustomAppBar(
        title: langKey.checkout.tr,
        elevation: 0.5,
      ),
      body: Stack(
        children: [
          WebViewWidget(
            controller: viewModel.webViewController,
          ),
          LoaderView(),
        ],
      ),
    );
  }
}
