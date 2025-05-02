import 'package:freezed_annotation/freezed_annotation.dart';

part 'news_model.freezed.dart';
part 'news_model.g.dart';

@freezed
@JsonSerializable(explicitToJson: true)
class NewsModel with _$NewsModel {
  const factory NewsModel({
    String? status,
    int? totalResults,
    List<ArticleModel>? articles,
  }) = _NewsModel;

  factory NewsModel.fromJson(Map<String, dynamic> json) =>
      _$NewsModelFromJson(json);
}

@freezed
@JsonSerializable(explicitToJson: true)
class ArticleModel with _$ArticleModel {
  const factory ArticleModel({
    SourceModel? source,
    String? author,
    String? title,
    String? description,
    String? url,
    String? urlToImage,
    DateTime? publishedAt,
    String? content,
  }) = _ArticleModel;

  factory ArticleModel.fromJson(Map<String, dynamic> json) =>
      _$ArticleModelFromJson(json);
}

@freezed
@JsonSerializable()
class SourceModel with _$SourceModel {
  const factory SourceModel({String? id, String? name}) = _SourceModel;

  factory SourceModel.fromJson(Map<String, dynamic> json) =>
      _$SourceModelFromJson(json);
}
