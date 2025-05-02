import 'package:flutter/material.dart';
import 'package:news/News/components/card/shimmer/news_card_shimmer.dart';

class NewsListShimmer extends StatelessWidget {
  const NewsListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 4,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(10),
          child: NewsCardShimmer(),
        );
      },
    );
  }
}
