import 'package:flutter/material.dart';

import '../app_colors.dart';

class SectDivider extends StatelessWidget {
  const SectDivider({
    this.height = 40,
    this.width = 2,
    this.colors ,
    super.key,
  });

  final double height;
  final double width;
  final Color? colors;
  @override
  Widget build(BuildContext context) {
    return Container(height: height, width: width, color: colors ?? AppColors.primary,);

  }}