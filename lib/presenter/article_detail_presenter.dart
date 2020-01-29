import 'dart:convert';
import 'dart:developer';

import 'package:all/base/base_view.dart';
import 'package:all/model/bean/article_comment_list.dart';
import 'package:all/model/bean/article_comment_list_item.dart';
import 'package:all/model/bean/article_info.dart';
import 'package:all/model/bean/qingmang_bean.dart';
import 'package:all/model/model/article_comment_item_model.dart';
import 'package:all/model/model/article_comment_model.dart';
import 'package:all/model/model/article_detail_info_model.dart';
import 'package:all/model/model/article_detail_model.dart';
import 'package:all/model/remote_data.dart';
import 'package:all/model/user_setting.dart';
import 'package:all/presenter/contract/article_detail_contract.dart';

class ArticleDetailPresenter extends IArticleDetailPresenter {
  static const ANIMATION_DURATION = 200;

  ArticleDetailPresenter(BaseView view, {this.item}) : super(view);

  ArticleListItem item;

  int nextComment = 0;

  ArticleDetailModel _articleDetailModel;
  ArticleDetailInfoModel _articleDetailInfoModel;
  ArticleCommentModel _articleCommentModel;
  bool _isAnimationForward = true;

  @override
  void initModel() {
    _articleDetailModel = ArticleDetailModel();
    _articleDetailInfoModel = ArticleDetailInfoModel();
    _articleCommentModel = ArticleCommentModel();
  }

  @override
  void dispose() {
    super.dispose();
    _articleDetailModel.dispose();
    _articleDetailInfoModel.dispose();
    _articleCommentModel.dispose();
  }

  @override
  ArticleDetailModel get articleDetailModel => _articleDetailModel;

  @override
  ArticleDetailInfoModel get articleDetailInfoModel => _articleDetailInfoModel;

  @override
  ArticleCommentModel get articleCommentModel => _articleCommentModel;

  @override
  Future<List<String>> commentDialogTitles(ArticleCommentListItem item) async {
    if ((await UserSetting.isLogin.lazy) &&
        (await UserSetting.loginId.lazy) == item.user.id) {
      return ['复制', '举报', '评论', '删除'];
    } else {
      return ['复制', '举报', '评论'];
    }
  }

  @override
  showEditDialog(ArticleCommentListItem parent) async {
    if (await UserSetting.isLogin.lazy) {
      view.onShowEditDialog(await UserSetting.loginUserName.lazy, parent);
    } else {
      view.onResultInfo('LOGIN FIRST', code: 401);
    }
  }

  @override
  void startLoadArticle() async {
    int startTime = Timeline.now;
    int endTime = startTime + 500000;
    final result =
        await RemoteData.articleDetail(item.subEntry[0].idString, 'raml');
    if (isDisposed) return;
    if (result.isSuccessful) {
      int delay = endTime - Timeline.now;
      Future.delayed(Duration(microseconds: delay), () {
        if (isDisposed) return;
        _articleDetailModel.articleDetail =
            ArticleDetail.fromJson(result.entityList[0]);
      });
    }
  }

  @override
  startLoadArticleInfo() {
    RemoteData.articleInfo(article).then((result) {
      if (isDisposed) return;
      if (result.successful) {
        _articleDetailInfoModel.articleInfo = ArticleInfo.fromJson(result.info);
      } else {
        view.onResultInfo(result.info);
      }
    });
  }

  @override
  startLoadComment() {
    RemoteData.artileComment(article, nextComment).then((result) {
      if (isDisposed) return;
      if (result.successful) {
        ArticleCommentList list = ArticleCommentList.fromJson(result.info);
        nextComment = list.next;
        _articleCommentModel.addAll(list, list.list.length == 10);
      } else {
        view.onResultInfo(result.info);
      }
    });
  }

  @override
  startPraise() {
    RemoteData.praiseArticle(article).then((result) {
      if (isDisposed) return;
      if (result.successful) {
        final info = _articleDetailInfoModel.articleInfo;
        info.praiseNum += result.info ? 1 : -1;
        info.isPraise = result.info;
        _articleDetailInfoModel.articleInfo = info;
      } else {
        view.onResultInfo(result.info, code: result.code);
      }
    });
  }

  @override
  startCollect() {
    String content = json.encode(item.toJson());
    RemoteData.collectArticle(article, content).then((result) {
      if (isDisposed) return;
      if (result.successful) {
        final info = _articleDetailInfoModel.articleInfo;
        info.collectNum += result.info ? 1 : -1;
        info.isCollect = result.info;
        _articleDetailInfoModel.articleInfo = info;
      } else {
        view.onResultInfo(result.info, code: result.code);
      }
    });
  }

  @override
  startSendComment(int parent, String comment,
      {ArticleCommentItemModel model = null}) {
    if (isDisposed) return;
    if (comment == null || comment.length == 0) {
      view.onResultInfo('评论不能为空');
      return;
    }
    RemoteData.commentArticle(article, parent, comment).then((result) {
      if (isDisposed) return;
      if (result.successful) {
        ArticleCommentListItem item =
            ArticleCommentListItem.fromJson(result.info);
        ArticleCommentList list = _articleCommentModel.articleCommentList;
        list.list.insert(0, item);
        _articleCommentModel.articleCommentList = list;
        view.scrollToComment();

        ArticleInfo info = _articleDetailInfoModel.articleInfo;
        info.commentNum += 1;
        _articleDetailInfoModel.articleInfo = info;

        if (model != null) {
          ArticleCommentListItem commentListItem = model.articleCommentListItem;
          commentListItem.commentNum += 1;
          model.articleCommentListItem = commentListItem;
        }

        view.onResultInfo('评论成功');
      } else {
        view.onResultInfo(result.info, code: result.code);
      }
    });
  }

  @override
  startDeleteComment(int id) {
    RemoteData.deleteComment(id).then((result) {
      if (isDisposed) return;
      if (result.successful) {
        ArticleCommentList list = _articleCommentModel.articleCommentList;
        list.removeWithId(id);
        _articleCommentModel.articleCommentList = list;

        ArticleInfo info = _articleDetailInfoModel.articleInfo;
        info.commentNum -= 1;
        _articleDetailInfoModel.articleInfo = info;

        view.onResultInfo('删除成功');
      } else {
        view.onResultInfo(result.info);
      }
    });
  }

  @override
  startPraiseComment(ArticleCommentItemModel model) {
    RemoteData.praiseComment(model.articleCommentListItem.id).then((result) {
      if (isDisposed) return;
      if (result.successful) {
        ArticleCommentListItem item = model.articleCommentListItem;
        item.isPraise = result.info;
        item.praiseNum += result.info ? 1 : -1;
        model.articleCommentListItem = item;
      } else {
        view.onResultInfo(result.info);
      }
    });
  }

  String get article => '${item.id}_${item.subEntry[0].id}';
}
