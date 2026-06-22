import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:fin_wise/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseMsgService {
  final msgService = FirebaseMessaging.instance;

  initFCM() async {
    // await msgService.requestPermission(alert: true, sound: true, badge: true,);
    await AwesomeNotifications().initialize(null, [
      NotificationChannel(
        channelKey: 'basic_channel',
        channelName: 'Basic Notifications',
        channelDescription: 'Notification channel',
        importance: NotificationImportance.Max,
      ),
    ]);

    await AwesomeNotifications().isNotificationAllowed().then((
      isAllowed,
    ) async {
      if (!isAllowed) {
        await AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });

    final token = await msgService.getToken();

    print('Firebase Token: $token');

    FirebaseMessaging.onBackgroundMessage(backMessagingHandler);
    FirebaseMessaging.onMessage.listen(foreMessagingHandler);
    AwesomeNotifications().setListeners(onActionReceivedMethod: onActionReceived);
  }

  @pragma('vm:entry-point')
  static Future<void> onActionReceived(ReceivedAction action) async{
    print(action.payload);
  }
}

Future<void> foreMessagingHandler(RemoteMessage message) async {
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: DateTime.now().millisecond,
      channelKey: 'basic_channel',
      title: message.notification?.title,
      body: message.notification?.body,


    ),
  );
}

@pragma('vm:entry-point')
Future<void> backMessagingHandler(RemoteMessage message) async {

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );

  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: DateTime.now().millisecond,
      channelKey: 'basic_channel',
      title: message.notification?.title,
      body: message.notification?.body,
    ),
  );
}
