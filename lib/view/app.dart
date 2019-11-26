import 'package:all/model/ui_data.dart';
import 'package:all/view/app/app.dart';
import 'package:all/view/detail/article_detail.dart';
import 'package:all/view/home/home.dart';
import 'package:all/view/not_found_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.white,
        primarySwatch: Colors.blueGrey,
      ),
//      theme: CupertinoThemeData(
//        primaryColor: Colors.white,
//        primaryContrastingColor: Colors.blueGrey,
//        brightness: Brightness.light
//      ),
      home: HomePage(),
      routes: <String, WidgetBuilder> {
        UIData.ROUTE_HOME: (context) => HomePage(),
        UIData.ROUTE_APP: (context) => AppPage(),
        UIData.ROUTE_ARTICLE_DETAIL: (context) => ArticleDetailTestPage(),
      },
      onUnknownRoute: (RouteSettings rs) => MaterialPageRoute(builder: (context) => NotFoundPage()),
    );
  }
}