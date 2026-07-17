
import 'package:data_boot/core/resources/storage_keys.dart';
import 'package:data_boot/utils/Helpers/share_prefer_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/Routes/routes.dart';
import '../../core/app_colors.dart';
import '../../utils/widgets/text_widget.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>{

  final storage = Get.find<SharedPreferService>();

  Future<void> checkingOnboardShown() async {
    final bool? hasShown = await storage.retrieve<bool>(PrefStoreKeys.isFirstTime);
      print(hasShown);
    if(hasShown == true){
      Get.offNamed(Routes.login);
    }else {
      Get.offNamed(Routes.onboard);
    }
  }

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 1), ()async{ await checkingOnboardShown();});
    // FocusScope.of(context).unfocus();

  }

  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        // color: ColorTools.primary,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(image: AssetImage('assets/logos/green_logo.png',),width: 200, errorBuilder: (_, __, ___) => const Icon(Icons.image),),
            SizedBox(height: 10,),
            const AppText(text: 'DatabootNg, all service at glance', textColor: AppColors.primary, textSize: 12, textWeigh: FontWeight.bold),
          ],
        ),
      ),
    );
  }
}
