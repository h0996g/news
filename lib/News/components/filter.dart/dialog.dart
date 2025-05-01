import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/News/components/filter.dart/filter.dart';
import 'package:news/News/cubit/news_cubit.dart';
import 'package:news/const/const.dart';
import 'package:news/helper/cach.dart';

void showFilterDialog(BuildContext context) {
  showDialog(
    context: context,
    builder:
        (context) => Center(
          child: Dialog(
            child: NewsFilterWidget(
              initialFrom: _getDate(kFilterFromDate),
              initialTo: _getDate(kFilterToDate),
              initialSource: CachHelper.getData(key: kFilterSource),
              onApply: ({
                required DateTime? from,
                required DateTime? to,
                required String? source,
              }) {
                if (from != null) {
                  CachHelper.putcache(
                    key: kFilterFromDate,
                    value: from.toIso8601String(),
                  );
                }
                if (to != null) {
                  CachHelper.putcache(
                    key: kFilterToDate,
                    value: to.toIso8601String(),
                  );
                }
                if (source != null) {
                  CachHelper.putcache(key: kFilterSource, value: source);
                }

                context.read<NewsCubit>().getNewsEverything(
                  fromDate: from?.toIso8601String(),
                  toDate: to?.toIso8601String(),
                  source: source,
                );
                Navigator.of(context).pop();
              },
            ),
          ),
        ),
  );
}

DateTime? _getDate(String key) {
  final val = CachHelper.getData(key: key);
  return val != null ? DateTime.tryParse(val) : null;
}
