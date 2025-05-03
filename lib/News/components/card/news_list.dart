import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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

        _loadMore();
      }
    } else {
      if (isAtBottom) {
        isAtBottom = false;
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
    final screenWidth = 1.sw;
    final isLargeScreen = screenWidth > 700;

    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(10.w),
            child:
                isLargeScreen
                    ? GridView.builder(
                      controller: _scrollController,
                      itemCount: widget.newsList.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12.w,
                        mainAxisSpacing: 12.h,
                        childAspectRatio: 3 / 4.5,
                      ),
                      itemBuilder: (context, index) {
                        final article = widget.newsList[index];
                        return NewsCard(article: article);
                      },
                    )
                    : ListView.builder(
                      controller: _scrollController,
                      itemCount: widget.newsList.length,
                      itemBuilder: (context, index) {
                        final article = widget.newsList[index];
                        return NewsCard(article: article);
                      },
                    ),
          ),
        ),
        if (isLoadingMore)
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16.h),
            child: const CircularProgressIndicator(),
          ),
      ],
    );
  }
}
