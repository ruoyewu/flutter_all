import 'package:all/base/base_presenter.dart';
import 'package:all/base/base_view.dart';
import 'package:all/model/model/article_list_model.dart';

abstract class IArticleListView extends BaseView {
//  void onItemClick(ArticleListItem item);
}

abstract class IArticleListPresenter extends BasePresenter<IArticleListView> {
  IArticleListPresenter(IArticleListView view) : super(view);

  ArticleListModel get articleListModel;

  Future<void> startLoadMore({bool isRefresh = false});
}