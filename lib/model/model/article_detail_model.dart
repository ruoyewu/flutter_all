import 'package:all/model/bean/article_detail.dart';
import 'package:flutter/cupertino.dart';

class ArticleDetailModel with ChangeNotifier {
  ArticleDetail _articleDetail;

  ArticleDetail get articleDetail => _articleDetail;

  void update(ArticleDetail articleDetail) {
    _articleDetail = articleDetail;
    notifyListeners();
  }
}