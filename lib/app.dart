
import 'package:fin_wise/binding/initial_binding.dart';
import 'package:fin_wise/core/Routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'core/Routes/routes.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: InitialBindings(),
      theme: ThemeData(
        // fontFamily: 'Poppins',

      ),
      initialRoute: Routes.initRoute,
      getPages: AppRoutes.pageRoutes,
    );
  }
}

