import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:news/api/dio.dart';
import 'package:news/helper/environment.dart';
import 'package:news/helper/hive/hive.dart';
import 'package:news/helper/observer.dart';

class AppInitializer {
  static Future<void> initialize() async {
    WidgetsFlutterBinding.ensureInitialized();

    await dotenv.load(fileName: Enviroment.fileName);

    Bloc.observer = MyBlocObserver();
    VPSDio.init();

    await Hive.initFlutter();
    await HiveDB.initHive();
  }
}
