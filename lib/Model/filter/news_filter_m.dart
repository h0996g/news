import 'package:news/const/const.dart';
import 'package:news/helper/cach.dart';

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

  Map<String, String?> toCacheMap() => {
    kFilterFromDate: from?.toIso8601String(),
    kFilterToDate: to?.toIso8601String(),
    kFilterSource: source,
  };

  static NewsFilterModel fromCache() {
    return NewsFilterModel(
      from: _getDate(kFilterFromDate),
      to: _getDate(kFilterToDate),
      source: CachHelper.getData(key: kFilterSource),
    );
  }
}

DateTime? _getDate(String key) {
  final val = CachHelper.getData(key: key);
  return val != null ? DateTime.tryParse(val) : null;
}
