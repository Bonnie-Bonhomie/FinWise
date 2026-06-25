
import 'package:fin_wise/utils/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class CancelBtn extends StatelessWidget {
  const CancelBtn({
    required this.onPressed,
    this.width = 250,
    super.key,
  });

  final VoidCallback onPressed;
  final double width;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // width: width,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).cardColor
        ),
        child: const AppText(
          text: 'Cancel',
          textSize: 17,
        ),
      ),
    );
  }
}
