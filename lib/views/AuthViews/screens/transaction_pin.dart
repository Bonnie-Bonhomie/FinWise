import 'package:fin_wise/core/widgets/text_widget.dart';
import 'package:fin_wise/utils/widgets/LoadingFiles/loading_wrapper.dart';
import 'package:fin_wise/utils/widgets/custom_snackbar.dart';
import 'package:fin_wise/utils/widgets/form_widget.dart';
import 'package:fin_wise/views/view_widgets/text_widget.dart';
import 'package:fin_wise/views/view_widgets/view_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/Routes/routes.dart';
import '../../../core/validator/validator.dart';
import '../../../core/widgets/app_btn.dart';

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

    bool pinObscure = false;
   bool confirmPinObscure = false;

   void showPin(){
     setState(() {
       pinObscure = !pinObscure;
     });
   }void showCfmPin(){
    setState(() {
      confirmPinObscure = !confirmPinObscure;
    });
  }

   void setPin() async{
     if(formKey.currentState!.validate()){
       // await
       Get.offNamed(Routes.successful, arguments: 'Transaction Pin has been set successfully');
     }else{
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
            topChild: SizedBox(width: 200,child: HeadingText(headingText: 'Set Transaction Pin')),
            child:  Padding(
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
                    FormWidget(
                      valController: pinCtrl,
                      fieldKey: pinKey,
                      obscure: pinObscure,
                      maxLength: 4,
                      textType: TextInputType.number,
                      validator: (val) => Validator.validatePin(val!),
                      onChanged: (val) => pinKey.currentState?.validate(),
                      hintText: "Enter Pin",
                      suffixIcon: IconButton(
                        onPressed: () {
                          showPin();
                        },
                        icon: pinObscure
                            ? const Icon(Icons.visibility_outlined)
                            : const Icon(Icons.visibility_off_outlined),
                      ),
                    ),
                    const SizedBox(height: 25,),
                    const AppText(text: "Confirm Pin"),
                    const SizedBox(height: 10.0),
                    FormWidget(
                      valController: confirmPinCtrl,
                      fieldKey: confirmPinKey,
                      obscure: confirmPinObscure,
                      textType: TextInputType.number,
                      maxLength: 4,
                      validator: (val) => Validator.validateConfirmPassword(firstPassword: pinCtrl.text.trim(), value: val),
                      onChanged: (val) => confirmPinKey.currentState?.validate(),
                      hintText: "Confirm Pin",
                      suffixIcon: IconButton(
                        onPressed: () {
                          showCfmPin();

                        },
                        icon: confirmPinObscure
                            ? const Icon(Icons.visibility_outlined)
                            : const Icon(Icons.visibility_off_outlined),
                      ),
                    ),

                    const SizedBox(height: 80),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        AppBtn(onPressed: () {
                         setPin();
                        }, label: "Set Pin"),

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
