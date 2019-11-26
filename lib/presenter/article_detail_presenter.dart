import 'dart:developer';

import 'package:all/base/base_view.dart';
import 'package:all/model/bean/article_detail.dart';
import 'package:all/model/model/article_detail_model.dart';
import 'package:all/model/remote_data.dart';
import 'package:all/presenter/contract/article_detail_contract.dart';

class ArticleDetailPresenter extends IArticleDetailPresenter {
  ArticleDetailPresenter(BaseView view, {this.app, this.category, this.id}) : super(view);

  final app;
  final category;
  final id;

  ArticleDetailModel _articleDetailModel;

  @override
  void initModel() {
    _articleDetailModel = ArticleDetailModel();
  }

  @override
  void dispose() {
    super.dispose();
    _articleDetailModel.dispose();
  }

  @override
  ArticleDetailModel get articleDetailModel => _articleDetailModel;

  @override
  void startLoadArticle() {
    Future<ArticleDetail> result = RemoteData.articleDetail(app, category, id);
    result.then((articleDetail) {
      _articleDetailModel.update(articleDetail);
    });
  }

}