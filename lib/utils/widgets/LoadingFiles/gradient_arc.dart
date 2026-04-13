import 'dart:math';
import 'package:fin_wise/core/app_colors.dart';
import 'package:flutter/material.dart';

class GradientArcPainter extends CustomPainter {
  final double rotation;

  GradientArcPainter({required this.rotation});

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;

    final gradient = SweepGradient(
      startAngle: 0,
      endAngle: 2 * pi,
      colors: [
        AppColors.primary,
        AppColors.lightGreen,
        AppColors.primary,
      ],
      stops: const [0.2, 0.6, 1.0],
      transform: GradientRotation(rotation),
    );

    final paint = Paint()
      ..shader = gradient.createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      rect.deflate(10),
      0,
      2 * pi,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant GradientArcPainter oldDelegate) =>
      oldDelegate.rotation != rotation;
}