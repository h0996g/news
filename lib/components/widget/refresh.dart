import 'package:flutter/material.dart';
import 'package:news/const/colors.dart';

class RefreshableNewsList extends StatelessWidget {
  final Future<void> Function() onRefresh;
  final Widget child;

  const RefreshableNewsList({
    super.key,

    required this.onRefresh,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: primaryColor,
      backgroundColor: Colors.white,
      onRefresh: onRefresh,
      child: child,
    );
  }
}
