import 'package:fin_wise/app.dart';
import 'package:fin_wise/dependencies/depend_injection.dart';
import 'package:fin_wise/utils/Helpers/dismiss_keyboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();

  DependencyInjection.init();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
        statusBarColor: Colors.transparent,
      )
  );
    print('App Started');

  runApp(
    DismissKeyboard(child: const MyApp())
  );
}
