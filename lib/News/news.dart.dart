import 'package:flutter/material.dart';
import 'package:news/News/Everything/everything_tab_view.dart';
import 'package:news/News/TopHeadlines/headlines_tab_view.dart';
import 'package:news/News/components/filter.dart/dialog.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Latest News'),
          centerTitle: true,
          actions: [
            Builder(
              builder:
                  (context) => IconButton(
                    icon: const Icon(Icons.filter_alt),
                    tooltip: 'Filter',
                    onPressed: () {
                      final tabIndex = DefaultTabController.of(context).index;
                      final isEverything = tabIndex == 0;
                      showDialog(
                        context: context,
                        builder:
                            (context) =>
                                NewsFilterDialog(isEverything: isEverything),
                      );
                    },
                  ),
            ),
          ],
          bottom: const TabBar(
            indicatorColor: Colors.black,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            tabs: [Tab(text: "Everything"), Tab(text: "Top Headlines")],
          ),
        ),
        body: const TabBarView(
          children: [EverythingTabView(), HeadlinesTabView()],
        ),
      ),
    );
  }
}
