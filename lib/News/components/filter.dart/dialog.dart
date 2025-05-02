import 'package:flutter/material.dart';
import 'package:news/Model/filter/news_filter_m.dart';
import 'package:news/News/components/filter.dart/filter.dart';
import 'package:news/News/cubit/news_cubit.dart';
import 'package:news/helper/cach.dart';

void showFilterDialog(BuildContext context) {
  final initialFilter = NewsFilterModel.fromCache();

  showDialog(
    context: context,
    builder:
        (context) => Center(
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
                final filter = NewsFilterModel(
                  from: from,
                  to: to,
                  source: source,
                );

                // Save to cache
                filter.toCacheMap().forEach((key, value) {
                  if (value != null) {
                    CachHelper.putcache(key: key, value: value);
                  }
                });

                // Pass filter directly to Cubit
                NewsCubit.get(context).getNewsEverything(filter: filter);

                Navigator.of(context).pop();
              },
            ),
          ),
        ),
  );
}
