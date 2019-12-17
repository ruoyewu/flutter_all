import 'package:all/base/base_presenter.dart';
import 'package:all/base/base_view.dart';
import 'package:all/model/model/article_list_type_model.dart';

abstract class ISettingView extends BaseView {

}

abstract class ISettingPresenter extends BasePresenter<ISettingView> {
  ISettingPresenter(ISettingView view) : super(view);

  ArticleListTypeModel get articleListTypeModel;

  startSetArticleListType(int type);
}