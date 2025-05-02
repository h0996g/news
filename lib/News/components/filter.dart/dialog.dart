import 'package:flutter/material.dart';
import 'package:news/Model/filter/news_filter_m.dart';
import 'package:news/News/TopHeadlines/cubit/news_headlines_cubit.dart';
import 'package:news/News/components/filter.dart/filter.dart';
import 'package:news/News/Everything/cubit/news_everything_cubit.dart';
import 'package:news/helper/cach.dart';

class NewsFilterDialog extends StatelessWidget {
  final bool isEverything;

  const NewsFilterDialog({super.key, required this.isEverything});

  @override
  Widget build(BuildContext context) {
    final initialFilter = NewsFilterModel.fromCache();

    return Center(
      child: Dialog(
        child: NewsFilterWidget(
          initialFrom: initialFilter.from,
          initialTo: initialFilter.to,
          initialSource: initialFilter.source,
          onApply: ({
            required DateTime? from,
            required String? source,
            required DateTime? to,
          }) {
            final filter = NewsFilterModel(from: from, to: to, source: source);

            // Save to cache
            filter.toCacheMap().forEach((key, value) {
              if (value != null) {
                CachHelper.putcache(key: key, value: value);
              }
            });

            if (isEverything) {
              NewsEverythingCubit.get(
                context,
              ).getNewsEverything(filter: filter);
            } else {
              NewsHeadlinesCubit.get(context).getNewsHeadline(filter: filter);
            }

            Navigator.of(context).pop();
          },
        ),
      ),
    );
  }
}
