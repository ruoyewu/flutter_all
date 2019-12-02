import 'package:all/base/base_presenter.dart';
import 'package:all/base/base_view.dart';
import 'package:all/model/model/article_comment_model.dart';
import 'package:all/model/model/article_detail_info_model.dart';
import 'package:all/model/model/article_detail_model.dart';
import 'package:flutter/cupertino.dart';

abstract class IArticleDetailView extends BaseView {
  TickerProvider get tickerProvider;

  onResultInfo(String info);
}

abstract class IArticleDetailPresenter extends BasePresenter<IArticleDetailView> {
  IArticleDetailPresenter(BaseView view) : super(view);

  ArticleDetailModel get articleDetailModel;
  ArticleDetailInfoModel get articleDetailInfoModel;
  ArticleCommentModel get articleCommentModel;

  startLoadArticle();
  startLoadArticleInfo();
  startLoadComment();
  startAnimation();
  startSendComment(int parent, String comment);
  startPraise();
  startCollect();
}