import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../core/resources/storage_keys.dart';
import '../utils/Helpers/share_prefer_services.dart';

class LocalNotificationService {
  LocalNotificationService._();

  static final LocalNotificationService instance = LocalNotificationService._();

  final FlutterLocalNotificationsPlugin _localNotifications =
  FlutterLocalNotificationsPlugin();

  final FirebaseMessaging msgService = FirebaseMessaging.instance;

  static const AndroidNotificationChannel _channel =
  AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    description: 'Used for important notifications.',
    importance: Importance.max,
  );

  Future<void> initialize() async {
    // Request permission
    await msgService.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false
    );
    //IOS
    await msgService.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    // Initialize local notifications
    const androidSettings =
    AndroidInitializationSettings('@mipmap/launcher_icon');
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true
    );

    const settings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _localNotifications.initialize(
      settings,
      onDidReceiveNotificationResponse: (response) {
        final payload = response.payload;
        print('Notification clicked: $payload');
      },
    );

    // Create notification channel
    await _localNotifications
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(_channel);

    // Listen for foreground messages
    FirebaseMessaging.onMessage.listen(_showNotification);

    String? token = await getFcmToken();
    if(token == null){
      return;
    }
    await SharedPreferService().saveData(PrefStoreKeys.fcmToken, token);
    // Listen when user taps notification
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      // print('Notification opened');
      // print(message.data);
    });
  }

  Future<void> _showNotification(RemoteMessage message) async {
    final notification = message.notification;

    if (notification == null) return;

    await _localNotifications.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          _channel.id,
          _channel.name,
          icon: '@drawable/ic_launcher',
          channelDescription: _channel.description,
          importance: Importance.max,
          priority: Priority.high,
        ),
        iOS: const DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true
        )
      ),
      // payload: message.data['route'],
    );
  }

  Future<String?> getFcmToken() async {

    if(Platform.isIOS){
      String? apsToken;
      while(apsToken == null){
        apsToken = await msgService.getAPNSToken();
        // print('Ios token: $apsToken');
      }
    }
    String? token = await msgService.getToken();
    await SharedPreferService().saveData(PrefStoreKeys.fcmToken, token);
    return token;
  }



}

void listenToTokenRefresh(){
  FirebaseMessaging.instance.onTokenRefresh.listen((newToken) async{
    SharedPreferService().saveData(PrefStoreKeys.fcmToken, newToken);
  });
}