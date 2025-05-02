class NewsFilterModel {
  final DateTime? from;
  final DateTime? to;
  final String? source;

  const NewsFilterModel({
    required this.from,
    required this.to,
    required this.source,
  });

  factory NewsFilterModel.empty() =>
      const NewsFilterModel(from: null, to: null, source: null);

  bool get isEmpty =>
      from == null && to == null && (source == null || source!.isEmpty);
}
