import 'package:all/model/ui_data.dart';
import 'package:all/model/user_color.dart';
import 'package:all/model/user_theme.dart';
import 'package:all/utils/decive_utils.dart';
import 'package:all/view/app/app.dart';
import 'package:all/view/app/app_channel.dart';
import 'package:all/view/detail/article_detail.dart';
import 'package:all/view/home/home.dart';
import 'package:all/view/image/image.dart';
import 'package:all/view/login/login.dart';
import 'package:all/view/not_found_page.dart';
import 'package:all/view/search/recommend_list.dart';
import 'package:all/view/search/section_list.dart';
import 'package:all/view/setting/setting.dart';
import 'package:all/view/test/test.dart';
import 'package:all/view/user/user.dart';
import 'package:all/view/web/web.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum Type {
  MATERIAL,
  CUPRETINO
}

class MyApp extends StatelessWidget {
  MyApp({this.type = Type.MATERIAL});

  Type type;
  final _unknownRoute = (RouteSettings rs) =>
    MaterialPageRoute(builder: (context) => NotFoundPage());

  @override
  Widget build(BuildContext context) {
    type = DeviceUtil.isAndroid ? Type.MATERIAL : Type.CUPRETINO;
    final routes = <String, WidgetBuilder>{
      UIData.ROUTE_HOME: (context) => HomePage(type),
      UIData.ROUTE_APP: (context) => AppPage.type(type),
      UIData.ROUTE_ARTICLE_DETAIL: (context) => ArticleDetailPage(type),
      UIData.ROUTE_WEB: (context) => WebPage(),
      UIData.ROUTE_USER: (context) => UserPage(),
      UIData.ROUTE_SETTING: (context) => SettingPage(),
      UIData.ROUTE_LOGIN: (context) => LoginPage(type),
      UIData.ROUTE_IMAGE: (context) => ImagePage(),
      UIData.ROUTE_SECTION: (context) => SectionListPage(type),
      UIData.ROUTE_RECOMMEND_LIST: (context) => RecommendListPage(type),
      UIData.ROUTE_APP_CHANNEL: (context) => AppChannelPage(type),
      UIData.ROUTE_TEST: (context) => TestPage(),
    };

    switch (type) {
      case Type.MATERIAL:
        return MaterialApp(
          title: 'All',
          theme: UserTheme.light(),
          darkTheme: UserTheme.dark(),
          home: HomePage(type),
          routes: routes,
          onUnknownRoute: _unknownRoute,
        );
        break;
      case Type.CUPRETINO:
        return CupertinoApp(
          title: 'All',
          theme: CupertinoThemeData(
            primaryColor: UserColor.COLOR_HOKI,
            brightness: Brightness.light,
            scaffoldBackgroundColor: UserColor.COLOR_ALABASTER,
          ),
          home: HomePage(type),
          routes: routes,
          onUnknownRoute: _unknownRoute,
        );
        break;
    }
  }
}
