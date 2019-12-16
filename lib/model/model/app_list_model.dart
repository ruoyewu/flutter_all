import 'package:all/model/bean/qingmang_bean.dart';
import 'package:flutter/material.dart';

class AppListModel with ChangeNotifier {
  List<AppItem> _appItemList;

  List<AppItem> get appItemList => _appItemList;

  set appItemList(List<AppItem> value) {
    _appItemList = value;
    notifyListeners();
  }
}
