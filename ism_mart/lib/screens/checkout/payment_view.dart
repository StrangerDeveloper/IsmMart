import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ism_mart/exports/export_presentation.dart';
import 'package:ism_mart/screens/checkout/payment_viewmodel.dart';
import 'package:ism_mart/utils/constants.dart';
import 'package:ism_mart/utils/languages/translations_key.dart' as langKey;
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
      appBar: _appBar(),
      body: WebViewWidget(
        controller: viewModel.webViewController,
      ),
    );
  }
}

AppBar _appBar() {
  return AppBar(
    elevation: 0,
    backgroundColor: kAppBarColor,
    leading: InkWell(
      onTap: () => Get.back(),
      child: Icon(
        Icons.arrow_back_ios_new,
        size: 18,
        color: kPrimaryColor,
      ),
    ),
    title: CustomText(title: langKey.checkout.tr, style: appBarTitleSize),
  );
}
