import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_news_app/layout/news_app/cubit/states.dart';
import 'package:udemy_news_app/modules/business/business_screen.dart';
import 'package:udemy_news_app/modules/science/science_screen.dart';
import 'package:udemy_news_app/modules/search/search_screen.dart';
import 'package:udemy_news_app/modules/settings/settings_screen.dart';
import 'package:udemy_news_app/modules/sports/sports_screen.dart';
import 'package:udemy_news_app/shared/components/constants.dart';
import 'package:udemy_news_app/shared/network/local/cache_helper.dart';
import 'package:udemy_news_app/shared/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.business),
      label: 'Business',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.sports),
      label: 'Sports',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.science),
      label: 'Science',
    ),
  ];

  List<Widget> screens = [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
    SearchScreen(),
  ];

  void changeBottomNavBar(int index) {
    currentIndex = index;
    emit(NewsBottomNavState());
  }

  List<dynamic> business = [];
  List<dynamic> science = [];
  List<dynamic> sports = [];
  List<dynamic> search = [];

  void getBusiness() {
    emit(NewsGetBusinessLoadingState());
    DioHelper.getData(
      url: newsTopHeadlinesURL,
      query: {
        'country': newsCountry,
        'category': 'business',
        'apiKey': newsApiKey,
      },
    ).then((value) {
      // print(value.data.toString());
      business = value.data['articles'];
      emit(NewsGetBusinessSuccessState());
    }).catchError((error) {
      print('Error: ${error.toString()}');
      emit(NewsGetBusinessErrorState(error.toString()));
    });
  }

  void getSearch(value) {
    emit(NewsGetSearchLoadingState());
    DioHelper.getData(
      url: newsSearchURL,
      query: {
        'q': '$value',
        'apiKey': newsApiKey,
      },
    ).then((value) {
      // print(value.data.toString());
      search = value.data['articles'];
      emit(NewsGetSearchSuccessState());
    }).catchError((error) {
      print('Error: ${error.toString()}');
      emit(NewsGetSearchErrorState(error.toString()));
    });
  }

  void getScience() {
    emit(NewsGetScienceLoadingState());
    DioHelper.getData(
      url: newsTopHeadlinesURL,
      query: {
        'country': newsCountry,
        'category': 'science',
        'apiKey': newsApiKey,
      },
    ).then((value) {
      // print(value.data.toString());
      science = value.data['articles'];
      emit(NewsGetScienceSuccessState());
    }).catchError((error) {
      print('Error: ${error.toString()}');
      emit(NewsGetScienceErrorState(error.toString()));
    });
  }

  void getSports() {
    emit(NewsGetSportsLoadingState());
    DioHelper.getData(
      url: newsTopHeadlinesURL,
      query: {
        'country': newsCountry,
        'category': 'sports',
        'apiKey': newsApiKey,
      },
    ).then((value) {
      // print(value.data.toString());
      sports = value.data['articles'];
      emit(NewsGetSportsSuccessState());
    }).catchError((error) {
      print('Error: ${error.toString()}');
      emit(NewsGetSportsErrorState(error.toString()));
    });
  }

  late ThemeMode appMode;
  late Icon themeIcon;
  late bool isDark;

  void getThemeData() {
    if (CacheHelper.getBool(key: 'isDark') != null) {
      isDark = CacheHelper.getBool(key: 'isDark')!;
      isDark == true ? setDarkTheme() : setLightTheme();
    } else {
      setLightTheme();
    }
  }

  void changeAppMode() {
    if (!isDark) {
      setDarkTheme();
    } else {
      setLightTheme();
    }
  }

  void setLightTheme() {
    appMode = ThemeMode.light;
    themeIcon = Icon(Icons.dark_mode);
    CacheHelper.setBool(key: 'isDark', value: false);
    isDark = false;
    emit(NewsGetLightTheme());
  }

  void setDarkTheme() {
    appMode = ThemeMode.dark;
    themeIcon = Icon(Icons.light_mode);
    CacheHelper.setBool(key: 'isDark', value: true);
    isDark = true;
    emit(NewsGetDarkTheme());
  }
}
