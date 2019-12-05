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
  Future<void> startLoadMore({bool isRefresh = false}) {
    if (isRefresh) {
      next = '0';
    }
    Future<ArticleList> result = RemoteData.articleList(app, category, next);
    return result.then((articleList) {
      if (isDisposed) return;
      next = articleList.next;
      if (isRefresh) {
        _articleListModel.update(articleList);
      } else {
        _articleListModel.addAll(articleList);
      }
    });
  }

}