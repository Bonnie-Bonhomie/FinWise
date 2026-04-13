import 'package:flutter/material.dart';

class AnimatedBottomSheet extends StatelessWidget {
  final bool isOpen;
  final bool focused;
  final Widget page;
  final Widget child;

  const AnimatedBottomSheet({
    super.key,
    required this.focused,
    required this.isOpen,
    required this.page,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        page,
        BottomSwitcher(isOpen: isOpen, focused: focused, child: child)
      ],
    );
  }
}

class BottomSwitcher extends StatelessWidget {
  final bool isOpen;
  final Widget child;
  final bool focused;

  const BottomSwitcher({
    super.key,
    required this.isOpen,
    required this.child,
    required this.focused,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 300),
      switchInCurve: Curves.easeInOutQuad,
      child: isOpen
          ? Container(
              key: ValueKey('bottom-sheet'),
              color: Colors.green.withOpacity(0.4),
              child: BottomChild(focused: focused, child: child),
            )
          : const SizedBox(),
    );
  }
}

class BottomChild extends StatelessWidget {
  final Widget child;
  final bool focused;

  const BottomChild({super.key, required this.child, required this.focused});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedPositioned(
          duration: Duration(milliseconds: 300),
          // top: 200,
          bottom: focused ? 50 : 20,
          child: Container(
              // width: 300,
              child: child),
        ),
      ],
    );
  }
}
