import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/News/components/card/news_list.dart';
import 'package:news/News/components/filter.dart/dialog.dart';
import 'package:news/News/cubit/news_cubit.dart';
import 'package:news/components/widget/retry_button.dart';
import 'package:news/components/widget/toast.dart';
import 'package:news/const/colors.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Latest News'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_alt),
            tooltip: 'Filter',
            onPressed: () => showFilterDialog(context),
          ),
        ],
      ),
      body: BlocConsumer<NewsCubit, NewsState>(
        listener: (BuildContext context, NewsState state) {
          if (state is NewsEverythingStateError) {
            showToast(msg: state.error, state: ToastStates.error);
          } else if (state is NewsEverythingStateBad) {
            showToast(msg: "Something went wrong", state: ToastStates.error);
          }
        },
        builder: (context, state) {
          if (state is NewsEverythingStateLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (NewsCubit.get(context).newsModel != null) {
            final newsList = NewsCubit.get(context).newsModel?.articles ?? [];
            return RefreshIndicator(
              color: primaryColor,
              backgroundColor: Colors.white,
              onRefresh: () async {
                await NewsCubit.get(context).getNewsEverything();
                Future.delayed(const Duration(seconds: 3));
              },
              child: NewsListView(newsList: newsList), // move logic here
            );
          } else if (state is NewsEverythingStateBad) {
            return RetryButton(
              onPressed: () async {
                await NewsCubit.get(context).getNewsEverything();
              },
            );
          } else if (state is NewsEverythingStateError) {
            return RetryButton(
              onPressed: () async {
                await NewsCubit.get(context).getNewsEverything();
              },
            );
          }
          return const Center(child: Text("No Data"));
        },
      ),
    );
  }
}
