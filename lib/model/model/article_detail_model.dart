import 'package:all/model/bean/qingmang_bean.dart';
import 'package:flutter/cupertino.dart';

class ArticleDetailModel with ChangeNotifier {
//  ArticleDetail _articleDetail;
//
//  ArticleDetail get articleDetail => _articleDetail;
//
//  void update(ArticleDetail articleDetail) {
//    _articleDetail = articleDetail;
//    notifyListeners();
//  }

  ArticleDetail _articleDetail;

  ArticleDetail get articleDetail => _articleDetail;

  set articleDetail (ArticleDetail value) {
    _articleDetail = value;
    notifyListeners();
  }


}