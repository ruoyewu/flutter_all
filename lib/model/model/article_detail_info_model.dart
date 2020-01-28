import 'package:all/model/bean/article_info.dart';
import 'package:flutter/material.dart';

class ArticleDetailInfoModel extends ChangeNotifier {
  ArticleInfo _articleInfo = ArticleInfo(
    collectNum: 0,
    commentNum: 0,
    isCollect: false,
    isPraise: false,
    praiseNum: 0
  );


  ArticleInfo get articleInfo => _articleInfo;

  set articleInfo(ArticleInfo info) {
    this._articleInfo = info;
    notifyListeners();
  }

}
