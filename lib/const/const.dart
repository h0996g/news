// ----------------- Cache -----------------
import 'package:news/Model/filter/news_filter_m.dart';

const langCache = 'lang';
const isDarkModeCache = 'isDarkMode';
const String kFilterFromDate = 'filter_from_date';
const String kFilterToDate = 'filter_to_date';
const String kFilterSource = 'filter_source';
const String customCacheKey = "customCacheKey";

// ----------------- constants -----------------
NewsFilterModel? defaultEverythingFilter;
NewsFilterModel? defaultHeadlinesFilter;
