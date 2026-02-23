import 'package:fin_wise/core/app_colors.dart';
import 'package:fin_wise/core/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class AnimateContainer extends StatelessWidget {
  const AnimateContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return  AnimatedContainer(
      height: 200,
      width: MediaQuery.of(context).size.width,
      duration: Duration(milliseconds: 100),
      decoration: BoxDecoration(
        borderRadius: BorderRadiusGeometry.directional(
          bottomEnd: Radius.circular(15),
          bottomStart: Radius.circular(15),
        ),
        boxShadow: [BoxShadow(color: Colors.black54, blurRadius: 10)],
        color: AppColors.primary,
      ),
      // child: ListView.builder(itemBuilder: itemBuilder)
    );

  }
}
