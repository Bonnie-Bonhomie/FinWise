import 'package:fin_wise/core/app_colors.dart';
import 'package:fin_wise/viewModel/home_view_model.dart';
import 'package:flutter/material.dart';

import '../../utils/utils_export.dart';

class HeadingText extends StatelessWidget {
  const HeadingText({
    super.key,
    required this.headingText,
    this.textAlign = TextAlign.center,
  });

  final String headingText;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      headingText,
      style: TextStyle(
          color: Theme.of(context).textTheme.headlineMedium?.color,
          decoration: TextDecoration.none,
          fontSize: 22,
          fontWeight: FontWeight.bold,
          // fontFamily: 'Poppins'
      ),
      textAlign: textAlign,
    );
  }
}


class BalanceCard extends StatelessWidget {
  BalanceCard({
    super.key,
    required this.title,
    required this.icon,
    this.iconColor,
    required this.value
  });
  final String title;
  final IconData icon;
  final Color? iconColor;
  final double value;

  final HomeViewModel viewModel = HomeViewModel();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      width: 150,
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.only(bottom: 5.0),
      // color: ,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Theme.of(context).cardColor
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: iconColor ?? AppColors.primary),
          AppText(text: title),
          AppText(
            text: viewModel.formatCurrency(value),
            textColor: iconColor,
            textWeigh: FontWeight.bold,
            textSize: 20,
          ),
        ],
      ),
    );
  }
}
