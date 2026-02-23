
import 'package:flutter/material.dart';

import '../../../core/app_colors.dart';

class DotIndicator extends StatelessWidget {
  const DotIndicator({super.key, required this.color, required this.onDot,});
  final Color color;
  final bool onDot;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 10.0,
      width: 10.0,
      margin: EdgeInsets.all(6),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: onDot? Border(): Border.all(color: AppColors.darkGreen, width: 1),
        color: color,
      ),
    );
  }
}
