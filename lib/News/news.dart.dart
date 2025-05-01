import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/News/cubit/news_cubit.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('News Screen')),
      body: BlocBuilder<NewsCubit, NewsState>(
        builder: (context, state) {
          return Column();
        },
      ),
    );
  }
}
