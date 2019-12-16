import 'package:all/model/bean/article_collection_list.dart';
import 'package:flutter/material.dart';

class ArticleCollectionModel extends ChangeNotifier {
  ArticleCollectionModel() {
    refresh();
  }

  ArticleCollectionList _articleCollectionList;
  bool _hasMore;

  ArticleCollectionList get articleCollectionList => _articleCollectionList;

  bool get hasMore => _hasMore;

  set articleCollectionList(ArticleCollectionList value) {
    _articleCollectionList = value;
    _hasMore = true;
    notifyListeners();
  }

  addAll(ArticleCollectionList list, bool hasMore) {
    _articleCollectionList.list.addAll(list.list);
    _articleCollectionList.next = list.next;
    _hasMore = hasMore;
    notifyListeners();
  }

  refresh() {
    _hasMore = true;
    _articleCollectionList = ArticleCollectionList(list: List());
    notifyListeners();
  }
}
