import 'package:fin_wise/controllers/profileCtrl/main_ctrl.dart';
import 'package:fin_wise/core/app_colors.dart';
import 'package:fin_wise/core/widgets/app_btn.dart';
import 'package:fin_wise/core/widgets/custom_app_bar.dart';
import 'package:fin_wise/core/widgets/text_widget.dart';
import 'package:fin_wise/views/view_widgets/view_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeleteFingerprint extends StatelessWidget {
  const DeleteFingerprint({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageContainer(
        topMargin: 20,
        topChild: CustomAppBar.header(
          title: 'FingerPrint',
          leftRight: 15,
          onPressed: () => Get.find<ProfileMainControl>().back(),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SizedBox(height: 30),
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primary,
                ),
                child: const Icon(
                  Icons.fingerprint_outlined,
                  size: 80,
                  color: Colors.white,
                ),
              ),
              const AppText(
                  text: "John Fingerprint",
                  textSize: 25, textWeigh: FontWeight.bold
              ),
              AppBtn(
                onPressed: () {

                },
                label: "Delete",
                bgColor: AppColors.lightGreen,
                // loading: authCtrl.isAuthenticate.value,
                loadWidget: const CircularProgressIndicator(color: Colors.white),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
