import 'package:fin_wise/controllers/onboardControllers/onboard_control.dart';
import 'package:fin_wise/views/onboards/widgets/dot_file.dart';
import 'package:fin_wise/views/view_widgets/view_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/app_colors.dart';
import '../view_widgets/text_widget.dart';

class OnboardOne extends StatelessWidget {
  const OnboardOne({super.key});

  @override
  Widget build(BuildContext context) {
    final dotCtrl = Get.put(OnboardControl());
    final int numerofDot = 2;
    return Scaffold(
      body: Obx(
        () => PageContainer(
          topPadding: 80,
          topChild: SizedBox(
            width: 250,
            child: HeadingText(
              headingText: dotCtrl.topText[dotCtrl.dotNumber.value],
            ),
          ),
          child: ListView(
            padding: const EdgeInsets.all(50.0),
            children: [
              // const SizedBox(height: 30,),
              SizedBox(
                height: 250,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        color: AppColors.lightGreen,
                        shape: BoxShape.circle,
                      ),
                    ),
                    Image(
                      image: AssetImage(
                        dotCtrl.imagePath[dotCtrl.dotNumber.value],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30,),
              TextButton(
                onPressed: () {
                  dotCtrl.nextPage(context);
                },
                child: dotCtrl.loading.value
                    ? CircularProgressIndicator(color: AppColors.primary)
                    : const Text(
                        "Next",
                        style: TextStyle(
                          color: AppColors.darkGreen,
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
              const SizedBox(height: 30,),
              Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(numerofDot, (index) {
                    final onDot = dotCtrl.dotNumber.value == index;
                    return DotIndicator(
                      color: onDot ? AppColors.primary : AppColors.bgColor,
                      onDot: onDot,
                    );
                  }),
                ),
              ),
              const SizedBox(height: 20,)
            ],
          ),
        ),
      ),
    );
  }
}
