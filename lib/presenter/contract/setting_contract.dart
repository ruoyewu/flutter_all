import 'package:all/base/base_presenter.dart';
import 'package:all/base/base_view.dart';

abstract class ISettingView extends BaseView {

}

abstract class ISettingPresenter extends BasePresenter<ISettingView> {
  ISettingPresenter(ISettingView view) : super(view);

  startSetArticleListType(int type);
}