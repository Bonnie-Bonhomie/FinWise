import 'package:fin_wise/Services/messaging_service.dart';
import 'package:fin_wise/app.dart';
import 'package:fin_wise/dependencies/depend_injection.dart';
import 'package:fin_wise/firebase_options.dart';
import 'package:fin_wise/utils/Helpers/dismiss_keyboard.dart';
import 'package:fin_wise/utils/Helpers/life_cycle_helper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await FirebaseMsgService().initFCM();

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

  runApp(DismissKeyboard(child: AppLifeCycleHelper(child: const MyApp())));
}
