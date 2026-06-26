import 'dart:io';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:fin_wise/core/resources/storage_keys.dart';
import 'package:fin_wise/firebase_options.dart';
import 'package:fin_wise/utils/Helpers/share_prefer_services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseMsgService {
  final msgService = FirebaseMessaging.instance;

  initFCM() async {
    await msgService.requestPermission(alert: true, sound: true, badge: true,);
    String channelKey = 'basic_channel';

    await AwesomeNotifications().initialize('resource://drawable/res_notification_logo', [
      NotificationChannel(
        channelKey: channelKey,
        channelName: 'Basic Notifications',
        channelDescription: 'Notification channel',
        importance: NotificationImportance.Max,
      ),
    ]);

    await AwesomeNotifications().isNotificationAllowed().then((
      isAllowed,
    ) async {
      if (!isAllowed) {
        await AwesomeNotifications().requestPermissionToSendNotifications(
        );

      }
    });

    if(Platform.isIOS){
      String? apsToken;
      while(apsToken == null){
        apsToken = await msgService.getAPNSToken();
        print('Ios token: $apsToken');
      }
    }


    final token = await msgService.getToken();

    await SharedPreferService().saveData(PrefStoreKeys.fcmToken, token);

    FirebaseMessaging.onBackgroundMessage(backMessagingHandler);
    FirebaseMessaging.onMessage.listen(foreMessagingHandler);
    AwesomeNotifications().setListeners(
      onActionReceivedMethod: onActionReceived,
    );
  }

  @pragma('vm:entry-point')
  static Future<void> onActionReceived(ReceivedAction action) async {
    print(action.payload);
  }
}

String channelKey = 'basic_channel';

Future<void> foreMessagingHandler(RemoteMessage message) async {
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: DateTime.now().millisecond,
      channelKey: channelKey,
      title: message.notification?.title,
      body: message.notification?.body,

      //   payload: {
      //     'screen': message.data['screen'],
      //     'productReference': message.data['productReference']
      // }
    ),
  );
}

@pragma('vm:entry-point')
Future<void> backMessagingHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: DateTime.now().millisecond,
      channelKey: channelKey,
      title: message.notification?.title,
      body: message.notification?.body,
    ),
  );
}


void listenToTokenRefresh(){
  FirebaseMessaging.instance.onTokenRefresh.listen((newToken) async{
    SharedPreferService().saveData(PrefStoreKeys.fcmToken, newToken);
  });
}