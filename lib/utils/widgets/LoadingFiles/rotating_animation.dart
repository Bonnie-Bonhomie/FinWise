import 'dart:math';

import 'package:fin_wise/core/app_colors.dart';
import 'package:flutter/material.dart';

import 'gradient_arc.dart';

class PremiumLoader extends StatefulWidget {
  const PremiumLoader({super.key});

  @override
  State<PremiumLoader> createState() => _PremiumLoaderState();
}

class _PremiumLoaderState extends State<PremiumLoader>
    with SingleTickerProviderStateMixin {

  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat();
  }



  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) {
        return Stack(
          alignment: Alignment.center,
          children: [
            CustomPaint(
              size: const Size(60, 60),
              painter: GradientArcPainter(
                rotation: _controller.value * 2 * pi,
              ),
            ),

            // Center Logo or Icon
            const Icon(
              Icons.dark_mode,
              color: AppColors.primary,
              size: 40,
            ),
          ],
        );
      },
    );
  }
}