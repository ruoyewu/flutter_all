import 'package:all/base/base_presenter.dart';
import 'package:all/base/base_view.dart';
import 'package:all/model/model/article_list_model.dart';

abstract class IRecommendView extends BaseView {

}

abstract class IRecommendPresenter extends BasePresenter<IRecommendView> {
  IRecommendPresenter(IRecommendView view) : super(view);

  ArticleListModel get articleListModel;

  startLoadMore({bool isRefresh = false});
}