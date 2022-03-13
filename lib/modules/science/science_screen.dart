import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_news_app/layout/news_app/cubit/cubit.dart';
import 'package:udemy_news_app/layout/news_app/cubit/states.dart';
import 'package:udemy_news_app/shared/components/components.dart';

class ScienceScreen extends StatelessWidget {
  const ScienceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      builder: (context, state) {
        var list = NewsCubit.get(context).science;
        return RefreshIndicator(
            child: articleBuilder(list, context),
            onRefresh: () {
              return Future.delayed(Duration(seconds: 1)).then((value) {
                NewsCubit.get(context).science = [];
                NewsCubit.get(context).getScience();
              });
            });
      },
      listener: (context, state) {},
    );
  }
}
