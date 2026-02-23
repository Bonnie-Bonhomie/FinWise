import 'package:flutter/material.dart';

import '../../core/app_colors.dart';
import '../../core/widgets/text_widget.dart';

class CustomCircularProgress extends StatelessWidget {
  const CustomCircularProgress({
    required this.progress,
    super.key,
  });

  final double progress;
  @override
  Widget build(BuildContext context) {
    final percent = progress * 100;
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          height: 60,
          width: 60,
          child: CircularProgressIndicator(
            value: progress,
            strokeWidth: 4,
            strokeCap: StrokeCap.round,
            backgroundColor: AppColors.bgColor,
            valueColor: AlwaysStoppedAnimation(AppColors.blue),
          ),
        ),
        AppText(text: '${percent.toInt()}%', textColor: AppColors.bgColor,)
      ],
    );
  }
}
