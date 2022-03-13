import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:udemy_news_app/layout/news_app/cubit/cubit.dart';
import 'package:udemy_news_app/modules/web_view/web_view_screen.dart';

Widget buildArticleItem(article, context) => InkWell(
      onTap: () {
        navToScreen(context, WebViewScreen('${article['url']}'));
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Container(
              height: 120.0,
              width: 120.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                image: DecorationImage(
                  image: NetworkImage('${article['urlToImage']}'),
                  onError: (Object exception, StackTrace? stackTrace) {
                    print('Unable to load the image for article');
                  },
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Container(
                height: 120.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        '${article['title']}',
                        style: Theme.of(context).textTheme.bodyText1,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      '${article['publishedAt']}',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );

Widget listDivider() => Padding(
      padding: const EdgeInsetsDirectional.only(
        start: 20.0,
      ),
      child: Container(
        width: double.infinity,
        height: 1.0,
        color: Colors.grey[300],
      ),
    );

Widget loadingIndicator() => Center(
      child: Container(
        width: 200.0,
        child: LinearProgressIndicator(),
      ),
    );

Widget articleBuilder(list, context, {isSearch = false}) => ConditionalBuilder(
      condition: list.length > 0,
      builder: (context) {
        return ListView.separated(
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) =>
                buildArticleItem(list[index], context),
            separatorBuilder: (context, index) => listDivider(),
            itemCount: list.length);
      },
      fallback: (context) => isSearch ? Container() : loadingIndicator(),
    );

void navToScreen(context, Screen) => Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => Screen,
    ));
