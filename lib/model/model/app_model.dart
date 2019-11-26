import 'package:all/model/bean/article_list.dart';
import 'package:flutter/cupertino.dart';

class ArticleListModel with ChangeNotifier {
  ArticleList _articleList = ArticleList(list: List());

  ArticleList get articleList => _articleList;

  update(ArticleList articleList) {
    _articleList = articleList;
    notifyListeners();
  }

  addAll(ArticleList articleList) {
    _articleList.next = articleList.next;
    _articleList.list.addAll(articleList.list);
    notifyListeners();
  }
}