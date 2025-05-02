import 'package:flutter/material.dart';
import 'package:news/Model/filter/news_filter_m.dart';
import 'package:news/News/TopHeadlines/cubit/news_headlines_cubit.dart';
import 'package:news/News/components/filter.dart/filter.dart';
import 'package:news/News/Everything/cubit/news_everything_cubit.dart';
import 'package:news/const/const.dart';

class NewsFilterDialog extends StatelessWidget {
  final bool isEverything;

  const NewsFilterDialog({super.key, required this.isEverything});

  @override
  Widget build(BuildContext context) {
    final initialFilter =
        isEverything
            ? (defaultEverythingFilter ?? NewsFilterModel.empty())
            : (defaultHeadlinesFilter ?? NewsFilterModel.empty());

    return Center(
      child: Dialog(
        child: NewsFilterWidget(
          isEverything: isEverything,
          initialFrom: initialFilter.from,
          initialTo: initialFilter.to,
          initialSource: initialFilter.source,
          onApply: ({
            required DateTime? from,
            required String? source,
            required DateTime? to,
          }) {
            final filter = NewsFilterModel(from: from, to: to, source: source);

            if (isEverything) {
              defaultEverythingFilter = filter;
              NewsEverythingCubit.get(context).getNewsEverything();
            } else {
              defaultHeadlinesFilter = filter;
              NewsHeadlinesCubit.get(context).getNewsHeadline();
            }

            Navigator.of(context).pop();
          },
        ),
      ),
    );
  }
}
