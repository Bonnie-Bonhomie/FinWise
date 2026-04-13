import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SkeletonLoader {
  static loadingSkeleton() {
    return Shimmer.fromColors(
      loop: 4,
      // period: Duration(milliseconds: 500),
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade400,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 50,
            width: 50,
            margin: const EdgeInsets.all(6),
            decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.grey.shade400),
          ),
          Container(
            height: 50,
            width: 180,
            margin: const EdgeInsets.all(6),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(25), color: Colors.grey.shade400),
          ),
          Container(
            height: 50,
            width: 50,
            margin: const EdgeInsets.all(6),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.grey.shade400),
          ),
        ],
      ),
    );
  }

  static shimmerLines({required int len}){
    return ListView.separated(
      itemCount: len,
        itemBuilder: (context, index){
      return loadingSkeleton();
    }, separatorBuilder: (context, index) => SizedBox(height: 10,),);
  }

}
