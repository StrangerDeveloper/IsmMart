import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:ism_mart/helper/languages/translations_key.dart' as langKey;
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

import '../helper/permission_handler_services.dart';
import 'notifications/notification_helper.dart';

class ShopifyWebViewModel extends GetxController {
  RxBool backBtn = false.obs;
  RxBool appExit = false.obs;
  late WebViewController controller;
  var loadingPercentage = 0.obs;

  final FirebaseAnalytics analytics = FirebaseAnalytics.instance;


  @override
  void onInit() {
    //NotificationHelper().checkIfNotifAllowed();

    NotificationHelper().onFirebaseMessaging();

    analytics.setAnalyticsCollectionEnabled(true);
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
            loadingPercentage.value = progress;
          },
          onPageStarted: (String url) async {
            //custom events for analytics of page visits
            final uri = Uri.parse(url);
            print("!----! URIPath: ${uri.path}");
            await analytics.logEvent(
                name: 'pages_tracked', parameters: {"page_name": uri.path});

            loadingPercentage.value = 0;
            if (url == "https://ismmart.com/") {
              backBtn.value = true;
            } else {
              backBtn.value = false;
            }
          },
          onPageFinished: (String url) {
            loadingPercentage.value = 100;
          },
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
    initFilePicker();

    super.onInit();
  }

  /// handle attachments
  initFilePicker() async {
    if (Platform.isAndroid) {
      final androidController =
          (controller.platform as AndroidWebViewController);
      await androidController.setOnShowFileSelector(_androidFilePicker);
    }

// You can can also directly ask the permission about its status.
  }

  Future<List<String>> _androidFilePicker(FileSelectorParams params) async {
    await PermissionHandlerPermissionService()
        .handleCameraPermission(Get.context!);
    try {
      if (params.mode == FileSelectorMode.openMultiple) {
        final attachments =
            await FilePicker.platform.pickFiles(allowMultiple: true);
        if (attachments == null) return [];

        return attachments.files
            .where((element) => element.path != null)
            .map((e) => File(e.path!).uri.toString())
            .toList();
      } else {
        final attachment = await FilePicker.platform.pickFiles();
        if (attachment == null) return [];
        File file = File(attachment.files.single.path!);
        return [file.uri.toString()];
      }
    } catch (e) {
      return [];
    }
  }

  //This function will get executed when back button is pressed in webview and it will check if webview can go back or not
  Future<bool> onWillPop() async {
    if (await controller.canGoBack()) {
      controller.goBack();
      return true;
    } else {
      return false;
    }
  }

  Future<bool> onBackPressed(BuildContext context) async {
    if (await controller.canGoBack()) {
      controller.goBack();
      await showDialog<bool>(
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
