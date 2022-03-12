import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:udemy_news_app/layout/news_app/cubit/cubit.dart';
import 'package:udemy_news_app/layout/news_app/cubit/states.dart';
import 'package:udemy_news_app/shared/bloc_observer.dart';
import 'package:udemy_news_app/shared/network/local/cache_helper.dart';
import 'package:udemy_news_app/shared/network/remote/dio_helper.dart';
import 'package:udemy_news_app/shared/styles/styles.dart';

import 'layout/news_app/news_layout.dart';

void main() {
  BlocOverrides.runZoned(
    () async {
      // Use blocs...
      WidgetsFlutterBinding.ensureInitialized();
      DioHelper.init();
      await CacheHelper.init();
      runApp(const MyApp());
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewsCubit()
        ..getThemeData()
        ..getBusiness()
        ..getScience()
        ..getSports(),
      child: BlocConsumer<NewsCubit, NewsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: "News App",
            home: NewsLayout(),
            theme: myThemeData(),
            darkTheme: myDarkThemeData(),
            themeMode: NewsCubit.get(context).appMode,
          );
        },
      ),
    );
  }
}
