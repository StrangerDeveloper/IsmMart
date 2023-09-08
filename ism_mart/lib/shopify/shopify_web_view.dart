import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ism_mart/shopify/shopify_web_viewmodel.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ShopifyWebView extends StatelessWidget {
  ShopifyWebView({super.key});
  final ShopifyWebViewModel viewModel = Get.put(ShopifyWebViewModel());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: WebViewWidget(controller: viewModel.controller),
      ),
    );
  }
}
