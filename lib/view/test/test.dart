import 'package:all/model/user_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TestPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      home: CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(

        ),
        child: CupertinoTabScaffold(
          tabBar: CupertinoTabBar(
            backgroundColor: UserColor.COLOR_TRANSPARENT_ALABASTER.withAlpha(220),
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('首页')),
              BottomNavigationBarItem(icon: Icon(Icons.search), title: Text('发现')),
              BottomNavigationBarItem(icon: Icon(Icons.person), title: Text('用户')),
            ],
          ),
          tabBuilder: (context, index) {
            return ListView.builder(
              itemCount: 100,
              itemBuilder: (context, index) {
              return Material(
                child: InkWell(
                  onTap: () {

                  },
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.black,
                    ),
                    title: Text(index.toString()),
                  ),
                ),
              );
            });
          },
        ),
      )
    );
  }
}
