import 'package:fin_wise/controllers/loader_contrl.dart';
import 'package:fin_wise/controllers/transaction/transaction_ctrl.dart';
import 'package:fin_wise/utils/widgets/custom_app_bar.dart';
import 'package:fin_wise/utils/widgets/LoadingFiles/loading_wrapper.dart';
import 'package:fin_wise/utils/widgets/loading_skeleton.dart';
import 'package:fin_wise/viewModel/home_view_model.dart';
import 'package:fin_wise/views/transaction/widget/bottom_sheet.dart';
import 'package:fin_wise/views/transaction/widget/transaction_list.dart';
import 'package:fin_wise/views/view_widgets/view_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../core/app_colors.dart';
import '../../utils/widgets/text_widget.dart';
import '../view_widgets/shared_widget.dart';

class TransactionView extends StatefulWidget {
  const TransactionView({super.key});

  @override
  State<TransactionView> createState() => _TransactionViewState();
}

class _TransactionViewState extends State<TransactionView> {
  final trans = Get.find<TransactionCtrl>();
  final loader = Get.find<LoaderController>();
  final HomeViewModel viewModel = HomeViewModel();

  int isSelected = 1;

  void select() {
    setState(() {
      if (isSelected < 2) {
        isSelected++;
      } else {
        isSelected = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageContainer(
        topPadding: 40,
        topMargin: 15,
        topChild: Column(
          children: [
            CustomAppBar.header(
                title: "Transactions", leftRight: 10, onPressed: () {}),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                children: [
                  Container(
                    // height: 60,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    padding: const EdgeInsets.all(7),
                    margin: const EdgeInsets.only(bottom: 15),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Column(
                      children: [
                        const AppText(text: 'Total Expense'),
                        AppText(
                          text: viewModel.formatCurrency(trans.totalExpense
                              .value),
                          textWeigh: FontWeight.bold,
                          textSize: 20,
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      BalanceCard(
                        title: 'Monthly',
                        icon: Icons.arrow_circle_up_outlined,
                        value: trans.monthlyExpense.value,
                      ),
                      const Spacer(),
                      BalanceCard(
                        title: 'Daily',
                        icon: Icons.arrow_circle_up_outlined,
                        value: trans.dailyExpense.value,
                        iconColor: Colors.blue,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        child: Column(
          children: [
            InkWell(
                onTap: () {
                  MonthBottomSheet().showMonthBottomSheet(
                      context, trans, loader);
                },
                //Display the select month and year
                child: topTitle()
            ),

            Expanded(child: TransactionListView(trans: trans, loader: loader,))
          ],
        ),


      ),
    );
  }

  Widget topTitle() {
    return Container(
      padding: EdgeInsets.all(5),
      margin: const EdgeInsets.only(left: 20, right: 20),
      decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          boxShadow: [
            BoxShadow(color: AppColors.lightGreen, offset: Offset(0, 3))
          ]
      ),
      child: Row(
        children: [
          Obx(() {
            final month = DateTime(trans.selectY.value, trans.selectMon.value);
            return AppText(
              text: DateFormat('MMM yyyy').format(month),
              textWeigh: FontWeight.bold,
              textSize: 20,);
          }
          ),
          Icon(Icons.arrow_drop_down_sharp),
        ],
      ),
    );
  }

}

