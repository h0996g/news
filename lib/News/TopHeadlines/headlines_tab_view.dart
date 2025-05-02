import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/News/TopHeadlines/cubit/news_headlines_cubit.dart';
import 'package:news/News/components/card/news_list.dart';
import 'package:news/News/components/card/shimmer/news_card_shimmer.dart';
import 'package:news/components/widget/refresh.dart';
import 'package:news/components/widget/retry_button.dart';
import 'package:news/components/widget/toast.dart';

class HeadlinesTabView extends StatelessWidget {
  final bool isEverything;
  const HeadlinesTabView({super.key, required this.isEverything});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsHeadlinesCubit, NewsHeadlinesState>(
      listener: (context, state) {
        if (state is NewsHeadlinesStateError) {
          showToast(msg: state.error, state: ToastStates.error);
        } else if (state is NewsHeadlinesStateBad) {
          showToast(msg: "Something went wrong", state: ToastStates.error);
        }
      },
      builder: (context, state) {
        final cubit = NewsHeadlinesCubit.get(context);
        if (state is NewsHeadlinesStateLoading) {
          return ListView.builder(
            itemCount: 4,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(10),
                child: NewsCardShimmer(),
              );
            },
          );
        } else if (cubit.newsModel != null) {
          if (cubit.newsModel?.articles?.isEmpty == true) {
            return const Center(child: Text("No news found"));
          }
          final newsList = cubit.newsModel?.articles;
          return RefreshableNewsList(
            onRefresh: () async {
              await cubit.getNewsHeadline();
              await Future.delayed(const Duration(seconds: 2));
            },
            child: NewsListView(
              newsList: newsList ?? [],
              isEveything: isEverything,
            ),
          );
        } else {
          return RetryButton(
            onPressed: () async {
              await cubit.getNewsHeadline();
            },
          );
        }
      },
    );
  }
}
