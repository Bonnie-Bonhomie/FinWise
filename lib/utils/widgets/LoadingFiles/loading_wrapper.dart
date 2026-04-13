import 'package:fin_wise/controllers/loader_contrl.dart';
import 'package:fin_wise/utils/widgets/LoadingFiles/rotating_animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GlobalPremiumLoader extends StatelessWidget {
  final Color? color;
  const GlobalPremiumLoader({super.key, this.color});

  @override
  Widget build(BuildContext context) {
    return GetX<LoaderController>(
      builder: (controller) {
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child:
          controller.isLoading.value ?
          Container(
                  key: const ValueKey("premium_loader"),
                  color: color ?? Colors.black.withOpacity(0.5),
                  child: const Center(child: PremiumLoader()),
                )
              : const SizedBox(),
        );
      },
    );
  }
}

class LoaderWrapper extends StatelessWidget {
  final Color? color;
  const LoaderWrapper({super.key, required this.child, this.color});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [child, GlobalPremiumLoader(color: color,)]);
  }
}
