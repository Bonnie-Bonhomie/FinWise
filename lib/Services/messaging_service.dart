
import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseMsgService{

  final msgService = FirebaseMessaging.instance;

  initFCM() async{

    await msgService.requestPermission(alert: true, sound: true, badge: true,);

    final token = await msgService.getToken();

    print('Firebase Token: $token');

    FirebaseMessaging.onBackgroundMessage(messagingHandler);
    FirebaseMessaging.onMessage.listen(messagingHandler);

  }
}

Future<void> messagingHandler(RemoteMessage message) async {

}