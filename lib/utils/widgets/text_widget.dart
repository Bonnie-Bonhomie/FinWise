import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  const AppText({
    super.key,
    required this.text,
    this.textAlign,
    this.textSize,
    this.textWeigh,
    this.textColor,
    this.maxLines = 1,
  });

  final String text;
  final TextAlign? textAlign;
  final double? textSize;
  final FontWeight? textWeigh;
  final Color? textColor;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign ?? TextAlign.start,
      maxLines: maxLines,
      style: TextStyle(
        fontSize: textSize,
        // fontFamily: 'Poppins',
        fontWeight: textWeigh,
        color: textColor ?? Theme.of(context).textTheme.bodySmall!.color,
      ),
    );
  }
}
