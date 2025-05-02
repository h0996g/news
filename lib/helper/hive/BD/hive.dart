import 'package:hive/hive.dart';
import 'package:news/helper/hive/BD/news/news_model_hive.dart';

class HiveDB {
  static const String _newsBox = "infoBox";

  static Future<void> initHive() async {
    Hive.registerAdapter(NewsModelHiveAdapter());
    Hive.registerAdapter(ArticleModelHiveAdapter());
    Hive.registerAdapter(SourceModelHiveAdapter());

    await Hive.openBox<NewsModelHive>(_newsBox);
  }

  static Future<void> saveNews(NewsModelHive news) async {
    final box = Hive.box<NewsModelHive>(_newsBox);
    await box.put('cached_news', news);
  }

  static NewsModelHive? getNews() {
    final box = Hive.box<NewsModelHive>(_newsBox);
    return box.get('cached_news');
  }

  static Future<void> deleteNews() async {
    final box = Hive.box<NewsModelHive>(_newsBox);
    await box.delete('cached_news');
  }
}
