import 'package:fin_wise/controllers/AuthControllers/auth_ctrl.dart';
import 'package:fin_wise/controllers/AuthControllers/timer_ctrl.dart';
import 'package:fin_wise/controllers/loader_contrl.dart';
import 'package:fin_wise/core/Routes/routes.dart';
import 'package:fin_wise/core/app_colors.dart';
import 'package:fin_wise/utils/widgets/app_btn.dart';
import 'package:fin_wise/utils/widgets/text_widget.dart';
import 'package:fin_wise/utils/widgets/LoadingFiles/loading_wrapper.dart';
import 'package:fin_wise/utils/widgets/custom_pin_code_field.dart';
import 'package:fin_wise/utils/widgets/custom_snackbar.dart';
import 'package:fin_wise/views/view_widgets/view_container.dart';
import 'package:fin_wise/views/view_widgets/shared_widget.dart';
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

  void _verify()  {
    if (pinTextCtrl.text.isNotEmpty) {
      final otp = int.parse(pinTextCtrl.text.trim());
      loader.offLoading(() async {
        await authCtrl.verifyEmail(context: context, otp: otp);
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
        body: SingleChildScrollView(
          child: PageContainer(
            topPadding: 70,
            topChild: const HeadingText(headingText: "Verify Account"),
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
                      RichText(
                        text: TextSpan(
                          text: 'Don`t receive verification code ',
                          style: Theme.of(context).textTheme.bodySmall,
                          children: [
                            TextSpan(
                              text: 'Resend now',
                              style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.superBlue),
                              recognizer: TapGestureRecognizer()..onTap = () {
                                if (0 != timer.seconds.value) {
                                  CustomSnackbar.warningSnack(
                                    'Try again after ${timer.seconds.value.toString()} seconds',
                                  );
                                } else {
                                  resendOtp();
                                }
                              },// Not yet filled
                            ),
                          ],
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
                              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
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
