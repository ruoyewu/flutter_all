import 'dart:developer';

import 'package:all/model/bean/app_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef OnItemTapCallback = void Function(AppItem item);

class HomeListWidget extends StatelessWidget {
  final List<String> appNameList;
  final Map<String, AppItem> appItemMap;
  final OnItemTapCallback onItemTap;

  HomeListWidget(this.appNameList, this.appItemMap, {this.onItemTap});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: appNameList.length,
      itemBuilder: (context, index) {
        return item(context, index);
    });
  }

  Widget item(BuildContext context, int index) {
    AppItem item = appItemMap[appNameList[index]];
    assert(item != null);
    return InkWell(
      onTap: () => onItemTap(item),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        width: double.infinity,
        height: 100,
        child: Row(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.network(item.icon, width: 60, height: 60,)
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(item.title),
            ),
          ],
        ),
      ),
    );
  }
}