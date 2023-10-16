import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ism_mart/helper/languages/translations_key.dart' as langKey;
import 'package:ism_mart/shopify/shopify_web_viewmodel.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ShopifyWebView extends StatelessWidget {
  ShopifyWebView({super.key});
  final ShopifyWebViewModel viewModel = Get.put(ShopifyWebViewModel());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          if (await viewModel.controller.canGoBack()) {
            viewModel.controller.goBack();

            return false;
          } else if (viewModel.backBtn.value == true) {
            final value = await showDialog<bool>(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text(langKey.exitApp.tr),
                  content: Text(langKey.exitDialogDesc.tr),
                  actions: [
                    Row(
                      children: [
                        Expanded(
                          child: TextButton(
                            style: TextButton.styleFrom(
                              minimumSize: Size(double.infinity, 40),
                              foregroundColor: Colors.grey,
                            ),
                            child: Text(
                              langKey.noBtn.tr,
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop(true);
                              viewModel.appExit.value = false;
                            },
                          ),
                        ),
                        Expanded(
                          child: TextButton(
                            style: TextButton.styleFrom(
                              minimumSize: Size(double.infinity, 40),
                              foregroundColor: Colors.grey,
                            ),
                            child: Text(
                              langKey.yesBtn.tr,
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop(true);
                              viewModel.appExit.value = true;
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            );
            return viewModel.appExit.value;
          } else {
            return false;
          }
        },
        //viewModel.onWillPop,
        //callback when back button is pressed
        child: Scaffold(
          body: Stack(
            children: [
              WebViewWidget(controller: viewModel.controller),
              Obx(() => viewModel.loadingPercentage.value < 100
                  ? LinearProgressIndicator(
                      value: viewModel.loadingPercentage.value / 100.0,
                      //color: Colors.black54,
                    )
                  : Container()),
            ],
          ),
        ),
      ),
    );
  }
}
