import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_news_app/layout/news_app/cubit/cubit.dart';
import 'package:udemy_news_app/layout/news_app/cubit/states.dart';
import 'package:udemy_news_app/shared/components/components.dart';

class SearchScreen extends StatelessWidget {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var list = NewsCubit.get(context).search;
        var formKey = GlobalKey<FormState>();
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                  NewsCubit.get(context).search.clear();
                },
                icon: Icon(Icons.arrow_back),
              ),
            ),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: TextFormField(
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            100.0,
                          ),
                          borderSide: BorderSide(
                            color: NewsCubit.get(context).isDark == true
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                          100.0,
                        )),
                        prefixIcon: Icon(
                          Icons.search,
                          color: NewsCubit.get(context).isDark == true
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                      controller: searchController,
                      onFieldSubmitted: (value) {
                        formKey.currentState!.validate();
                      },
                      onChanged: (value) {
                        NewsCubit.get(context).getSearch(value);
                      },
                      keyboardType: TextInputType.text,
                      autofocus: true,
                      style: Theme.of(context).textTheme.bodyText1,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "No search text";
                        }
                      },
                    ),
                  ),
                ),
                Expanded(child: articleBuilder(list, context, isSearch: true)),
              ],
            ),
          ),
        );
      },
    );
  }
}
