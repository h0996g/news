import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class NewsCardShimmer extends StatelessWidget {
  const NewsCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Shimmer Image
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
            child: Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: Container(
                height: 180,
                width: double.infinity,
                color: Colors.white,
              ),
            ),
          ),

          // Shimmer Content
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                shimmerLine(width: double.infinity, height: 18), // Title
                const SizedBox(height: 8),
                shimmerLine(width: 150), // Source
                const SizedBox(height: 4),
                shimmerLine(width: 100), // Published Date
                const SizedBox(height: 8),
                shimmerLine(width: double.infinity),
                const SizedBox(height: 4),
                shimmerLine(width: double.infinity),
                const SizedBox(height: 4),
                shimmerLine(width: 200),
                const SizedBox(height: 12),
                Align(
                  alignment: Alignment.centerRight,
                  child: shimmerLine(width: 120, height: 16), // Button
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget shimmerLine({double width = double.infinity, double height = 12}) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
