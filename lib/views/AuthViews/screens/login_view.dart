import 'package:fin_wise/controllers/AuthControllers/auth_ctrl.dart';
import 'package:fin_wise/core/app_colors.dart';
import 'package:fin_wise/core/connection/network.dart';
import 'package:fin_wise/core/validator/validator.dart';
import 'package:fin_wise/core/widgets/app_btn.dart';
import 'package:fin_wise/utils/widgets/form_widget.dart';
import 'package:fin_wise/views/view_widgets/view_container.dart';
import 'package:fin_wise/views/view_widgets/text_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/Routes/routes.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final formKey = GlobalKey<FormState>();
  final emailKey = GlobalKey<FormFieldState>();
  final pwdKey = GlobalKey<FormFieldState>();
  final TextEditingController mailCtrl = TextEditingController();
  final TextEditingController pwdCtrl = TextEditingController();

  //Controllers
  final AuthCtrl authCtrl = Get.find<AuthCtrl>();
  final InternetService network = Get.find<InternetService>();

  bool pwdObscure = false;

  void showPass() {
    setState(() {
      pwdObscure = !pwdObscure;
    });
  }

  Future<void> login() async {
    if (formKey.currentState!.validate()) {
      await authCtrl.loginUser(mailCtrl.text, pwdCtrl.text.tr);
    }
  }

  @override
  void initState() {
    showPass();
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: PageContainer(
          topPadding: 70,
          topChild: HeadingText(headingText: "Welcome"),
          child: SizedBox(
            height: 650,
            child: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    labelText("Username Or Email"),
                    const SizedBox(height: 8.0),
                    FormWidget(
                      valController: mailCtrl,
                      fieldKey: emailKey,
                      validator: (val) => Validator.validateEmail(val),
                      onChanged: (val) => emailKey.currentState?.validate(),
                      hintText: "johndue@example.com",
                    ),
                    const SizedBox(height: 15),
                    labelText("Password"),
                    const SizedBox(height: 8.0),
                    FormWidget(
                      valController: pwdCtrl,
                      obscure: pwdObscure,
                      fieldKey: pwdKey,
                      onChanged: (val) => pwdKey.currentState?.validate(),
                      validator: (val) => Validator.validatePassword(val),
                      hintText: "enter password",
                      suffixIcon: IconButton(
                        onPressed: () {
                          showPass();
                        },
                        icon: pwdObscure
                            ? const Icon(Icons.visibility_outlined)
                            : const Icon(Icons.visibility_off_outlined),
                      ),
                    ),
                    const SizedBox(height: 60),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        AppBtn(
                          onPressed: () async {
                            Get.offAllNamed(Routes.mainS);
                            // await network.connected
                            //     ?
                            //       // login();
                            //       Get.offAllNamed(Routes.mainS)
                            //     : Get.snackbar(
                            //         'No Internet',
                            //         'Check your internet connection',
                            //         backgroundColor: AppColors.lightGreen,
                            //       );
                          },
                          label: "Log in",
                        ),
                        const SizedBox(height: 20),
                        InkWell(
                          onTap: () {
                            Get.offNamed(Routes.forget);
                          },
                          child: RichText(
                            text: TextSpan(
                              text: 'Forget Password? ',
                              style: TextStyle(color: AppColors.darkGreen),
                              children: [
                                TextSpan(
                                  text: 'Click here',
                                  style: TextStyle(
                                    color: AppColors.superBlue,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),

                        RichText(
                          text: TextSpan(
                            text: "Use ",
                            children: [
                              TextSpan(
                                text: "Fingerprint",
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Get.toNamed(Routes.biometric);
                                  },
                                style: TextStyle(color: Colors.blue),
                              ),
                              const TextSpan(text: " To Access"),
                            ],
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        const SizedBox(height: 100),
                        RichText(
                          text: TextSpan(
                            text: "Don`t have an account? ",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w300,
                            ),
                            children: [
                              TextSpan(
                                text: 'Sign Up',
                                style: TextStyle(color: Colors.blue),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Get.offNamed(Routes.signIn);
                                  },
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 30),
                      ],
                    ),
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
