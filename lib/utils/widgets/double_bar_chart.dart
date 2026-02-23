
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../core/app_colors.dart';
import '../../core/widgets/text_widget.dart';

class DoubleBarChart extends StatelessWidget {
  const DoubleBarChart({
    super.key,
    required this.incomeData,
    required this.expenseData,
    required this.bottomTitle,
  });

  final List<double> incomeData;
  final List<double> expenseData;
  final List<String> bottomTitle;

  @override
  Widget build(BuildContext context) {
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
              // getTitlesWidget: (val, _) {
              //   return AppText(
              //     text: leftTitle[val.toInt()],
              //     textColor: AppColors.darkGreen,
              //   );
              // },
            ),
          ),
        ),
      ),
    );
  }
}
