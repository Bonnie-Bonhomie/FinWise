import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SkeletonLoader {
  static loadingSkeleton({Widget? child}) {
    return Shimmer.fromColors(
      loop: 4,
      period: Duration(milliseconds: 400),
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade400,
      child: child ?? shimmerChild(),
    );
  }

  static Row shimmerChild() {
    return Row(
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
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.grey.shade400),
        ),
        // Container(
        //   height: 50,
        //   width: 50,
        //   margin: const EdgeInsets.all(6),
        //   decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.grey.shade400),
        // ),
      ],
    );
  }

  static shimmerLines({required int len, Widget? child}){
    return ListView.separated(
      itemCount: len,
        itemBuilder: (context, index){
      return loadingSkeleton(child: child);
    }, separatorBuilder: (context, index) => SizedBox(height: 10,),);
  }

}
