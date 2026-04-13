import 'package:fin_wise/controllers/loader_contrl.dart';
import 'package:fin_wise/controllers/transaction/transaction_ctrl.dart';
import 'package:fin_wise/core/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/widgets/text_widget.dart';

class MonthBottomSheet {
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

  void showMonthBottomSheet(BuildContext context, TransactionCtrl control, LoaderController loader) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return Container(
          // alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: AppColors.lightGreen
          ),
          padding: const EdgeInsets.all(30),
          margin: const EdgeInsets.all(20),
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
                      onTap: () {

                        loader.offLoading(() async{
                          await control.loadTransactions(month, control.selectY.value);
                        });
                        Get.back();
                      },
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(10),
                        child: AppText(
                          text: months[index],
                          textSize: 18,
                          textWeigh: FontWeight.w500,
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (_, index) =>
                      SizedBox(width: 100, child: Divider(color: Colors.green,)),
                  itemCount: months.length,
                ),
              ),
              SizedBox(width: 40),
              SizedBox(
                width: 100,
                height: 150,
                child: ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                       loader.offLoading(() async{
                         await control.loadTransactions(
                           control.selectMon.value,
                           years[index],
                         );
                       });
                        Get.back();
                      },
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(10),
                        child: AppText(text: years[index].toString(), textSize: 18, textWeigh: FontWeight.w500,),
                      ),
                    );
                  },
                  separatorBuilder: (_, index) =>
                      SizedBox(width: 100, child: Divider(color: Colors.green,)),
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
