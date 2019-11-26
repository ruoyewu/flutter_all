import 'package:all/base/base_presenter.dart';
import 'package:all/base/base_view.dart';
import 'package:all/model/bean/article_list_item.dart';
import 'package:all/model/model/app_model.dart';

abstract class IAppView extends BaseView {

}

abstract class IAppPresenter extends BasePresenter<IAppView> {
  IAppPresenter(BaseView view) : super(view);
}

abstract class IArticleListView extends BaseView {
  void onItemClick(ArticleListItem item);
}

abstract class IArticleListPresenter extends BasePresenter<IArticleListView> {
  IArticleListPresenter(IArticleListView view) : super(view);

  ArticleListModel get articleListModel;

  Future<void> startRefresh();
  Future<void> startLoadMore();
}