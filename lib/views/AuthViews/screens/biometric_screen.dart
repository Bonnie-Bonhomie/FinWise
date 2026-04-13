import 'package:fin_wise/controllers/AuthControllers/auth_ctrl.dart';
import 'package:fin_wise/core/widgets/app_btn.dart';
import 'package:fin_wise/views/view_widgets/view_container.dart';
import 'package:fin_wise/views/view_widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/Routes/routes.dart';
import '../../../core/app_colors.dart';

class BiometricScreen extends StatelessWidget {
  BiometricScreen({super.key});

  final authCtrl = Get.find<AuthCtrl>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageContainer(
        topChild: HeadingText(headingText: "Use FingerPrint"),
        child: SizedBox(
          height: 650,
          width: MediaQuery.of(context).size.width,
          child: Obx(()=> Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  const Text(
                    "Use fingerPrint to Log in",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 300,
                    child: AppBtn(
                      onPressed: () {
                        authCtrl.isAuthenticate.value
                            ? GetSnackBar(title: "Fingerprint enabled",)
                            : authCtrl.loginWithFingerprint();
                      },
                      label: "Use Touch Id",
                      bgColor: AppColors.lightGreen,
                      loading: authCtrl.isAuthenticate.value,
                      loadWidget: const CircularProgressIndicator(color: Colors.white),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: const Text("¿Or prefer to use pin code?"),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
