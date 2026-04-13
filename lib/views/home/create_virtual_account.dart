import 'package:fin_wise/core/app_colors.dart';
import 'package:fin_wise/core/validator/validator.dart';
import 'package:fin_wise/core/widgets/app_btn.dart';
import 'package:fin_wise/core/widgets/custom_app_bar.dart';
import 'package:fin_wise/core/widgets/text_widget.dart';
import 'package:fin_wise/utils/widgets/custom_snackbar.dart';
import 'package:fin_wise/utils/widgets/datePicker.dart';
import 'package:fin_wise/utils/widgets/form_widget.dart';
import 'package:fin_wise/utils/widgets/phone_number_formatter.dart';
import 'package:fin_wise/views/view_widgets/view_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CreateVirtualAccount extends StatelessWidget {
  CreateVirtualAccount({super.key});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final GlobalKey<FormFieldState> nameKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> dateKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> phoneKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> bvnKey = GlobalKey<FormFieldState>();
  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController dateCtrl = TextEditingController();
  final TextEditingController phoneCtrl = TextEditingController();
  final TextEditingController bvnCtrl = TextEditingController();

  void generate(){
    if(formKey.currentState!.validate()){
      Get.back();
    }else{
      CustomSnackbar.warningSnack('Fill all the required field to continue');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageContainer(
        bottomPadding: 20,
        topMargin: 20,
        topChild: CustomAppBar.header
          (title:
          'Create Virtual Account',
          leftRight: 15,
         onPressed: () => Get.back(),
          notification: false
        ),
        child: Form(
          key: formKey,
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              labelText('Full Name'),
              FormWidget(
                onChanged: (val) => nameKey.currentState!.validate(),
                hintText: 'Enter your full name',
                textType: TextInputType.name,
                fieldKey: nameKey,
                valController: nameCtrl,
                validator: (value) => Validator.validateText(value, 'fullName'),
              ),
              labelText('Date of Birth'),
              DatePicker(dateControl: dateCtrl, firstDate: DateTime(1980), lastDate: DateTime(2011),),
              labelText('Phone number'),
              TextFormField(
                controller: phoneCtrl,
                key: phoneKey,
                autofocus: false,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  PhoneNumberFormatter(),
                ],
                validator: (value) => Validator.validatePhoneNumber(value!),
                onChanged: (val) => phoneKey.currentState!.validate(),
                keyboardType: TextInputType.number,
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
              labelText('BVN'),
              FormWidget(
                hintText: 'Enter your BVN number',
                fieldKey: bvnKey,
                valController: bvnCtrl,
                validator: (value) =>Validator.validateBVN(value!),
              ),
              const SizedBox(height: 60,),
              AppBtn(onPressed: (){
                Get.back();
              }, label: 'Create Virtual Account')
            ],
          ),
        ),
      ),
    );
  }

  Widget labelText(String label) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 20),
      child: AppText(text: label, textWeigh: FontWeight.bold),
    );
  }
}
