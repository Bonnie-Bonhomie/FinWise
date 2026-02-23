
import 'package:fin_wise/core/app_colors.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final Widget child;
  final VoidCallback onTap;
  final double height;
  final double width;

  const ProductCard({required this.child, required this.onTap, this.height = 80, this.width = 80, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: AppColors.lightGreen,
        ),
        child: Center(child: child),
      ),
    );
  }
}
