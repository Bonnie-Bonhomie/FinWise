
import 'package:data_boot/firebase_options.dart';
import 'package:data_boot/utils/Helpers/life_cycle_helper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'Services/local_notify_services.dart';
import 'app.dart';
import 'dependencies/depend_injection.dart';
import 'utils/Helpers/dismiss_keyboard.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // await FirebaseMsgService().initFCM();

  await LocalNotificationService.instance.initialize();

  listenToTokenRefresh();

  DependencyInjection.init();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
      statusBarColor: Colors.transparent,
    ),
  );

  runApp(AppLifeCycleHelper(
    child: DismissKeyboard(
      child: const MyApp(),
    ),
  ));
}
