import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_news_app/layout/news_app/cubit/cubit.dart';
import 'package:udemy_news_app/layout/news_app/cubit/states.dart';
import 'package:udemy_news_app/shared/components/components.dart';

class SportsScreen extends StatelessWidget {
  const SportsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      builder: (context, state) {
        var list = NewsCubit.get(context).sports;
        return articleBuilder(list, context);
      },
      listener: (context, state) {},
    );
  }
}
