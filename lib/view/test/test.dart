import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TestPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return CupertinoPageScaffold(
      child: CustomScrollView(
        slivers: <Widget>[
          CupertinoSliverNavigationBar(
            largeTitle: Text('test'),
          ),
          CupertinoSliverRefreshControl(
            onRefresh: () {
              return Future.delayed(Duration(seconds: 2));
            },
          ),
          SliverSafeArea(
            top: false,
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                return Text(
                  index.toString(),
                  style: TextStyle(color: Colors.black),
                );
              }, childCount: 10),
            ),
          )
        ],
      ),
    );
  }
}
