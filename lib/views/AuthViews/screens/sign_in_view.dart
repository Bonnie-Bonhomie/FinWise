import 'package:fin_wise/controllers/AuthControllers/auth_ctrl.dart';
import 'package:fin_wise/core/app_colors.dart';
import 'package:fin_wise/core/resources/storage_keys.dart';
import 'package:fin_wise/core/widgets/app_btn.dart';
import 'package:fin_wise/utils/Helpers/share_prefer_services.dart';
import 'package:fin_wise/utils/widgets/datePicker.dart';
import 'package:fin_wise/utils/widgets/form_widget.dart';
import 'package:fin_wise/utils/widgets/phone_number_formatter.dart';
import 'package:fin_wise/views/view_widgets/view_container.dart';
import 'package:fin_wise/views/view_widgets/text_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../core/Routes/routes.dart';
import '../../../core/validator/validator.dart';
import '../../../core/widgets/text_widget.dart';


class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final formKey = GlobalKey<FormState>();
  final nameKey = GlobalKey<FormFieldState>();
  final numberKey = GlobalKey<FormFieldState>();
  final mailKey = GlobalKey<FormFieldState>();
  final pwdKey = GlobalKey<FormFieldState>();
  final confirmPwdKey = GlobalKey<FormFieldState>();
  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController numberCtrl = TextEditingController();
  final TextEditingController mailCtrl = TextEditingController();
  final TextEditingController pwdCtrl = TextEditingController();
  final TextEditingController confirmPwdCtrl = TextEditingController();
  final TextEditingController dobCtrl = TextEditingController();
  final AuthCtrl authCtrl = Get.find<AuthCtrl>();

  bool pwdObscure = true;
  bool confirmPwdObscure = true;

  @override
  void dispose() {
    mailCtrl.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  void showPass() {
    setState(() {
      pwdObscure = !pwdObscure;
    });
  }

  void showCfmPass() {
    setState(() {
      confirmPwdObscure = !confirmPwdObscure;
    });
  }

  Future<void> _register() async {
    if (formKey.currentState!.validate()) {
      await authCtrl.registerUser(
        name: nameCtrl.text.trim(),
        mail: mailCtrl.text,
        dob: dobCtrl.text,
        phone: numberCtrl.text,
        password: pwdCtrl.text,
        confirmPassword: confirmPwdCtrl.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: PageContainer(
          topChild: const HeadingText(headingText: "Create Account"),
          child: formSection(),
        ),
      ),
    );
  }

  Form formSection() {
    return Form(
      key: formKey,
      child: SizedBox(
        height: 670,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 20),
                labelText("Full Name"),
                const SizedBox(height: 8.0),
                FormWidget(
                  valController: nameCtrl,
                  fieldKey: nameKey,
                  validator: (val) => Validator.validateText(val, 'Full Name'),
                  onChanged: (val) => nameKey.currentState?.validate(),
                  hintText: "john due",
                ),
                const SizedBox(height: 15),
                labelText("Email"),
                const SizedBox(height: 8.0),
                FormWidget(
                  // label: '',
                  valController: mailCtrl,
                  fieldKey: mailKey,
                  textType: TextInputType.emailAddress,
                  validator: (val) => Validator.validateEmail(val),
                  onChanged: (val) => mailKey.currentState?.validate(),
                  hintText: "johndue@example.com",
                ),
                const SizedBox(height: 15),
                labelText("Mobile Number"),
                const SizedBox(height: 8.0),
                TextFormField(
                  controller: numberCtrl,
                  key: numberKey,
                  autofocus: false,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    PhoneNumberFormatter(),
                  ],
                  validator: (value) => Validator.validatePhoneNumber(value!) ,
                  keyboardType: TextInputType.number,
                  onChanged: (val) => numberKey.currentState!.validate(),
                  decoration: InputDecoration(
                    hintText: '080X XXX XXXX',
                    fillColor: AppColors.lightGreen,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                labelText("Date of Birth"),
                const SizedBox(height: 15.0),
                SizedBox(height: 40, child: DatePicker(dateControl: dobCtrl)),
                labelText("Password"),
                const SizedBox(height: 15.0),
                const SizedBox(height: 8.0),
                FormWidget(
                  valController: pwdCtrl,
                  fieldKey: pwdKey,
                  obscure: pwdObscure,
                  validator: (val) => Validator.validatePassword(val),
                  onChanged: (val) => pwdKey.currentState?.validate(),
                  hintText: "Password",
                  suffixIcon: IconButton(
                    onPressed: () {
                      showPass();
                    },
                    icon: pwdObscure
                        ? const Icon(Icons.visibility_off_outlined)
                        : const Icon(Icons.visibility_outlined),
                  ),
                ),
                const SizedBox(height: 15),
                labelText("Confirm Password"),
                const SizedBox(height: 8.0),
                FormWidget(
                  valController: confirmPwdCtrl,
                  fieldKey: confirmPwdKey,
                  obscure: confirmPwdObscure,
                  onChanged: (val) => confirmPwdKey.currentState?.validate(),
                  validator: (val) => Validator.validateConfirmPassword(
                    firstPassword: pwdCtrl.text,
                    value: val,
                  ),
                  hintText: "confirm password",
                  suffixIcon: IconButton(
                    onPressed: () {
                      showCfmPass();
                    },
                    icon: confirmPwdObscure
                        ? const Icon(Icons.visibility_off_outlined)
                        : const Icon(Icons.visibility_outlined),
                  ),
                ),
                const SizedBox(height: 20.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const AppText(text: "By continuing, you agree to"),
                    TextButton(onPressed: (){
                      Get.toNamed(Routes.terms);
                    }, child: const AppText(
                      text: "Terms of Use and Privacy Policy.",
                      textWeigh: FontWeight.bold,textColor: AppColors.darkGreen,
                    ),),
                    AppBtn(
                      onPressed: () {
                        // _register();
                        Get.find<SharedPreferService>().saveData<bool>(PrefStoreKeys.isFirstTime, true );

                        Get.offNamed(Routes.transPin);
                      },
                      label: 'Sign Up',
                      loading: authCtrl.loading.value,
                      loadWidget: CircularProgressIndicator(),
                    ),
                    const SizedBox(height: 20),
                    RichText(
                      text: TextSpan(
                        text: "Already have an account? ",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w300,
                        ),
                        children: [
                          TextSpan(
                            text: 'Log in',
                            style: TextStyle(color: Colors.blue),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Get.offNamed(Routes.login);
                              },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15,)
                  ],
                ),
              ],
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
