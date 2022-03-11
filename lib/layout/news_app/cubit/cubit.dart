import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_news_app/layout/news_app/cubit/states.dart';
import 'package:udemy_news_app/modules/business/business_screen.dart';
import 'package:udemy_news_app/modules/science/science_screen.dart';
import 'package:udemy_news_app/modules/settings/settings_screen.dart';
import 'package:udemy_news_app/modules/sports/sports_screen.dart';
import 'package:udemy_news_app/shared/components/constants.dart';
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
  ];

  void changeBottomNavBar(int index) {
    currentIndex = index;
    emit(NewsBottomNavState());
  }

  List<dynamic> business = [];
  int businessTotalResults = 0;
  List<dynamic> science = [];
  int scienceTotalResults = 0;
  List<dynamic> sports = [];
  int sportsTotalResults = 0;

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
      businessTotalResults = value.data['totalResults'];
      emit(NewsGetBusinessSuccessState());
    }).catchError((error) {
      print('Error: ${error.toString()}');
      emit(NewsGetBusinessErrorState(error.toString()));
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
      scienceTotalResults = value.data['totalResults'];
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
      sportsTotalResults = value.data['totalResults'];
      emit(NewsGetSportsSuccessState());
    }).catchError((error) {
      print('Error: ${error.toString()}');
      emit(NewsGetSportsErrorState(error.toString()));
    });
  }

  ThemeMode appMode = ThemeMode.light;
  Icon themeIcon = Icon(Icons.dark_mode);

  void changeAppMode() {
    if (appMode == ThemeMode.light) {
      appMode = ThemeMode.dark;
      themeIcon = Icon(Icons.light_mode);
      emit(NewsGetDarkTheme());
    } else {
      appMode = ThemeMode.light;
      themeIcon = Icon(Icons.dark_mode);
      emit(NewsGetLightTheme());
    }
  }
}
