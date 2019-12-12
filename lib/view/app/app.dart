import 'package:all/model/bean/qingmang_bean.dart';
import 'package:all/view/app/app_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    AppItem item = ModalRoute.of(context).settings.arguments;
    return DefaultTabController(
      length: item.channel.length,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return <Widget> [
              SliverAppBar(
                pinned: true,
                floating: true,
                title: Text(item.title),
                bottom: TabBar(
                  indicatorSize: TabBarIndicatorSize.label,
                  isScrollable: true,
                  tabs:buildTabs(item),
                ),
              ),
            ];
          },
          body: TabBarView(
            children: buildPages(item),
          ),
        ),
      ),
    );
  }

  List<Widget> buildTabs(AppItem item) {
    return item.channel.map((channel) => Tab(text: channel.title,)).toList();
  }

  List<Widget> buildPages(AppItem item) {
    return item.channel.map((channel) => AppListWidget(channel: channel,)).toList();
  }
}