import 'package:data_boot/controllers/AuthControllers/auth_ctrl.dart';
import 'package:data_boot/controllers/AuthControllers/timer_ctrl.dart';
import 'package:data_boot/controllers/loader_contrl.dart';
import 'package:data_boot/core/Routes/routes.dart';
import 'package:data_boot/core/app_colors.dart';
import 'package:data_boot/utils/widgets/app_btn.dart';
import 'package:data_boot/utils/widgets/text_widget.dart';
import 'package:data_boot/utils/widgets/LoadingFiles/loading_wrapper.dart';
import 'package:data_boot/utils/widgets/custom_pin_code_field.dart';
import 'package:data_boot/utils/widgets/custom_snackbar.dart';
import 'package:data_boot/views/view_widgets/view_container.dart';
import 'package:data_boot/views/view_widgets/shared_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerifyEmail extends StatefulWidget {
  const VerifyEmail({super.key});

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  final formKey = GlobalKey<FormState>();

  final GlobalKey<FormFieldState> pinKey = GlobalKey<FormFieldState>();

  final TextEditingController pinTextCtrl = TextEditingController();
  final AuthCtrl authCtrl = Get.find<AuthCtrl>();
  final loader = Get.find<LoaderController>();
  final TimerCtrl timer = Get.put(TimerCtrl());

  void _verify() {
    if (pinTextCtrl.text.isNotEmpty) {
      final otp = int.parse(pinTextCtrl.text.trim());
      loader.offLoading(() async {
        await authCtrl.verifyEmail(context: context, otp: otp);
        pinTextCtrl.text = '';
      });
    } else {
      CustomSnackbar.warningSnack('Fill all the required field to continue');
    }
  }

  Future<void> resendOtp() async {
    loader.offLoading(() async {
      await authCtrl.resendOtp();
      timer.resetTimer();
      timer.startTimer();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    timer.startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LoaderWrapper(
      child: Scaffold(
        body: PageContainer(
          topPadding: 70,
          topChild: const HeadingText(headingText: "Verify Account"),
          child: SingleChildScrollView(
            child: SizedBox(
              height: 650,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 50),
                      const AppText(
                        text: 'Enter verification code send to your email',
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: CustomPinCodeField(
                          pinTextCtrl: pinTextCtrl,
                          len: 6,
                          size: 40,
                          textSize: 15,
                          pinKey: pinKey,
                          autoFocus: true,
                        ),
                      ),
                      const SizedBox(height: 30),
                      AppBtn(
                        onPressed: () {
                          _verify();
                        },
                        label: "Submit",
                      ),

                      const SizedBox(height: 40),
                      Obx(
                        () => RichText(
                          text: TextSpan(
                            text: 'Don`t receive verification code ',
                            style: Theme.of(context).textTheme.bodySmall,
                            children: [
                              TextSpan(
                                text: (0 != timer.seconds.value)
                                    ? '00:${timer.seconds.value.toString()}'
                                    : 'Resend now',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.superBlue,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    if (0 != timer.seconds.value) return;
                                    resendOtp();
                                  },
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 60),
                      RichText(
                        text: TextSpan(
                          text: "Already have an account? ",
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
                      const SizedBox(height: 20),
                      //Reset the gesture detector
                    ],
                  ),
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
    style: const TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Poppins'),
  );
}
