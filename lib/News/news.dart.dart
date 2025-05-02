import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/News/components/card/news_list.dart';
import 'package:news/News/components/filter.dart/dialog.dart';
import 'package:news/News/cubit/news_cubit.dart';
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
      body: BlocBuilder<NewsCubit, NewsState>(
        builder: (context, state) {
          if (state is NewsEverythingStateLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is NewsEverythingStateError) {
            return Center(child: Text(state.error));
          } else if (state is NewsEverythingStateBad) {
            return const Center(child: Text("Something went wrong"));
          } else if (state is NewsEverythingStateSuccess) {
            final newsList = state.newsModel.articles ?? [];
            return RefreshIndicator(
              color: primaryColor,
              backgroundColor: Colors.white,
              onRefresh: () async {
                await NewsCubit.get(context).getNewsEverything();
                Future.delayed(const Duration(seconds: 3));
              },
              child: NewsListView(newsList: newsList), // move logic here
            );
          }
          return const Center(child: Text("No Data"));
        },
      ),
    );
  }
}
