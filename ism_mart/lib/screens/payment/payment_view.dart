import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:ism_mart/screens/deals/deals_view.dart';
import 'package:ism_mart/screens/payment/payment_viewmodel.dart';
import 'package:ism_mart/helper/languages/translations_key.dart' as langKey;
import 'package:ism_mart/widgets/custom_appbar.dart';

class PaymentView extends StatefulWidget {
  PaymentView({
    super.key,
    required this.orderId,
    required this.amount,
    required this.currencyCode,
  });
  final int? orderId;
  final double? amount;
  final String? currencyCode;

  @override
  State<PaymentView> createState() => _PaymentViewState();
}

class _PaymentViewState extends State<PaymentView> {
  final PaymentViewModel viewModel = Get.put(PaymentViewModel());

  //webview
  final GlobalKey webViewKey = GlobalKey();

  InAppWebViewController? webViewController;

  @override
  Widget build(BuildContext context) {
    viewModel.webViewController.reload();
    // viewModel.orderId(orderId);
    // viewModel.amount(amount);
    viewModel.currencyCode(widget.currencyCode);

    return Scaffold(
        backgroundColor: Colors.grey[100]!,
        appBar: CustomAppBar(
          backBtn: false,
          menuItem: true,
          action: [
            Container(
              height: 100,
              width: 100,
              color: Colors.black,
              child: ElevatedButton(
                  onPressed: () {
                    Get.off(DealsView());
                  },
                  child: Text("Deals")),
            ),
          ],
          title: langKey.checkout.tr,
          elevation: 0.5,
        ),
        body: Column(children: <Widget>[
          Expanded(
            child: InAppWebView(
              key: webViewKey,
              initialData:
                  InAppWebViewInitialData(data: viewModel.paymentHtml()),
              onWebViewCreated: (controller) {
                webViewController = controller;

                controller.addJavaScriptHandler(
                    handlerName: 'saveFormData',
                    callback: (arguments) {
                      final Map<String, dynamic> formData = arguments[0];
                      Get.off(DealsView());
                      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      //   content: Text(jsonEncode(formData)),
                      //   duration: const Duration(seconds: 1),
                      // ));
                    });
              },
            ),
          ),
        ])

//       body: Stack(
//         children: [
//           WebViewWidget(
// InAppWebView()

//         //    controller: viewModel.webViewController,

//           ),
//           LoaderView(),
//         ],
//       ),
        );
  }
}
