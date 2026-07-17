
import 'package:data_boot/utils/Helpers/life_cycle_helper.dart';
import 'package:data_boot/utils/Theme/app_theme.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'binding/initial_binding.dart';
import 'core/Routes/app_routes.dart';
import 'core/Routes/routes.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AppLifeCycleHelper(
      child: GetMaterialApp(
        // transitionDuration: Duration(milliseconds: 300),
        // defaultTransition: Transition.leftToRight,
        debugShowCheckedModeBanner: false,
        initialBinding: InitialBindings(),
        themeMode: ThemeMode.system,
        theme: BAppTheme.light,
        darkTheme: BAppTheme.dark,
        initialRoute: Routes.initRoute,
        getPages: AppRoutes.pageRoutes,
      ),
    );
  }
}

