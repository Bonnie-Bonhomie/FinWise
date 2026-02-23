import 'package:fin_wise/core/connection/network.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/Routes/routes.dart';
import '../../core/app_colors.dart';
import '../../core/widgets/app_btn.dart';
import '../../core/widgets/text_widget.dart';

class PreOnboard extends StatelessWidget {
  PreOnboard({super.key});

  final InternetService service = InternetService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(Icons.trending_down_outlined, color: AppColors.primary, size: 50,),
                 const Icon(
                    Icons.stacked_bar_chart_outlined,
                    textDirection: TextDirection.rtl,
                    size: 150,
                    color: AppColors.primary,
                ),
                // SizedBox(height: 10,),
                const AppText(text:"FinWise", textColor: AppColors.primary, textWeigh: FontWeight.bold, textSize: 50),
                // SizedBox(height: 10,),
                const SizedBox(
                  width: 300,
                  child: Text("Your bank in your pocket, Bank smarter with a secure ans fast mobile app", textAlign: TextAlign.center, style: TextStyle(
                    fontWeight: FontWeight.w200
                  ),),
                ),

                const SizedBox(height: 25,),
                AppBtn(onPressed: () async {
                  if(!await service.connected){
                    Get.snackbar('Oops', 'No internet connection', backgroundColor: AppColors.bgColor);
                  }
                  Get.toNamed(Routes.login);
                }, label: "Log in",),
                const SizedBox(height: 20.0,),
                AppBtn(
                  onPressed: () {
                    Get.toNamed(Routes.signIn);
                  },
                  bgColor: AppColors.bgColor,
                  label: "Sign Up",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
