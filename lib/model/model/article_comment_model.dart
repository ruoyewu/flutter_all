import 'package:all/model/bean/article_comment_list.dart';
import 'package:flutter/material.dart';

class ArticleCommentModel extends ChangeNotifier {
  ArticleCommentList _articleCommentList = ArticleCommentList();
  bool _hasMore = true;

  ArticleCommentList get articleCommentList => _articleCommentList;

  bool get hasMore => _hasMore;

  set articleCommentList(ArticleCommentList list) {
    _articleCommentList = list;
    notifyListeners();
  }

  addAll(ArticleCommentList list, bool hasMore) {
    if (_articleCommentList.list != null) {
      _articleCommentList.list.addAll(list.list);
      _articleCommentList.next = list.next;
    } else {
      _articleCommentList = list;
    }
    _hasMore = hasMore;
    notifyListeners();
  }
}
