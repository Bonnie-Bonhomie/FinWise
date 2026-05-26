
import 'package:fin_wise/binding/initial_binding.dart';
import 'package:fin_wise/core/Routes/app_routes.dart';
import 'package:fin_wise/utils/Helpers/life_cycle_helper.dart';
import 'package:fin_wise/utils/Theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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

