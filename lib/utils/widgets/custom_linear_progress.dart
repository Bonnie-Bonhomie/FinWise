
import 'package:flutter/material.dart';

import '../../core/widgets/text_widget.dart';

class CustomLinearProgress extends StatelessWidget {
  const CustomLinearProgress({
    super.key,
    required this.total,
    required this.percent
  });

  final String total;
  final double percent;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 25,
          padding: EdgeInsets.only(right: 10,),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white
          ),
          child: Text(
            total,
            textAlign: TextAlign.end,),
        ),
        Container(
          height: 25,
          width: 3.5 * percent,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.black
          ),
          child: percent >= 40? Text(''): AppText(text: '${percent.toString()}%',
            textColor: Colors.white,
            textAlign: TextAlign.center,),
        ),
      ],
    );
  }
}
