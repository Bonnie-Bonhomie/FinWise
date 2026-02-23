import 'package:flutter/material.dart';

class DismissKeyboard extends StatelessWidget {
  const DismissKeyboard ({super.key, required this.child});

  final Widget child;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      behavior: HitTestBehavior.translucent,
      child: child,
    );
  }
}
