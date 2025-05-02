import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class NewsCardShimmer extends StatelessWidget {
  const NewsCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Shimmer Image
          Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Container(
              height: 180,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
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
