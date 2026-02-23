import 'package:flutter/material.dart';

import '../app_colors.dart';

class AppBtn extends StatelessWidget {
  const AppBtn({
    required this.onPressed,
    required this.label,
    this.bgColor,
    this.textColor,
    this.loading = false,
    this.needColor = false,
    this.loadWidget,
    this.textSize,
    super.key,
  });

  final VoidCallback onPressed;
  final String label;
  final Color? bgColor;
  final Color? textColor;
  final bool? needColor;
  final double? textSize;
  final bool loading;
  final Widget? loadWidget;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: LinearGradient(colors: [
          AppColors.primary,
          AppColors.primary,
          AppColors.darkGreen
        ],
        begin: Alignment.topLeft,
          end: Alignment.bottomRight
        )
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: needColor!?  bgColor: Colors.transparent,

        ),
        child: loading
            ? loadWidget
            : Text(
                label,
                style: TextStyle(
                  color: textColor ?? AppColors.bgColor,
                  fontSize: textSize ?? 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
      ),
    );
  }
}
