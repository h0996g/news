import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:news/News/news.dart.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class RouteConstants {
  // static const String initial = '/';
  // ----------------- news -----------------
  static const String news = '/news';

  static String getSignupPath() => news;
}

class AppRouter {
  static final GoRouter router = GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: RouteConstants.news,
    routes: <RouteBase>[
      GoRoute(
        path: RouteConstants.news,
        builder: (context, state) => const NewsScreen(),
      ),
    ],
  );
}
