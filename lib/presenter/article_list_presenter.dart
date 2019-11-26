import 'dart:developer';

import 'package:all/model/bean/article_list.dart';
import 'package:all/model/model/app_model.dart';
import 'package:all/model/remote_data.dart';
import 'package:all/presenter/contract/app_contract.dart';

class ArticleListPresenter extends IArticleListPresenter {
  ArticleListPresenter(IArticleListView view, this.app, this.category) : super(view);

  final app;
  final category;
  String next = "0";

  ArticleListModel _articleListModel;

  @override
  void initModel() {
    _articleListModel = ArticleListModel();
  }

  @override
  void dispose() {
    super.dispose();
    _articleListModel.dispose();
  }

  @override
  ArticleListModel get articleListModel => _articleListModel;

  @override
  Future<void> startRefresh() {
    next = "0";
    return _startLoad(false);
  }

  @override
  Future<void> startLoadMore() {
    return _startLoad(true);
  }

  Future<void> _startLoad(bool isMore) {
    Future<ArticleList> result = RemoteData.articleList(app, category, next);
    return result.then((articleList) {
      next = articleList.next;
      if (isMore) {
        _articleListModel.addAll(articleList);
      } else {
        _articleListModel.update(articleList);
      }
    });
  }

}