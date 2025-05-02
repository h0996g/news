import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news/News/Everything/cubit/news_everything_cubit.dart';
import 'package:news/News/TopHeadlines/cubit/news_headlines_cubit.dart';
import 'package:news/api/dio.dart';
import 'package:news/components/widget/no_internet.dart';
import 'package:news/cubit/main_cubit.dart';
import 'package:news/helper/cach.dart';
import 'package:news/helper/environment.dart';
import 'package:news/helper/hive/BD/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:news/helper/observer.dart';
import 'package:news/route.dart';
import 'package:news/them.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CachHelper.init();

  await dotenv.load(fileName: Enviroment.fileName);
  Bloc.observer = MyBlocObserver();
  VPSDio.init();
  await Hive.initFlutter();
  await HiveDB.initHive(); // Initialize Hive

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => NewsEverythingCubit()..getNewsEverything(),
          ),
          BlocProvider(create: (_) => NewsHeadlinesCubit()..getNewsHeadline()),
          BlocProvider(create: (context) => MainCubit()..startConnectivity()),
        ],
        child: BlocBuilder<MainCubit, MainState>(
          builder: (context, state) {
            return MaterialApp.router(
              routerConfig: AppRouter.router,
              debugShowCheckedModeBanner: false,

              theme: AppThemes.lightTheme,
              themeMode: ThemeMode.light,
              darkTheme: AppThemes.darkTheme,
              builder: (context, child) {
                return Stack(
                  children: [child!, if (state is NoConnection) NoInternet()],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
