import 'package:all/model/bean/qingmang_bean.dart';
import 'package:flutter/cupertino.dart';

class ArticleListModel with ChangeNotifier {
  List<ArticleListItem> _articleList = List();

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