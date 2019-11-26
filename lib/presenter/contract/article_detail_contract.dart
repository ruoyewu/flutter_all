import 'package:all/base/base_presenter.dart';
import 'package:all/base/base_view.dart';
import 'package:all/model/model/article_detail_model.dart';

abstract class IArticleDetailView extends BaseView {

}

abstract class IArticleDetailPresenter extends BasePresenter {
  IArticleDetailPresenter(BaseView view) : super(view);

  ArticleDetailModel get articleDetailModel;

  void startLoadArticle();
}