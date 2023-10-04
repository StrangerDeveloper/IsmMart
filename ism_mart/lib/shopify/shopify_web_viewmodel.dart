import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:ism_mart/helper/languages/translations_key.dart' as langKey;

class ShopifyWebViewModel extends GetxController {
  RxBool backBtn = false.obs;
  RxBool appExit = false.obs;
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
          onPageStarted: (String url) {
            print("home---------- $url");

            if (url == "https://ismmart.com/") {
              backBtn.value = true;
            } else {
              backBtn.value = false;
            }
          },
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
      return true;
      ;
    } else {
      return false;
    }
  }

  Future<bool> onBackPressed(BuildContext context) async {
    if (await controller.canGoBack()) {
      controller.goBack();
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
                        Get.back();
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
                      },
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      );

      return true;
    } else {
      return false;
    }
  }
}
