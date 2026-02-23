import 'package:fin_wise/controllers/categoryCtrl/education_controller.dart';
import 'package:fin_wise/core/Routes/routes.dart';
import 'package:fin_wise/core/app_colors.dart';
import 'package:fin_wise/core/constant.dart';
import 'package:fin_wise/core/widgets/app_btn.dart';
import 'package:fin_wise/core/widgets/custom_app_bar.dart';
import 'package:fin_wise/core/widgets/text_widget.dart';
import 'package:fin_wise/views/categories/widgets/confirm_bottom_sheet.dart';
import 'package:fin_wise/views/view_widgets/view_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BuyPinView extends StatelessWidget {
  BuyPinView({super.key});

  final eduCtrl = Get.find<EducationController>();
  final TextEditingController amountCtrl = TextEditingController();
  final TextEditingController numberCtrl = TextEditingController();
  final title = Get.arguments ?? 'No Title';

  @override
  Widget build(BuildContext context) {
    print(title);
    return Scaffold(
      body: PageContainer(
        bottomPadding: 20,
        topMargin: 20,
        topChild: CustomAppBar.header(
          title.toUpperCase(),
          15,
          () => Get.back(),
        ),
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            labelText('Service type'),
            dropdownFormField(eduCtrl.selectServ.value, eduCtrl.services),
            const SizedBox(height: 30),
            labelText('Amount'),
            inputField(prefixText: '₦', hint: 'Amount', controller: amountCtrl),
            labelText('Phone number'),
            inputField(
              hint: 'Enter registered phone number',
              controller: numberCtrl,
            ),
            labelText('Network Operator'),
            dropdownServiceProvider(eduCtrl.selectedProvider.value),
            SizedBox(height: 30),
            AppBtn(
              onPressed: () {
                final amount = double.tryParse(amountCtrl.text);
                Get.back();
                ConfirmBottomSheet().confirmBottomSheet(
                  context,
                  amount: amount!,
                  numberCtrl: numberCtrl,
                  productName: eduCtrl.selectServ.value,
                );
              },
              label: 'Proceed to Payment',
            ),
          ],
        ),
      ),
    );
  }

  Widget inputField({
    String prefixText = '',
    required String hint,
    required TextEditingController controller,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          hint: AppText(text: hint, textColor: Colors.grey.shade500),
          fillColor: AppColors.lightGreen,
          filled: true,
          prefixIcon: CircleAvatar(
            radius: 3,
            backgroundColor: Colors.transparent,
            child: AppText(text: prefixText, textAlign: TextAlign.justify),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  DropdownButtonFormField<String> dropdownFormField(String value, List list) {
    return DropdownButtonFormField(
      value: value,
      items: List.generate(list.length, (index) {
        final service = list[index];
        return DropdownMenuItem(
          value: service,
          child: AppText(text: service),
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

  Widget labelText(String text) => Padding(
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
