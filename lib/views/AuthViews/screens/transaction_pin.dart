import 'package:fin_wise/controllers/AuthControllers/auth_ctrl.dart';
import 'package:fin_wise/controllers/loader_contrl.dart';
import 'package:fin_wise/utils/widgets/custom_pin_code_field.dart';
import 'package:fin_wise/utils/widgets/text_widget.dart';
import 'package:fin_wise/utils/widgets/LoadingFiles/loading_wrapper.dart';
import 'package:fin_wise/utils/widgets/custom_snackbar.dart';
import 'package:fin_wise/views/view_widgets/shared_widget.dart';
import 'package:fin_wise/views/view_widgets/view_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/widgets/app_btn.dart';

class TransactionPin extends StatefulWidget {
  const TransactionPin({super.key});

  @override
  State<TransactionPin> createState() => _TransactionPinState();
}

class _TransactionPinState extends State<TransactionPin> {
  final formKey = GlobalKey<FormState>();
  final pinKey = GlobalKey<FormFieldState>();
  final confirmPinKey = GlobalKey<FormFieldState>();
  final TextEditingController pinCtrl = TextEditingController();
  final TextEditingController confirmPinCtrl = TextEditingController();
  final loader = Get.find<LoaderController>();
  final AuthCtrl auth = Get.find<AuthCtrl>();

  // bool pinObscure = true;
  // bool confirmPinObscure = true;
  //
  // void showPin() {
  //   setState(() {
  //     pinObscure = !pinObscure;
  //   });
  // }
  //
  // void showCfmPin() {
  //   setState(() {
  //     confirmPinObscure = !confirmPinObscure;
  //   });
  // }

  void setPin() async {
    if (pinCtrl.text.length == 4 && confirmPinCtrl.text.length == 4) {
      final pin = int.parse(pinCtrl.text.trim());
      final cfmPin = int.parse(confirmPinCtrl.text.trim());
      loader.offLoading(() async {
        await auth.setPin(oldPin: 1234, newPin: pin, cfmPin: cfmPin);
      });
    } else {
      CustomSnackbar.warningSnack('Fill all the required field to continue');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoaderWrapper(
        child: SingleChildScrollView(
          child: PageContainer(
            topPadding: 70,
            topChild: SizedBox(
              width: 200,
              child: HeadingText(headingText: 'Set Transaction Pin'),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 30),
                    //Email
                    const AppText(text: "Enter Pin"),
                    const SizedBox(height: 10.0),
                    CustomPinCodeField(
                      pinTextCtrl: pinCtrl,
                      len: 4,
                      pinKey: pinKey,
                      // validator: (val) => Validator.validatePin(val!),
                    ),

                    const SizedBox(height: 25),
                    const AppText(text: "Confirm Pin"),
                    const SizedBox(height: 10.0),
                    CustomPinCodeField(
                      pinTextCtrl: confirmPinCtrl,
                      len: 4,
                      pinKey: confirmPinKey,
                      // validator: (val) => Validator.validateConfirmPassword(
                      //   firstPassword: pinCtrl.text.trim(),
                      //   value: val,
                      // ),
                    ),

                    const SizedBox(height: 80),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        AppBtn(
                          onPressed: () {
                            setPin();
                          },
                          label: "Set Pin",
                        ),
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
}
