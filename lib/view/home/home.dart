import 'package:all/base/base_state.dart';
import 'package:all/model/bean/qingmang_bean.dart' hide ResultIcons;
import 'package:all/model/model/app_list_model.dart';
import 'package:all/model/model/home_model.dart';
import 'package:all/model/ui_data.dart';
import 'package:all/model/user_color.dart';
import 'package:all/presenter/contract/home_contract.dart';
import 'package:all/presenter/home_presenter.dart';
import 'package:all/utils/provider_consumer.dart';
import 'package:all/view/home/home_list.dart';
import 'package:all/view/search/search.dart';
import 'package:all/view/user/user.dart';
import 'package:all/view/widget/widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends BaseState<HomePage, IHomePresenter>
    with SingleTickerProviderStateMixin
    implements IHomeView {
  BuildContext _snackbarContext;
  int _showIndex = 0;

  @override
  void initState() {
    super.initState();
    presenter = HomePresenter(this);
    presenter.startRefresh();
    presenter.startDefaultLogin();
  }

  @override
  void onResultInfo(String info) {
    Widgets.showSnackBar(_snackbarContext, info);
  }

  @override
  TickerProvider get tickerProvider => this;

  @override
  Widget build(BuildContext context) {
    UserColor userColor = UserColor.auto(context);
//    return CupertinoPageScaffold(
//      navigationBar: CupertinoNavigationBar(
//
//      ),
//      child: CupertinoTabScaffold(
//        tabBar: CupertinoTabBar(
//          backgroundColor: UserColor.COLOR_TRANSPARENT_ALABASTER.withAlpha(220),
//          items: _bottomItems(),
//        ),
//        tabBuilder: (context, index) {
//          return Material(
//            child: _buildPages()[index],
//          );
//        },
//      ),
//    );
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          elevation: 3,
          backgroundColor: userColor.highlightBackgroundColor,
          currentIndex: _showIndex,
          showUnselectedLabels: false,
          showSelectedLabels: false,
          items: _bottomItems(),
          selectedIconTheme: IconThemeData(color: Colors.blueGrey, size: 28),
          unselectedIconTheme: IconThemeData(size: 24),
          onTap: (index) {
            setState(() {
              _showIndex = index;
            });
          },
        ),
        body: Stack(children: <Widget>[
          IndexedStack(
            index: _showIndex,
            children: <Widget>[container(context), SearchPage(), UserPage()],
          ),
        ]));
  }

  Widget container(BuildContext context) {
//    return ProviderConsumer<AppListModel>(
//      presenter.homeListModel,
//        (context, model, _) => HomeListWidget(
//          presenter,
//          model.appItemList,
//          onItemTap: (AppItem item) {
//            Navigator.pushNamed(context, UIData.ROUTE_APP,
//              arguments: item);
//          },
//        ));
    return Scaffold(
      appBar: AppBar(
        title: Text("ALL"),
        actions: <Widget>[
//          IconButton(
//            onPressed: () {
//              Navigator.pushNamed(context, UIData.ROUTE_SETTING).then((_) {
//                presenter.startRefresh();
//              });
//            },
//            icon: Icon(Icons.settings),
//          )
        ],
      ),
      body: ProviderConsumer<AppListModel>(
          presenter.homeListModel,
          (context, model, _) => RefreshIndicator(
                onRefresh: presenter.startRefresh,
                child: HomeListWidget(
                  presenter,
                  model.appItemList,
                  onItemTap: (AppItem item) {
                    Navigator.pushNamed(context, UIData.ROUTE_APP,
                        arguments: item);
                  },
                ),
              )),
    );
  }

  List<BottomNavigationBarItem> _bottomItems() {
    return [
      BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('首页')),
      BottomNavigationBarItem(icon: Icon(Icons.search), title: Text('发现')),
      BottomNavigationBarItem(icon: Icon(Icons.person), title: Text('用户')),
    ];
  }

  List<Widget> _buildPages() {
    return [
      container(context), SearchPage(), UserPage()
    ];
  }

  Widget buttons(BuildContext context) {
    return SizedBox.expand(
      child: ProviderConsumer<HomeFabAnimationModel>(
        presenter.homeFabAnimationModel,
        (context, model, _) => Stack(
          alignment: Alignment.bottomRight,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 16, bottom: model.offsetSetting),
              child: FloatingActionButton(
                heroTag: "fab_setting",
                child: Icon(
                  Icons.settings,
                  color: Colors.white70,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, UIData.ROUTE_SETTING);
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 16, bottom: model.offsetUser),
              child: FloatingActionButton(
                heroTag: "fab_user",
                child: Icon(
                  Icons.person,
                  color: Colors.white70,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, UIData.ROUTE_USER);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 16, bottom: 16),
              child: Transform.rotate(
                angle: model.rotateAdd,
                child: FloatingActionButton(
                  heroTag: "fab_add",
                  child: Icon(
                    Icons.add,
//                    color: Colors.white70,
                  ),
                  onPressed: this.presenter.startFabAnimation,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
