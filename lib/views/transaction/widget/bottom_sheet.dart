import 'package:fin_wise/controllers/transaction/transaction_ctrl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/widgets/text_widget.dart';

class MonthBottomSheet{

  final List<int> years = [2026, 2025];
  final List<String> months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];


  void showMonthBottomSheet(BuildContext context, TransactionCtrl control) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(60))
      ),
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 100,
                height: 150,
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    final month = index + 1;
                    return InkWell(
                        onTap: (){
                          control.loadTransactions(month, control.selectY);
                          Get.back();
                        },
                        child: Center(child: AppText(text: months[index])));
                  },
                  separatorBuilder: (_, index) =>
                      SizedBox(width: 100, child: Divider()),
                  itemCount: months.length,
                ),
              ),
              SizedBox(width: 30,),
              SizedBox(
                width: 100,
                height: 150,
                child: ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return InkWell(
                        onTap: (){
                          control.loadTransactions(control.selectMon, years[index]);
                          Get.back();
                        },
                        child: Center(child: AppText(text: years[index].toString())));
                  },
                  separatorBuilder: (_, index) =>
                      SizedBox(width: 100, child: Divider()),
                  itemCount: years.length,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}