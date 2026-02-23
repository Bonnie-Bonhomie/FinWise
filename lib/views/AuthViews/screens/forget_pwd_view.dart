
import 'package:fin_wise/core/widgets/app_btn.dart';
import 'package:fin_wise/utils/widgets/form_widget.dart';
import 'package:fin_wise/views/view_widgets/view_container.dart';
import 'package:fin_wise/views/view_widgets/text_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/Routes/routes.dart';
import '../../../core/validator/validator.dart';


class ForgetPwdView extends StatelessWidget {
  ForgetPwdView({super.key});

  final formKey = GlobalKey<FormState>();
  final mailKey = GlobalKey<FormFieldState>();
  final TextEditingController mailCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: PageContainer(
          topChild: const HeadingText(headingText: "Forget Password"),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 30),
                  const Text(
                    "Reset Password",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                  const Text(
                    "We will send a you an Otp to your email address. Enter your recovery email address",
                  ),
                 const  SizedBox(height: 30),
                  //Email
                  labelText("Enter Email Address"),
                  const SizedBox(height: 10.0),
                  FormWidget(
                    valController: mailCtrl,
                    fieldKey: mailKey,
                    textType: TextInputType.emailAddress,
                    validator: (val) => Validator.validateEmail(val),
                    onChanged: (val) => mailKey.currentState?.validate(),
                    hintText: "johndue@example.com",
                  ),

                  const SizedBox(height: 40),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppBtn(onPressed: () {
                        Get.toNamed(Routes.otp);
                      }, label: "Next Step"),


                      const SizedBox(height: 80),
                      const Text("Contact us on "),
                      const SizedBox(height: 10),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.facebook_outlined),
                          Icon(Icons.g_mobiledata),
                        ],
                      ),
                      const SizedBox(height: 20),
                      //Reset the gesture detector
                      RichText(
                        text: TextSpan(
                          text: "Already have an account? ",
                          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w200),
                          children: [
                            TextSpan(
                              text: 'Log in',
                              style: const TextStyle(color: Colors.blue),
                              recognizer: TapGestureRecognizer()..onTap= (){
                                Get.offNamed(Routes.login);
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
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
