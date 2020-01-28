import 'package:all/model/user_color.dart';
import 'package:all/view/app.dart';
import 'package:all/view/home/home_container.dart';
import 'package:all/view/search/search.dart';
import 'package:all/view/user/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage(this.type);

  final type;

  @override
  State<StatefulWidget> createState() {
    return _HomePageState.type(type);
  }
}

abstract class _HomePageState extends State<HomePage> {
  // ignore: missing_return
  static type(Type type) {
    switch (type) {
      case Type.MATERIAL:
        return _HomePageStateMaterial();
      case Type.CUPRETINO:
        return _HomePageStateCupertino();
    }
  }

  List<Widget> _buildChildren() {
    return [
      HomeContainerPage(
        type: widget.type,
      ),
      SearchPage(
        type: widget.type,
      ),
      UserPage(type: widget.type)
    ];
  }

  List<BottomNavigationBarItem> _buildItems() {
    return [
      BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('首页')),
      BottomNavigationBarItem(icon: Icon(Icons.search), title: Text('发现')),
      BottomNavigationBarItem(icon: Icon(Icons.person), title: Text('用户')),
    ];
  }
}

class _HomePageStateCupertino extends _HomePageState {
  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: _buildItems(),
        backgroundColor: UserColor.COLOR_TRANSPARENT_ALABASTER,
      ),
      tabBuilder: (context, index) {
        return _buildChildren()[index];
      },
    );
  }
}

class _HomePageStateMaterial extends _HomePageState {
  int _showIndex = 0;

  @override
  Widget build(BuildContext context) {
    UserColor userColor = UserColor.auto(context);
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          elevation: 3,
          backgroundColor: userColor.highlightBackgroundColor,
          currentIndex: _showIndex,
          showUnselectedLabels: false,
          showSelectedLabels: false,
          items: _buildItems(),
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
            children: _buildChildren(),
          ),
        ]));
  }
}
