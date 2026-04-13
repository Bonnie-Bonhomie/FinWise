
import 'package:fin_wise/core/app_colors.dart';
import 'package:fin_wise/core/widgets/app_btn.dart';
import 'package:fin_wise/utils/widgets/custom_pin_code_field.dart';
import 'package:fin_wise/views/view_widgets/view_container.dart';
import 'package:fin_wise/views/view_widgets/text_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/Routes/routes.dart';

class OtpScreen extends StatelessWidget {
  OtpScreen({super.key});

  final formKey = GlobalKey<FormState>();
  final TextEditingController pinTextCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: PageContainer(
          topPadding: 90,
          topMargin: 20,
          topChild: const HeadingText(headingText: "Security Pin"),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 50),
                  const Text(
                    "Enter Security Pin",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  const SizedBox(height: 20),
                  CustomPinCodeField(pinTextCtrl: pinTextCtrl, len: 6, size: 30,textSize: 15,),
                  const SizedBox(height: 30),
                  AppBtn(
                    onPressed: () {
                      Get.offNamed(Routes.reset);
                    },
                    label: "Accept",
                  ),

                  const SizedBox(height: 10),
                  RichText(
                    text: TextSpan(
                      text: 'Don`t receive verification code ',
                      style: TextStyle(color: AppColors.darkGreen),
                      children: [
                        TextSpan(
                          text: ' Resend now',
                          style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.superBlue),
                          recognizer: TapGestureRecognizer()..onTap = () {},// Not yet filled
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 80),


                  //Reset the gesture detector
                  RichText(
                    text: TextSpan(
                      text: "Already have an account? ",
                      style: TextStyle(color: Colors.black),
                      children: [
                        TextSpan(
                          text: 'Log in',
                          style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Get.offNamed(Routes.home);
                            },
                        ),
                      ],
                    ),
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

  Text labelText(String label) => Text(
    label,
    style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Poppins'),
  );
}
