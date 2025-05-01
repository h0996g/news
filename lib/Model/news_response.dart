// news_models_nullable.dart
import 'dart:convert';

/// Top-level response
class NewsModel {
  final String? status;
  final int? totalResults;
  final List<ArticleModel>? articles;

  NewsModel({this.status, this.totalResults, this.articles});

  factory NewsModel.fromJson(Map<String, dynamic> json) => NewsModel(
    status: json['status'],
    totalResults: json['totalResults'],
    articles:
        (json['articles'] is List)
            ? (json['articles'] as List)
                .map((e) => ArticleModel.fromJson(e as Map<String, dynamic>))
                .toList()
            : null,
  );

  Map<String, dynamic> toJson() => {
    'status': status,
    'totalResults': totalResults,
    'articles': articles?.map((e) => e.toJson()).toList(),
  };

  factory NewsModel.fromRawJson(String source) =>
      NewsModel.fromJson(json.decode(source));
}

/// Individual article
class ArticleModel {
  final SourceModel? source;
  final String? author;
  final String? title;
  final String? description;
  final String? url;
  final String? urlToImage;
  final DateTime? publishedAt;
  final String? content;

  ArticleModel({
    this.source,
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) => ArticleModel(
    source:
        json['source'] != null
            ? SourceModel.fromJson(json['source'] as Map<String, dynamic>)
            : null,
    author: json['author'],
    title: json['title'],
    description: json['description'],
    url: json['url'],
    urlToImage: json['urlToImage'],
    publishedAt:
        json['publishedAt'] != null
            ? DateTime.tryParse(json['publishedAt'])
            : null,
    content: json['content'],
  );

  Map<String, dynamic> toJson() => {
    'source': source?.toJson(),
    'author': author,
    'title': title,
    'description': description,
    'url': url,
    'urlToImage': urlToImage,
    'publishedAt': publishedAt?.toIso8601String(),
    'content': content,
  };
}

/// Article source
class SourceModel {
  final String? id;
  final String? name;

  SourceModel({this.id, this.name});

  factory SourceModel.fromJson(Map<String, dynamic> json) =>
      SourceModel(id: json['id'], name: json['name']);

  Map<String, dynamic> toJson() => {'id': id, 'name': name};
}
