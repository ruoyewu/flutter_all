import 'package:all/base/base_presenter.dart';
import 'package:all/base/base_view.dart';
import 'package:all/model/bean/article_comment_list_item.dart';
import 'package:all/model/model/article_comment_item_model.dart';
import 'package:all/model/model/article_comment_model.dart';
import 'package:all/model/model/article_detail_info_model.dart';
import 'package:all/model/model/article_detail_model.dart';
import 'package:flutter/cupertino.dart';

abstract class IArticleDetailView extends BaseView {
  TickerProvider get tickerProvider;

  scrollToComment();

  onResultInfo(String info, {int code});

  onShowEditDialog(String userName, ArticleCommentListItem parent);
}

abstract class IArticleDetailPresenter
    extends BasePresenter<IArticleDetailView> {
  IArticleDetailPresenter(BaseView view) : super(view);

  ArticleDetailModel get articleDetailModel;

  ArticleDetailInfoModel get articleDetailInfoModel;

  ArticleCommentModel get articleCommentModel;

  Future<List<String>> commentDialogTitles(ArticleCommentListItem item);

  showEditDialog(ArticleCommentListItem parent);

  startLoadArticle();

  startLoadArticleInfo();

  startLoadComment();

  startAnimation();

  startSendComment(int parent, String comment);

  startDeleteComment(int id);

  startPraiseComment(ArticleCommentItemModel model);

  startPraise();

  startCollect();
}
