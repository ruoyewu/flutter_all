import 'package:all/model/bean/qingmang_bean.dart';
import 'package:flutter/material.dart';

class ArticleListTypeModel extends ChangeNotifier {
  List<ArticleListItem> _list;
  int _type;

  List<ArticleListItem> get list => _list;

  int get type => _type;

  set type (int value) {
    _type = value;
  }

  set list(List<ArticleListItem> value) {
    _list = value;
    notifyListeners();
  }
}
