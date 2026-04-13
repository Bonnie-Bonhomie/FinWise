import 'package:fin_wise/controllers/loader_contrl.dart';
import 'package:fin_wise/controllers/transaction/transaction_ctrl.dart';
import 'package:fin_wise/core/widgets/custom_app_bar.dart';
import 'package:fin_wise/utils/widgets/LoadingFiles/loading_wrapper.dart';
import 'package:fin_wise/utils/widgets/loading_skeleton.dart';
import 'package:fin_wise/views/transaction/widget/bottom_sheet.dart';
import 'package:fin_wise/views/transaction/widget/transaction_list.dart';
import 'package:fin_wise/views/view_widgets/view_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../core/app_colors.dart';
import '../../core/widgets/text_widget.dart';

class TransactionView extends StatefulWidget {
  const TransactionView({super.key});

  @override
  State<TransactionView> createState() => _TransactionViewState();
}

class _TransactionViewState extends State<TransactionView> {
  final trans = Get.find<TransactionCtrl>();
  final loader = Get.find<LoaderController>();


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
              CustomAppBar.header(title: "Transactions", leftRight: 10, onPressed: () {}),
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
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Column(
                        children: [
                          const AppText(text: 'Total Expense'),
                          AppText(
                            text: '₦${trans.totalExpense.toStringAsFixed(2)}',
                            textWeigh: FontWeight.bold,
                            textSize: 20,
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        balanceCard(
                          title: 'Monthly',
                          icon: Icons.arrow_circle_up_outlined,
                          value: trans.monthlyExpense.value,
                        ),
                        const Spacer(),
                        balanceCard(
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
                 MonthBottomSheet().showMonthBottomSheet(context, trans, loader);
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

Widget topTitle(){

    return Container(
      padding: EdgeInsets.all(5),
      margin: const EdgeInsets.only(left: 20, right: 20),
      decoration: BoxDecoration(
          color: AppColors.bgColor,
          boxShadow: [
            BoxShadow(color: AppColors.lightGreen, offset: Offset(0,3))
          ]
      ),
      child: Row(
        children: [
          Obx(() {
            final month = DateTime(trans.selectY.value, trans.selectMon.value);
              return AppText(
                  text: DateFormat('MMM yyyy').format(month), textWeigh: FontWeight.bold, textSize: 20,);
            }
          ),
          Icon(Icons.arrow_drop_down_sharp),
        ],
      ),
    );
}

  // This show the Income and the expense box
  Container balanceCard({
    required String title,
    required IconData icon,
    Color? iconColor,
    required var value,
  }) {
    return Container(
      height: 90,
      width: 150,
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.only(bottom: 5.0),
      // color: ,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.white,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: iconColor ?? AppColors.primary),
          AppText(text: title),
          AppText(
            text: '₦${value.toStringAsFixed(2)}',
            textColor: iconColor,
            textWeigh: FontWeight.bold,
            textSize: 20,
          ),
        ],
      ),
    );
  }
}
