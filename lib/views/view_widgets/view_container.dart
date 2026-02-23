import 'package:fin_wise/core/app_colors.dart';
import 'package:flutter/material.dart';

class PageContainer extends StatelessWidget {
  const PageContainer({
    required this.child,
    required this.topChild,
    this.topMargin,
    this.topPadding = 40,
    this.bottomPadding,
    super.key,
  });

  final Widget child;
  final Widget topChild;
  final double? topMargin;
  final double topPadding;
  final double? bottomPadding;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      padding: EdgeInsets.only(top: topPadding),
      color: AppColors.primary,
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(child: topChild),
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(top: bottomPadding ?? 30),
                margin: EdgeInsets.only(top: topMargin ?? 60.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadiusGeometry.directional(
                    topEnd: Radius.circular(60),
                    topStart: Radius.circular(60),
                  ),
                  color: AppColors.bgColor,
                ),
                child: child,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
