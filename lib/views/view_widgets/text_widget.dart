import 'package:fin_wise/core/app_colors.dart';
import 'package:flutter/material.dart';

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
          color: AppColors.darkGreen,
          decoration: TextDecoration.none,
          fontSize: 22,
          fontWeight: FontWeight.bold, fontFamily: 'Poppins'
      ),
      textAlign: textAlign,
    );
  }
}
