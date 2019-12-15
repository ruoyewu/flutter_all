import 'package:all/model/ui_data.dart';
import 'package:all/model/user_theme.dart';
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
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'All',
      theme: UserTheme.light(),
      darkTheme: UserTheme.dark(),
      home: HomePage(),
      routes: <String, WidgetBuilder>{
        UIData.ROUTE_HOME: (context) => HomePage(),
        UIData.ROUTE_APP: (context) => AppPage(),
        UIData.ROUTE_ARTICLE_DETAIL: (context) => ArticleDetailListPage(),
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
