import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:news/const/const.dart';

class CustomCacheManager {
  static CacheManager instance = CacheManager(
    Config(
      customCacheKey,
      stalePeriod: const Duration(days: 2), // Cache expires in 2 days
      maxNrOfCacheObjects: 100,
    ),
  );
}
