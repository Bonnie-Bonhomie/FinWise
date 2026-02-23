import 'package:fin_wise/controllers/balance_ctrl/balance_ctrl.dart';
import 'package:fin_wise/core/app_colors.dart';
import 'package:fin_wise/core/widgets/app_btn.dart';
import 'package:fin_wise/core/widgets/text_widget.dart';
import 'package:fin_wise/utils/widgets/custom_alert_dialog.dart';
import 'package:fin_wise/views/categories/widgets/payment+bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConfirmBottomSheet {

  final accCtrl = Get.find<AccBalanceCtrl>();

  void confirmBottomSheet(
    BuildContext context, {
    required double amount,
    required TextEditingController numberCtrl,
    required String productName,
    bool data = false,
    String plan= '',
  }) {
    final bool notEnoughAmount = accCtrl.accountBalance.value < amount ;
    showModalBottomSheet(
      context: context,
      isDismissible: false,
      builder: (context) {
        FocusScope.of(context).unfocus();
        return Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadiusGeometry.directional(
              topStart: Radius.circular(60),
              topEnd: Radius.circular(60),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(onPressed: (){
                showDialog(context: context, builder: (context)=> CustomAlertDialog());
              }, icon: const Icon(Icons.dangerous_outlined),),
              Center(
                child: AppText(
                  text: '₦${amount.toStringAsFixed(2)}',
                  textWeigh: FontWeight.bold,
                  textSize: 25,
                ),
              ),
              SizedBox(height: 10,),
              rowTile(
                'Product Name',
                Row(
                  children: [
                    Icon(Icons.security_rounded),
                    AppText(text: productName),
                  ],
                ),
              ),
              rowTile('Recipient Mobile', AppText(text: numberCtrl.text)),
              rowTile('Amount', AppText(text: '₦${amount.toStringAsFixed(2)}')),
              data? rowTile('Data Bundle', AppText(text: plan)): const SizedBox(),
              const Divider(),
              const AppText(text: 'Payment Method', textWeigh: FontWeight.bold,),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 15),
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.lightGreen,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const AppText(
                          text: 'Available Balance',
                          textWeigh: FontWeight.bold,
                        ),
                        const SizedBox(width: 10),
                        AppText(
                          text:
                              '(₦${accCtrl.accountBalance.value.toStringAsFixed(2)})', textColor: notEnoughAmount? Colors.red : Colors.black,
                        ),
                        const Spacer(),
                        const Icon(Icons.done_outlined, color: AppColors.primary),
                      ],
                    ),
                   const SizedBox(height: 10,),
                   notEnoughAmount?  const AppText(text: 'Insufficient balance', textColor: Colors.red,): SizedBox()
                  ],
                ),
              ),
              Center(
                child: AppBtn(onPressed: () {
                  Get.back();
                  PaymentBottomSheet().paymentBottomSheet(context);
                }, label: 'Pay',),
              ),
              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }

  Widget rowTile(String title, Widget child) {
    return Row(
      children: [
        AppText(text: title, textWeigh: FontWeight.bold, textColor: Colors.grey,),
        const Spacer(),
        child,
      ],
    );
  }
}
