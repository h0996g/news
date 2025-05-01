import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Enviroment {
  static String get fileName {
    if (kReleaseMode) {
      return '.env.production';
    } else {
      return '.env.devlopment';
    }
  }

  static String get baseUrl {
    return dotenv.env['baseUrl'] ?? 'URL_NOT_FOUND';
  }

  static String get apiKey {
    return dotenv.env['apiKey'] ?? 'API_KEY_NOT_FOUND';
  }
}
