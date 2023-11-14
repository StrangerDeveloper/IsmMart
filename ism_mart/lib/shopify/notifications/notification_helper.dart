import 'dart:math';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
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

  Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    await Firebase.initializeApp();
    print('Handling a background message ${message.messageId}');
    print(message.data);
    // flutterLocalNotificationsPlugin.show(
    //     message.data.hashCode,
    //     message.data['title'],
    //     message.data['body'],
    //     NotificationDetails(
    //       android: AndroidNotificationDetails(
    //         channel.id,
    //         channel.name,
    //         channel.description,
    //       ),
    //     ));

    triggerNotification(
        title: message.data['title'], body: message.data['body'], image: message.data['image']);
  }

  onFirebaseMessaging(){
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      triggerNotification(
          title: message.data['title'], body: message.data['body'], image: message.data['image']);
    });
  }

  triggerNotification({title, body, image}) {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: Random().nextInt(1000),
        actionType: ActionType.Default,
        channelKey: CHANNEL_KEY,
        notificationLayout: NotificationLayout.BigPicture,
        roundedBigPicture: true,
        bigPicture: image,
        title: title,
        body: body),
    );
  }



  initNotification() {
    //checkIfNotifAllowed();
    initFirebase();
    AwesomeNotifications().initialize(
        null,
        [
          NotificationChannel(
            channelGroupKey: CHANNEL_GROUP_KEY,
            channelKey: CHANNEL_KEY,
            channelName: DEFAULT_CHANNEL_NAME,
            channelDescription: 'This channel is used for important notifications.',
            importance: NotificationImportance.Max,
            //defaultColor: kPrimaryColor,
            //ledColor: kWhiteColor,
          )
        ],
        debug: true);

    _getUserToken();
  }

  onActionReceived() async {
    ReceivedAction? receivedAction = await AwesomeNotifications()
        .getInitialNotificationAction(removeFromActionEvents: false);
    if (receivedAction?.channelKey == CHANNEL_KEY)
      Get.toNamed(Routes.shopifyWebView);
    else
      Get.toNamed(Routes.shopifyWebView);
  }


   _getUserToken() async{
   await FirebaseMessaging.instance.getToken().then((token) async{
     print("UserToken:  $token");

     await FirebaseMessaging.instance
         .subscribeToTopic("ismmart-ads").then((value) => print("Subscribed to: ismmart-ads through $token"));
   });
  }


}
