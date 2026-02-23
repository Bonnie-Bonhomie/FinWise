
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class StatusBarWrapper extends StatelessWidget {
  final Widget child;
  final SystemUiOverlayStyle style;
  const StatusBarWrapper({
    required this.style,
    required this.child,
    super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(value: style, child: child, );
  }
}
