import 'package:fin_wise/utils/widgets/text_widget.dart';
import 'package:flutter/material.dart';


class EmptyState extends StatelessWidget {
  const EmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image(image: AssetImage('Assets/images/green_empty.png'), height: 90, width: 90,),
        AppText(text: 'Oops!', textSize: 18,),
        AppText(text: 'No transaction history ', textSize: 12,textWeigh: FontWeight.w300,)
      ],
    );
  }
}
