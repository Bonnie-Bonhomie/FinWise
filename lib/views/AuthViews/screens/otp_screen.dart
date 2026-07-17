import 'package:data_boot/controllers/AuthControllers/auth_ctrl.dart';
import 'package:data_boot/controllers/AuthControllers/timer_ctrl.dart';
import 'package:data_boot/controllers/loader_contrl.dart';
import 'package:data_boot/core/app_colors.dart';
import 'package:data_boot/utils/widgets/LoadingFiles/loading_wrapper.dart';
import 'package:data_boot/utils/widgets/app_btn.dart';
import 'package:data_boot/utils/widgets/custom_pin_code_field.dart';
import 'package:data_boot/utils/widgets/custom_snackbar.dart';
import 'package:data_boot/views/view_widgets/view_container.dart';
import 'package:data_boot/views/view_widgets/shared_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/Routes/routes.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final formKey = GlobalKey<FormState>();
  final pinKey = GlobalKey<FormFieldState>();
  final TextEditingController pinTextCtrl = TextEditingController();
  final AuthCtrl auth = Get.find<AuthCtrl>();
  final loader = Get.find<LoaderController>();
  final TimerCtrl timer = Get.put(TimerCtrl());

  void verifyPwd() {
    if (pinTextCtrl.text.trim().isNotEmpty) {
      final token = int.parse(pinTextCtrl.text);
      loader.offLoading(() async {
        await auth.verifyPwd(token);
      });
    } else {
      CustomSnackbar.showSnackbar(
        message: 'Check your email and enter the verification code sent to you',
      );
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    timer.startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoaderWrapper(
        child: SingleChildScrollView(
          child: PageContainer(
            topPadding: 90,
            topMargin: 20,
            topChild: const HeadingText(headingText: "Verify Email"),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 50),
                    const Text(
                      "Enter the verification code sent to your email",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 20),
                    CustomPinCodeField(
                      pinTextCtrl: pinTextCtrl,
                      len: 6,
                      size: 30,
                      textSize: 15,
                      pinKey: pinKey,
                    ),
                    const SizedBox(height: 30),
                    Obx(() => Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: AppColors.lightGreen,
                              width: 1.5,
                            ),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: RichText(
                            text: TextSpan(
                              text: 'Don`t receive verification code ',
                              style: Theme.of(context).textTheme.bodySmall,
                              children: [
                                TextSpan(
                                  text: 0 != timer.seconds.value
                                      ? '00:${timer.seconds.value.toString()}'
                                      : 'Resend code',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: 0 != timer.seconds.value? AppColors.declined: AppColors.superBlue,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      if (0 != timer.seconds.value) return;
                                        auth.resendOtp();
                                    },
                                ),
                              ],
                            ),
                          ),
                        )
                    ),
                    const SizedBox(height: 60),
                    AppBtn(
                      onPressed: () {
                        verifyPwd();
                      },
                      label: "Submit",
                    ),

                    const SizedBox(height: 40),

                    //Reset the gesture detector
                    RichText(
                      text: TextSpan(
                        text: "Remember your password? ",
                        style: Theme.of(context).textTheme.bodySmall,
                        children: [
                          TextSpan(
                            text: 'Log in',
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Get.offNamed(Routes.login);
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
      ),
    );
  }

  Text labelText(String label) => Text(
    label,
    style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Poppins'),
  );
}
