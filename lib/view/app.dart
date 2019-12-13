import 'package:all/model/ui_data.dart';
import 'package:all/view/app/app.dart';
import 'package:all/view/detail/article_detail.dart';
import 'package:all/view/home/home.dart';
import 'package:all/view/image/image.dart';
import 'package:all/view/login/login.dart';
import 'package:all/view/not_found_page.dart';
import 'package:all/view/setting/setting.dart';
import 'package:all/view/user/user.dart';
import 'package:all/view/web/web.dart';
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
        primaryColorDark: Colors.grey,
        fontFamily: 'Siyuansong',
      ),
//    theme: CupertinoThemeData(
//      primaryColor: Colors.white,
//      primaryContrastingColor: Colors.blueGrey,
//      textTheme: CupertinoTextThemeData(
//        textStyle: TextStyle(
//          fontFamily: 'siyuansong'
//        )
//      )
//    ),
      home: HomePage(),
      routes: <String, WidgetBuilder>{
        UIData.ROUTE_HOME: (context) => HomePage(),
        UIData.ROUTE_APP: (context) => AppPage(),
        UIData.ROUTE_ARTICLE_DETAIL: (context) => ArticleDetailPage(),
        UIData.ROUTE_WEB: (context) => WebPage(),
        UIData.ROUTE_USER: (context) => UserPage(),
        UIData.ROUTE_SETTING: (context) => SettingPage(),
        UIData.ROUTE_LOGIN: (context) => LoginPage(),
        UIData.ROUTE_IMAGE: (context) => ImagePage(),
      },
      onUnknownRoute: (RouteSettings rs) =>
          MaterialPageRoute(builder: (context) => NotFoundPage()),
    );
  }
}
