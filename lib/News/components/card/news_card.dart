import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news/Model/news/news_model.dart';
import 'package:news/components/functions/functions.dart';
import 'package:news/components/image/cached_image_widget.dart';
import 'package:news/const/colors.dart';

class NewsCard extends StatelessWidget {
  final ArticleModel article;

  const NewsCard({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (article.urlToImage != null)
            CachedImageWidget(imageUrl: article.urlToImage!),

          // Content
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text(
                  article.title ?? 'No Title',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),

                // Source
                if (article.source?.name != null)
                  Text(
                    "Source: ${article.source!.name!}",
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),

                // Published date
                if (article.publishedAt != null)
                  Text(
                    "Published: ${DateFormat.yMMMd().format(article.publishedAt!)}",
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),

                const SizedBox(height: 8),

                // Description or content snippet
                if (article.description != null)
                  Text(
                    article.description!,
                    style: const TextStyle(fontSize: 14),
                  ),

                const SizedBox(height: 12),

                // Button to view full article
                if (article.url != null)
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () => launchURL(article.url!),
                      child: const Text(
                        'Read Full Article',
                        style: TextStyle(color: primaryColor),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
