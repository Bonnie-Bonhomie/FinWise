import 'package:fin_wise/core/Routes/routes.dart';
import 'package:fin_wise/core/app_colors.dart';
import 'package:fin_wise/core/constant.dart';
import 'package:fin_wise/data/models/model_export.dart';
import 'package:fin_wise/utils/widgets/text_widget.dart';
import 'package:fin_wise/viewModel/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class TransactionSuccessfulView extends StatefulWidget {
  TransactionSuccessfulView({super.key});

  @override
  State<TransactionSuccessfulView> createState() => _TransactionSuccessfulViewState();
}

class _TransactionSuccessfulViewState extends State<TransactionSuccessfulView> {
  final TransactionModel receiptDet = Get.arguments ?? '';

  final viewModel = HomeViewModel();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  Get.until((route) {
                    return route.isFirst;
                  });
                  FocusScope.of(context).unfocus();
                },
                child: const AppText(
                  text: 'Done',
                  textColor: AppColors.primary,
                ),
              ),

              // const SizedBox(height: 20),
              Center(
                child: SizedBox(
                  height: 120,
                  child: Lottie.asset(
                    'Assets/animations/Success.json',
                    repeat: false,
                    fit: BoxFit.cover,
                  ),
                ),
              ),

             Center(child: AppText(text: receiptDet.apiStatus.label, textColor: receiptDet.apiStatus.color,)),
              const SizedBox(height: 20),
              Center(
                child: AppText(
                  text: viewModel.formatCurrency(receiptDet.amount),
                  textWeigh: FontWeight.bold,
                  textSize: 20,
                ),
              ),
              const SizedBox(height: 50),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  receiptContainer('Share Receipt', () {
                    if(receiptDet.apiStatus == TransactionStatus.pending)return;
                    Get.offNamed(Routes.transReceipt, arguments: receiptDet);
                  }, Icons.share),
                  receiptContainer('View Details', () {
                    if(receiptDet.apiStatus == TransactionStatus.pending)return;
                    Get.offNamed(Routes.transReceipt, arguments: receiptDet);
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
