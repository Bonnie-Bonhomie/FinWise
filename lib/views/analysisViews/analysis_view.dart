import 'package:fin_wise/controllers/analysis/analysis_ctrl.dart';
import 'package:fin_wise/controllers/balance_ctrl/balance_ctrl.dart';
import 'package:fin_wise/core/constant.dart';
import 'package:fin_wise/core/widgets/custom_app_bar.dart';
import 'package:fin_wise/views/view_widgets/view_container.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/app_colors.dart';
import '../../core/widgets/section_divider.dart';
import '../../core/widgets/text_widget.dart';
import '../../utils/widgets/custom_circular_progress.dart';
import '../../utils/widgets/custom_linear_progress.dart';

class AnalysisPage extends StatefulWidget {
 const AnalysisPage({super.key});

  @override
  State<AnalysisPage> createState() => _AnalysisPageState();
}

class _AnalysisPageState extends State<AnalysisPage> {
  final AccBalanceCtrl acc = Get.find<AccBalanceCtrl>();
  final AnalysisCtrl analysis = Get.find<AnalysisCtrl>();

  @override
  Widget build(BuildContext context) {
    final percent = acc.spentPercent * 100;
    // print(num);

    return Scaffold(
      body: PageContainer(
        topMargin: 15,
        topPadding: 35,
        topChild: Column(
          children: [
            CustomAppBar.header('Analysis', 15, () {
              Get.back();
            }),
            const SizedBox(height: 5),
            headerCard(context, percent),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
          child: Column(
            children: [
              // Analysis Choice Chips
              Container(
                height: 50,
                padding: EdgeInsets.all(4.0),
                margin: EdgeInsets.only(left: 15, right: 15, bottom: 10),
                decoration: BoxDecoration(
                  color: AppColors.lightGreen,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Obx(
                      () =>
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(ChartPeriod.values.length, ((index) {
                          ChartPeriod period = ChartPeriod.values[index];

                          bool selected = analysis.selectPeriod.value == period;
                          final title = analysis.segmentTitle[index];
                          return InkWell(
                            onTap: () {
                              analysis.changePeriod(period);
                            },
                            child: Container(
                              height: 40,
                              width: 65,
                              padding: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: selected
                                    ? AppColors.primary
                                    : AppColors.lightGreen,
                              ),
                              child: AppText(
                                text: title,
                                textColor: AppColors.darkGreen,
                                textAlign: TextAlign.center,
                                textSize: 17,
                              ),
                            ),
                          );
                        })),
                      ),
                ),
              ),
              //End Analysis Choice Chip

              //Graph
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.all(10),
                        padding: const EdgeInsets.all(15.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: AppColors.lightGreen,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              children: [
                                const AppText(
                                  text: 'Income & Expense',
                                  textWeigh: FontWeight.bold,
                                ),
                                // const Spacer(),
                                // IconButton(
                                //   onPressed: () {
                                //     Get.toNamed(Routes.search);
                                //   },
                                //   style: IconButton.styleFrom(
                                //     backgroundColor: AppColors.primary,
                                //   ),
                                //   icon: const Icon(Icons.search),
                                // ),
                                // IconButton(
                                //   onPressed: () {
                                //     Get.toNamed(Routes.calender);
                                //   },
                                //   style: IconButton.styleFrom(
                                //     backgroundColor: AppColors.primary,
                                //   ),
                                //   icon: const Icon(Icons.calendar_today_outlined),
                                // ),
                              ],
                            ),
                            const SizedBox(height: 15),
                            SizedBox(
                              height: 150,
                              width: 270,
                              child: Obx(() {
                                final incomeData = analysis.incomeData;
                                final expenseData = analysis.expenseData;
                                final bottomTitle = analysis.bottomTitles;
                                return BarChart(
                                  BarChartData(
                                    gridData: FlGridData(drawVerticalLine: false, drawHorizontalLine: true),
                                    borderData: FlBorderData(
                                      show: true,
                                      border: Border(
                                        bottom: BorderSide(color: AppColors.darkGreen, width: 2),
                                      ),
                                    ),
                                    barGroups: List.generate(bottomTitle.length, (index) {
                                      return BarChartGroupData(
                                        x: index,
                                        barRods: [
                                          BarChartRodData(
                                            toY: incomeData[index],
                                            color: AppColors.primary,
                                            width: 8,
                                            borderRadius: BorderRadius.circular(4.0),
                                          ),
                                          BarChartRodData(
                                            toY: expenseData[index],
                                            color: AppColors.blue,
                                            width: 6,
                                            borderRadius: BorderRadius.circular(4.0),
                                          ),
                                        ],
                                      );
                                    }),
                                    titlesData: FlTitlesData(
                                      bottomTitles: AxisTitles(
                                        sideTitles: SideTitles(
                                          showTitles: true,
                                          getTitlesWidget: (value, _) {
                                            return AppText(text: bottomTitle[value.toInt()]);
                                          },
                                        ),
                                      ),
                                      topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                                      rightTitles: AxisTitles(
                                        sideTitles: SideTitles(
                                          showTitles: false,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          balanceCard(
                            title: 'Income',
                            icon: Icons.arrow_circle_up_outlined,
                            value: acc.income.value,
                          ),
                          balanceCard(
                            title: 'Expense',
                            icon: Icons.arrow_circle_down_outlined,
                            value: acc.expense.value,
                            iconColor: AppColors.blue,
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      const AppText(
                        text: 'My Targets',
                        textWeigh: FontWeight.bold,
                        textSize: 18,
                      ),
                      Wrap(
                        spacing: 20.0,
                        runSpacing: 10,
                        children: [
                          targetBox(0.2, 'Travel'),
                          targetBox(0.5, 'Car'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container targetBox(double progress, target) {
    return Container(
      height: 130,
      width: 130,
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: 20, left: 6, right: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        color: AppColors.subBlue,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CustomCircularProgress(progress: progress),
          AppText(
            text: target,
            textColor: Colors.white,
            textWeigh: FontWeight.bold,
          ),
        ],
      ),
    );
  }

  //All the Header card
  Container headerCard(BuildContext context, double percent) {
    int getState(percent) {
      final int index;
      if (percent < 50) {
        index = 0;
      } else {
        index = 1;
      }
      return index;
    }

    final List<String> accountState = ['Good', 'Bad'];
    return Container(
      margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              children: [
                totalBox(
                  title: "Total Balance",
                  value: '₦${acc.accountBalance.value.toStringAsFixed(2)}',
                  icon: Icons.arrow_circle_up_outlined,
                  color: AppColors.bgColor,
                ),
                Spacer(),
                SectDivider(colors: AppColors.bgColor),
                Spacer(),
                totalBox(
                  title: "Total Expense",
                  value: '-₦${acc.expense.value.toString()}',
                  color: AppColors.blue,
                  icon: Icons.arrow_circle_down_outlined,
                ),
              ],
            ),
          ),
          CustomLinearProgress(
            total: '₦${acc.spendingLimit.value.toStringAsFixed(2)}',
            percent: percent,
          ),
          SizedBox(height: 20),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.check_circle_outline),
              AppText(
                text:
                ' $percent% of Your Expenses, Look ${accountState[getState(
                    percent)]}.',
              ),
            ],
          ),
        ],
      ),
    );
  }

  // This show the account balance
  Column totalBox({
    required String title,
    required var value,
    required IconData icon,
    required Color? color,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon),
            AppText(text: title),
          ],
        ),
        AppText(
          text: value,
          textWeigh: FontWeight.bold,
          textColor: color,
          textSize: 17,
        ),
      ],
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
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.only(bottom: 5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.transparent,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: iconColor ?? AppColors.primary),
          Text(title),
          AppText(
            text: '#${value.toStringAsFixed(2)}',
            textColor: iconColor,
            textWeigh: FontWeight.bold,
            textSize: 25,
          ),
        ],
      ),
    );
  }
}

