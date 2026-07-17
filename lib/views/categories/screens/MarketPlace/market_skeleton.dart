import 'package:data_boot/utils/utils_export.dart';
import 'package:flutter/material.dart';

class MarketSkeleton extends StatelessWidget {
  const MarketSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemBuilder: (context, index ){
      return SkeletonLoader.loadingSkeleton(child:
      Column(
        children: [
          Container(
            height: 150,
            width: 300,
           margin: const EdgeInsets.all(6),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.grey.shade400),
          ),

          Container(
            height: 15,
            width: 200,
            margin: const EdgeInsets.all(6),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.grey.shade400),
          ),Container(
            height: 15,
            width: 300,
            margin: const EdgeInsets.all(6),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.grey.shade400),
          ),
        ],
      ));
    }, itemCount: 5);
  }
}
