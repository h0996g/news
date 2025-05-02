import 'package:hive/hive.dart';
import 'package:news/helper/hive/BD/news/news_model_hive.dart';

class HiveDB {
  // Box names
  static const String _everythingBox = "everythingBox";
  static const String _topHeadlinesBox = "topHeadlinesBox";

  // Initialize Hive and open necessary boxes
  static Future<void> initHive() async {
    Hive.registerAdapter(NewsModelHiveAdapter());
    Hive.registerAdapter(ArticleModelHiveAdapter());
    Hive.registerAdapter(SourceModelHiveAdapter());

    await Hive.openBox<NewsModelHive>(_everythingBox);
    await Hive.openBox<NewsModelHive>(_topHeadlinesBox);
  }

  // ========================= NEWS =========================

  static Future<void> saveEverything(NewsModelHive news) async {
    final box = Hive.box<NewsModelHive>(_everythingBox);
    await box.put('cached_news', news);
  }

  static NewsModelHive? getEverything() {
    final box = Hive.box<NewsModelHive>(_everythingBox);
    return box.get('cached_news');
  }

  static Future<void> deleteEverything() async {
    final box = Hive.box<NewsModelHive>(_everythingBox);
    await box.delete('cached_news');
  }

  // ==================== TOP HEADLINES =====================

  static Future<void> saveTopHeadlines(NewsModelHive news) async {
    final box = Hive.box<NewsModelHive>(_topHeadlinesBox);
    await box.put('cached_top_headlines', news);
  }

  static NewsModelHive? getTopHeadlines() {
    final box = Hive.box<NewsModelHive>(_topHeadlinesBox);
    return box.get('cached_top_headlines');
  }

  static Future<void> deleteTopHeadlines() async {
    final box = Hive.box<NewsModelHive>(_topHeadlinesBox);
    await box.delete('cached_top_headlines');
  }

  // ==================== CLEAR UTILITY ======================

  static Future<void> clearAll() async {
    await Hive.box<NewsModelHive>(_everythingBox).clear();
    await Hive.box<NewsModelHive>(_topHeadlinesBox).clear();
  }
}
