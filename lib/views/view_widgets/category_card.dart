
import 'package:flutter/material.dart';

import '../../core/app_colors.dart';
import '../../core/widgets/text_widget.dart';

class CategoriesCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final double width;
  final double iconSize;
  final Color color;

  const CategoriesCard({
    required this.icon,
    required this.title,
    required this.onTap,
    this.iconSize = 40,
    this.width = 80,
    this.color = AppColors.superBlue,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Container(
            height: width,
            width: width,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(child: Icon(icon, color: AppColors.bgColor, size: iconSize,)),
          ),
        ),
        AppText(text: title),
      ],
    );
  }
}
