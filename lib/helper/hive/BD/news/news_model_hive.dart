import 'package:hive/hive.dart';

part 'news_model_hive.g.dart';

@HiveType(typeId: 0)
class NewsModelHive extends HiveObject {
  @HiveField(0)
  String? status;

  @HiveField(1)
  int? totalResults;

  @HiveField(2)
  List<ArticleModelHive>? articles;

  NewsModelHive({this.status, this.totalResults, this.articles});
}

@HiveType(typeId: 1)
class ArticleModelHive extends HiveObject {
  @HiveField(0)
  SourceModelHive? source;

  @HiveField(1)
  String? author;

  @HiveField(2)
  String? title;

  @HiveField(3)
  String? description;

  @HiveField(4)
  String? url;

  @HiveField(5)
  String? urlToImage;

  @HiveField(6)
  DateTime? publishedAt;

  @HiveField(7)
  String? content;

  ArticleModelHive({
    this.source,
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
  });
}

@HiveType(typeId: 2)
class SourceModelHive extends HiveObject {
  @HiveField(0)
  String? id;

  @HiveField(1)
  String? name;

  SourceModelHive({this.id, this.name});
}
