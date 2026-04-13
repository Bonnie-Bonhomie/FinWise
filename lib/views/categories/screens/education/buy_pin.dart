import 'package:fin_wise/controllers/categoryCtrl/education_controller.dart';
import 'package:fin_wise/core/app_colors.dart';
import 'package:fin_wise/core/constant.dart';
import 'package:fin_wise/core/validator/validator.dart';
import 'package:fin_wise/core/widgets/app_btn.dart';
import 'package:fin_wise/core/widgets/custom_app_bar.dart';
import 'package:fin_wise/core/widgets/text_widget.dart';
import 'package:fin_wise/data/models/education_model.dart';
import 'package:fin_wise/utils/widgets/custom_snackbar.dart';
import 'package:fin_wise/utils/widgets/form_widget.dart';
import 'package:fin_wise/utils/widgets/phone_number_form.dart';
import 'package:fin_wise/utils/widgets/price_form_field.dart';
import 'package:fin_wise/views/categories/widgets/confirm_bottom_sheet.dart';
import 'package:fin_wise/views/view_widgets/view_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BuyPinView extends StatelessWidget {
  BuyPinView({super.key});

  final eduCtrl = Get.find<EducationController>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final serviceKey = GlobalKey<FormFieldState>();
  final numberKey = GlobalKey<FormFieldState>();
  TextEditingController serviceCtrl = TextEditingController();
   TextEditingController amountCtrl = TextEditingController();
  final TextEditingController numberCtrl = TextEditingController();
  final EduModel selectedSchool = Get.arguments ?? 'No Title';

  @override
  Widget build(BuildContext context) {
    print(selectedSchool.schoolName);
    serviceCtrl.text = selectedSchool.serviceName;
    amountCtrl.text = selectedSchool.amount.toString();
    return Scaffold(
      body: PageContainer(
        bottomPadding: 20,
        topMargin: 20,
        topChild: CustomAppBar.header(
          title: selectedSchool.abbrev.toUpperCase(),
          leftRight: 15,
          onPressed: () => Get.back(),
        ),
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            labelText('Service type'),


              FormWidget(fieldKey: serviceKey, validator: (val){}, readOnly:  true, valController: serviceCtrl, ),
            const SizedBox(height: 30),
            labelText('Amount'),
            Container(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              margin: const EdgeInsets.only(bottom: 30),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),
                  color: AppColors.lightGreen),
              child: Row(
                children: [
                  AppText(text: '₦'),
                  Expanded(child:
                  PriceFormField(numberCtrl: amountCtrl,
                      hint: AppText(text: ''),
                      color: AppColors.lightGreen,
                      readOnly: true,),
                  )
                ],
              ),
            ),
            labelText('Phone number'),
            PhoneNumberFormField(numberCtrl: numberCtrl,
                numberKey: numberKey,
                validator: (val) => Validator.validateNumber(val!)),
            SizedBox(height: 30),
            labelText('Network Operator'),
            dropdownServiceProvider(eduCtrl.selectedProvider.value),
            SizedBox(height: 30),
            AppBtn(
              onPressed: () {
                final amount = double.tryParse(amountCtrl.text);
                // numberCtrl.text.isNotEmpty?
                // ConfirmBottomSheet().confirmBottomSheet(
                //   context,
                //   amount: amount!,
                //   numberCtrl: numberCtrl,
                //   productName: selectedSchool.abbrev,
                // ): CustomSnackbar.warningSnack('Enter your registered number');
              },
              label: 'Proceed to Payment',
            ),
          ],
        ),
      ),
    );
  }


  Widget labelText(String text) =>
      Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: AppText(
          text: text,
          textWeigh: FontWeight.bold,
          textColor: AppColors.darkGreen,
        ),
      );
}

DropdownButtonFormField<String> dropdownServiceProvider(String value) {
  return DropdownButtonFormField(
    value: value,
    items: List.generate(ServiceProvider.values.length, (index) {
      final service = ServiceProvider.values[index];
      return DropdownMenuItem(
        value: service.label,
        child: AppText(text: service.label.toUpperCase()),
      );
    }),
    decoration: InputDecoration(
      filled: true,
      fillColor: AppColors.lightGreen,
      border: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(20),
      ),
    ),
    onChanged: (val) {
      value = val!;
    },
  );
}
