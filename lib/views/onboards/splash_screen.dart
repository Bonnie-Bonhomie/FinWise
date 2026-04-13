
import 'package:fin_wise/core/resources/storage_keys.dart';
import 'package:fin_wise/utils/Helpers/share_prefer_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/Routes/routes.dart';
import '../../core/app_colors.dart';
import '../../core/widgets/text_widget.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>{

  final storage = Get.find<SharedPreferService>();

  Future<void> checkingOnboardShown() async {
    final bool? hasShown = await storage.retrieve<bool>(PrefStoreKeys.isFirstTime);
      // print(hasShown);
    if(hasShown == true){
      Get.offNamed(Routes.login);
    }else {
      Get.offNamed(Routes.onboard);
    }
  }

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 3), (){checkingOnboardShown();});
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
      backgroundColor: AppColors.primary,
      body: SizedBox(
        width: double.infinity,
        // color: ColorTools.primary,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(image: AssetImage('Assets/logos/Vector.png')),
            // SizedBox(height: 10,),
            const AppText(text: "FinWise", textColor: Colors.white, textSize: 50, textWeigh: FontWeight.bold),
          ],
        ),
      ),
    );
  }
}
