import 'package:all/base/base_presenter.dart';
import 'package:all/base/base_view.dart';

abstract class ISearchView extends BaseView {

}

abstract class ISearchPresenter extends BasePresenter<ISearchView> {
  ISearchPresenter(ISearchView view) : super(view);

  startSearch(String search);
}