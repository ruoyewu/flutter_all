import 'package:all/base/base_presenter.dart';
import 'package:all/base/base_view.dart';
import 'package:all/model/model/search_app_item_model.dart';
import 'package:all/model/model/search_app_model.dart';
import 'package:all/model/model/search_history_model.dart';

abstract class ISearchView extends BaseView {

}

abstract class ISearchPresenter extends BasePresenter<ISearchView> {
  ISearchPresenter(ISearchView view) : super(view);

  SearchAppModel get searchAppModel;
  SearchHistoryModel get searchHistoryModel;

  startSearch(String search);
  startAddAppItem(SearchAppItemModel model);
  startRefreshSearchHistory();
  startAddSearchHistory(String search);
  startClearHistory();
}