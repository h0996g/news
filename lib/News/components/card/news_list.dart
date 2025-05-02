import 'package:flutter/material.dart';
import 'package:news/News/TopHeadlines/cubit/news_headlines_cubit.dart';
import 'package:news/News/components/card/news_card.dart';
import 'package:news/Model/news/news_model.dart';
import 'package:news/News/Everything/cubit/news_everything_cubit.dart';

class NewsListView extends StatefulWidget {
  final List<ArticleModel> newsList;
  final bool isEveything;

  const NewsListView({
    super.key,
    required this.newsList,
    required this.isEveything,
  });

  @override
  State<NewsListView> createState() => _NewsListViewState();
}

class _NewsListViewState extends State<NewsListView> {
  final ScrollController _scrollController = ScrollController();

  bool isAtBottom = false;
  bool isLoadingMore = false;
  int currentPage = 1;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      if (!isAtBottom && !isLoadingMore) {
        isAtBottom = true;
        print("Reached bottom");

        _loadMore();
      }
    } else {
      if (isAtBottom) {
        isAtBottom = false;
        print("Left bottom");
      }
    }
  }

  Future<void> _loadMore() async {
    setState(() {
      isLoadingMore = true;
      currentPage += 1;
    });
    if (widget.isEveything) {
      await NewsEverythingCubit.get(
        context,
      ).getNewsEverything(page: currentPage, isLoadMore: true);
    } else {
      await NewsHeadlinesCubit.get(
        context,
      ).getNewsHeadline(page: currentPage, isLoadMore: true);
    }

    setState(() {
      isLoadingMore = false;
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            controller: _scrollController,
            padding: const EdgeInsets.all(10),
            itemCount: widget.newsList.length,
            itemBuilder: (context, index) {
              final article = widget.newsList[index];
              return NewsCard(article: article);
            },
          ),
        ),
        if (isLoadingMore)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: CircularProgressIndicator(),
          ),
      ],
    );
  }
}
