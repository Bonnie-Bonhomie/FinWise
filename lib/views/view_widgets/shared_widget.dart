import 'package:fin_wise/core/app_colors.dart';
import 'package:fin_wise/viewModel/home_view_model.dart';
import 'package:flutter/material.dart';

import '../../utils/utils_export.dart';

class HeadingText extends StatelessWidget {
  const HeadingText({
    super.key,
    this.color,
    required this.headingText,
    this.textAlign = TextAlign.center,
  });

  final String headingText;
  final Color? color;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      headingText,
      style: TextStyle(
          color: color ?? Theme.of(context).textTheme.headlineMedium?.color,
          decoration: TextDecoration.none,
          fontSize: 22,
          fontWeight: FontWeight.bold,
          // fontFamily: 'Poppins'
      ),
      textAlign: textAlign,
    );
  }
}


class BalanceCard extends StatelessWidget {
  BalanceCard({
    super.key,
    required this.title,
    required this.icon,
    this.iconColor,
    required this.value
  });
  final String title;
  final IconData icon;
  final Color? iconColor;
  final double value;

  final HomeViewModel viewModel = HomeViewModel();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.only(bottom: 5.0),
      // color: ,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Theme.of(context).cardColor
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: iconColor ?? AppColors.primary),
          AppText(text: title),
          AppText(
            text: viewModel.formatCurrency(value),
            textColor: iconColor,
            textWeigh: FontWeight.bold,
            textSize: 18,
          ),
        ],
      ),
    );
  }
}


class AnimatedCard extends StatefulWidget {
  final Widget child;
  final int index;
  const AnimatedCard({super.key, required this.child, required this.index});
  @override
  State<AnimatedCard> createState() => _AnimatedCardState();
}

class _AnimatedCardState extends State<AnimatedCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _fade;
  late Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    _fade = CurvedAnimation(parent: _ctrl, curve: Curves.easeOut);
    _slide = Tween<Offset>(
        begin: const Offset(0, 0.08), end: Offset.zero)
        .animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
    final delay = Duration(milliseconds: widget.index * 80);
    Future.delayed(delay, () {
      if (mounted) _ctrl.forward();
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => FadeTransition(
    opacity: _fade,
    child: SlideTransition(position: _slide, child: widget.child),
  );
}


