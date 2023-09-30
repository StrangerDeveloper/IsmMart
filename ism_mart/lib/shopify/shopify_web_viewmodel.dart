import 'dart:ui';

import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ShopifyWebViewModel extends GetxController {
  var controller;
  @override
  void onInit() {
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            // if (request.url.startsWith('https://www.youtube.com/')) {
            //   return NavigationDecision.prevent;
            // }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse('https://ismmart.com/'));

    super.onInit();
  }

  //This function will get executed when back button is pressed in webview and it will check if webview can go back or not
  Future<bool> onWillPop() async {
    if (await controller.canGoBack()) {
      controller.goBack();
      return false;
    } else {
      return true;
    }
  }
}
