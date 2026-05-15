import 'package:fin_wise/utils/widgets/text_widget.dart';
import 'package:flutter/material.dart';


class EmptyState extends StatelessWidget {
  final String message;
  const EmptyState({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image(image: AssetImage('Assets/images/green_empty.png'), height: 90, width: 90,),
        AppText(text: 'Oops!', textSize: 18,),
        AppText(text: message, textSize: 12,textWeigh: FontWeight.w300,)
      ],
    );
  }
}
