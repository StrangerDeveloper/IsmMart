import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:ism_mart/helper/routes.dart';

import '../../firebase_options.dart';

class NotificationHelper {
  //NotificationHelper._();
  final CHANNEL_GROUP_KEY = "ismmart_group";
  final CHANNEL_KEY = "ismmart_channel";
  final DEFAULT_CHANNEL_NAME = "ismmart Notification";

  initFirebase() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  checkIfNotifAllowed() {
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
  }

  initNotification() {
    //checkIfNotifAllowed();
    AwesomeNotifications().initialize(
        null,
        [
          NotificationChannel(
            channelGroupKey: CHANNEL_GROUP_KEY,
            channelKey: CHANNEL_KEY,
            channelName: DEFAULT_CHANNEL_NAME,
            channelDescription: 'Notification channel for basic tests',
            importance: NotificationImportance.Max,
            //defaultColor: kPrimaryColor,
            //ledColor: kWhiteColor,
          )
        ],
        debug: true);
  }

  onActionReceived() async {
    ReceivedAction? receivedAction = await AwesomeNotifications()
        .getInitialNotificationAction(removeFromActionEvents: false);
    if (receivedAction?.channelKey == CHANNEL_KEY)
      Get.toNamed(Routes.shopifyWebView);
    else
      Get.toNamed(Routes.shopifyWebView);
  }
}
