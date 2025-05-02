import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/News/Everything/cubit/news_everything_cubit.dart';
import 'package:news/News/components/card/news_list.dart';
import 'package:news/News/components/card/shimmer/news_List_shimmer.dart';
import 'package:news/components/widget/refresh.dart';
import 'package:news/components/widget/retry_button.dart';
import 'package:news/components/widget/toast.dart';

class EverythingTabView extends StatelessWidget {
  final bool isEverything;
  const EverythingTabView({super.key, required this.isEverything});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsEverythingCubit, NewsEverythingState>(
      listener: (context, state) {
        if (state is NewsEverythingStateError) {
          showToast(msg: state.error, state: ToastStates.error);
        }
      },
      builder: (context, state) {
        final cubit = NewsEverythingCubit.get(context);
        if (state is NewsEverythingStateLoading) {
          return NewsListShimmer();
        } else if (cubit.newsModel != null) {
          final newsList = cubit.newsModel?.articles ?? [];
          return RefreshableNewsList(
            onRefresh: () async {
              await cubit.getNewsEverything();
              await Future.delayed(const Duration(seconds: 2));
            },
            child: NewsListView(newsList: newsList, isEveything: isEverything),
          );
        } else {
          return RetryButton(
            onPressed: () async {
              await cubit.getNewsEverything();
            },
          );
        }
      },
    );
  }
}
