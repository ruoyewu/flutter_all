import 'package:all/model/bean/article_info.dart';
import 'package:flutter/material.dart';

class ArticleDetailInfoModel extends ChangeNotifier {
  double _offsetFavorite = 16;
  double _offsetCollect = 16;
  double _offsetEdit = 16;
  double _offsetFavoriteNum = 16 + (51 - 25) / 2;
  double _offsetCommentNum = 16 + (51 - 25) / 2;
  double _rotateAdd = 0;
  double _elevation = 1;
  ArticleInfo _articleInfo = ArticleInfo(
    collectNum: 0,
    commentNum: 0,
    isCollect: false,
    isPraise: false,
    praiseNum: 0
  );

  double get offsetFavorite => _offsetFavorite;

  double get offsetCollect => _offsetCollect;

  double get offsetEdit => _offsetEdit;

  double get offsetFavoriteNum => _offsetFavoriteNum;

  double get offsetCommentNum => _offsetCommentNum;

  double get rotateAdd => _rotateAdd;

  double get elevation => _elevation;

  ArticleInfo get articleInfo => _articleInfo;

  set articleInfo(ArticleInfo info) {
    this._articleInfo = info;
    notifyListeners();
  }

  update(double favorite, double collect, double edit, double favoriteNum,
    double commentNum, double add, double elevation) {
    this._offsetCollect = collect;
    this._offsetCommentNum = commentNum;
    this._offsetFavoriteNum = favoriteNum;
    this._offsetEdit = edit;
    this._offsetFavorite = favorite;
    this._rotateAdd = add;
    this._elevation = elevation;
    notifyListeners();
  }
}
