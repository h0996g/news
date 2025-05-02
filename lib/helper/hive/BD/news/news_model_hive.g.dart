// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_model_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NewsModelHiveAdapter extends TypeAdapter<NewsModelHive> {
  @override
  final int typeId = 0;

  @override
  NewsModelHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NewsModelHive(
      status: fields[0] as String?,
      totalResults: fields[1] as int?,
      articles: (fields[2] as List?)?.cast<ArticleModelHive>(),
    );
  }

  @override
  void write(BinaryWriter writer, NewsModelHive obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.status)
      ..writeByte(1)
      ..write(obj.totalResults)
      ..writeByte(2)
      ..write(obj.articles);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NewsModelHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ArticleModelHiveAdapter extends TypeAdapter<ArticleModelHive> {
  @override
  final int typeId = 1;

  @override
  ArticleModelHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ArticleModelHive(
      source: fields[0] as SourceModelHive?,
      author: fields[1] as String?,
      title: fields[2] as String?,
      description: fields[3] as String?,
      url: fields[4] as String?,
      urlToImage: fields[5] as String?,
      publishedAt: fields[6] as DateTime?,
      content: fields[7] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ArticleModelHive obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.source)
      ..writeByte(1)
      ..write(obj.author)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.url)
      ..writeByte(5)
      ..write(obj.urlToImage)
      ..writeByte(6)
      ..write(obj.publishedAt)
      ..writeByte(7)
      ..write(obj.content);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ArticleModelHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class SourceModelHiveAdapter extends TypeAdapter<SourceModelHive> {
  @override
  final int typeId = 2;

  @override
  SourceModelHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SourceModelHive(
      id: fields[0] as String?,
      name: fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, SourceModelHive obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SourceModelHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
