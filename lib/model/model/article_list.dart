import 'package:all/model/bean/qingmang_bean.dart';
import 'package:flutter/material.dart';

class ArticleListModel with ChangeNotifier {
  List<ArticleListItem> _articleList = List();
  bool hasMore = true;

  List<ArticleListItem> get articleList => _articleList;

  set articleList (List<ArticleListItem> value) {
    _articleList = value;
    notifyListeners();
  }

  addAll(List<ArticleListItem> list) {
    _articleList.addAll(list);
    notifyListeners();
  }

}