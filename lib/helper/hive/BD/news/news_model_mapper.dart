import 'package:news/Model/news/news_model.dart';

import 'news_model_hive.dart';

extension NewsModelMapper on NewsModel {
  NewsModelHive toHiveModel() => NewsModelHive(
    status: status,
    totalResults: totalResults,
    articles: articles?.map((e) => e.toHiveModel()).toList(),
  );
}

extension NewsModelHiveMapper on NewsModelHive {
  NewsModel toFreezedModel() => NewsModel(
    status: status,
    totalResults: totalResults,
    articles: articles?.map((e) => e.toFreezedModel()).toList(),
  );
}

extension ArticleMapper on ArticleModel {
  ArticleModelHive toHiveModel() => ArticleModelHive(
    source: source?.toHiveModel(),
    author: author,
    title: title,
    description: description,
    url: url,
    urlToImage: urlToImage,
    publishedAt: publishedAt,
    content: content,
  );
}

extension ArticleHiveMapper on ArticleModelHive {
  ArticleModel toFreezedModel() => ArticleModel(
    source: source?.toFreezedModel(),
    author: author,
    title: title,
    description: description,
    url: url,
    urlToImage: urlToImage,
    publishedAt: publishedAt,
    content: content,
  );
}

extension SourceMapper on SourceModel {
  SourceModelHive toHiveModel() => SourceModelHive(id: id, name: name);
}

extension SourceHiveMapper on SourceModelHive {
  SourceModel toFreezedModel() => SourceModel(id: id, name: name);
}
