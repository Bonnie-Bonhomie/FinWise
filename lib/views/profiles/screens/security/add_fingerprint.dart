
import 'package:fin_wise/controllers/profileCtrl/main_ctrl.dart';
import 'package:fin_wise/core/Routes/routes.dart';
import 'package:fin_wise/core/widgets/app_btn.dart';
import 'package:fin_wise/core/widgets/custom_app_bar.dart';
import 'package:fin_wise/views/view_widgets/view_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/app_colors.dart';
import '../../../../core/widgets/text_widget.dart';

class AddFingerprint extends StatelessWidget {
  const AddFingerprint({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageContainer(
        topMargin: 20,
        topChild: CustomAppBar.header('Add Fingerprint', 15, () => Get.find<ProfileMainControl>().back()),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(height: 10),
              Container(
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primary,
                ),
                child: const Icon(
                  Icons.fingerprint_outlined,
                  size: 100,
                  color: Colors.white,
                ),
              ),
              const AppText(text: "Use fingerprint to access",
                textSize: 25, textWeigh: FontWeight.bold
              ),
              AppBtn(
                onPressed: () {
                  Get.toNamed(Routes.successful, arguments: 'Fingerprint has been changed Successfully');
                },
                label: "Use Touch Id",
                bgColor: AppColors.lightGreen,
                // loading: authCtrl.isAuthenticate.value,
                loadWidget: const CircularProgressIndicator(color: Colors.white),
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
        ),
    );
  }
}
