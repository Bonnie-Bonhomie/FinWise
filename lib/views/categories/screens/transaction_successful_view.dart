import 'package:fin_wise/core/Routes/routes.dart';
import 'package:fin_wise/core/app_colors.dart';
import 'package:fin_wise/core/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TransactionSuccessfulView extends StatelessWidget {
  TransactionSuccessfulView({super.key});

  final amount = Get.arguments ?? '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(height: 50),
              TextButton(onPressed: (){Get.back(); FocusScope.of(context).unfocus();}, child: const AppText(text: 'Done', textColor: AppColors.primary,)),
              SizedBox(height: 50),
              Center(child: const AppText(text: 'Successful')),
              SizedBox(height: 20),
              Center(child: AppText(text: '₦$amount', textWeigh: FontWeight.bold, textSize: 25,)),
              SizedBox(height: 50),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  receiptContainer('Share Receipt', (){Get.toNamed(Routes.transReceipt);}, Icons.share),
                  receiptContainer('View Details', (){
                    Get.toNamed(Routes.transReceipt);
                  }, Icons.view_list),
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }

  Widget receiptContainer(String title, VoidCallback onTap, IconData icon) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(3.0),
              margin: const EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                color: AppColors.lightGreen,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Icon(icon, color: AppColors.primary),
            ),
            AppText(text: title),
          ],
        ),
      ),
    );
  }
}
