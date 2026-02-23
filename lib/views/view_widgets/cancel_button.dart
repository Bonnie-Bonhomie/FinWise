
import 'package:fin_wise/core/app_colors.dart';
import 'package:fin_wise/core/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class CancelBtn extends StatelessWidget {
  const CancelBtn({
    required this.onPressed,
    this.width = 250,
    super.key,
  });

  final VoidCallback onPressed;
  final double width;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.lightGreen,
        ),
        child: const AppText(
          text: 'Cancel',
          textColor: AppColors.darkGreen,
          textSize: 17,
        ),
      ),
    );
  }
}
