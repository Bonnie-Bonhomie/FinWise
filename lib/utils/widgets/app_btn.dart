import 'package:flutter/material.dart';

import '../../core/app_colors.dart';

class AppBtn extends StatelessWidget {
  const AppBtn({
    required this.onPressed,
    required this.label,
    this.bgColor,
    this.textColor,
    this.loading = false,
    this.needColor = false,
    this.loadWidget,
    this.textSize,
    super.key,
  });

  final VoidCallback onPressed;
  final String label;
  final Color? bgColor;
  final Color? textColor;
  final bool? needColor;
  final double? textSize;
  final bool loading;
  final Widget? loadWidget;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      width: double.infinity,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: LinearGradient(colors: [
          AppColors.primary,
          AppColors.primary,
          AppColors.darkGreen
        ],
        begin: Alignment.topLeft,
          end: Alignment.bottomRight
        )
      ),
      child: InkWell(
        onTap: onPressed,
        // style: ElevatedButton.styleFrom(
        //   backgroundColor: needColor!?  bgColor: Colors.transparent,
        //
        // ),
        child: loading
            ? loadWidget
            : Center(
              child: Text(
                  label,
                  style: TextStyle(
                    color: textColor ?? AppColors.bgColor,
                    fontSize: textSize ?? 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
            ),
      ),
    );
  }
}


class DisableButton extends StatelessWidget {
  final String label;
  const DisableButton({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey
          ),
          onPressed: (){}, child: Text(label, style: TextStyle(color: Colors.white),)),
    );
  }
}
