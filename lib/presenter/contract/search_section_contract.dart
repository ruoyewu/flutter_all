import 'package:all/base/base_presenter.dart';
import 'package:all/base/base_view.dart';
import 'package:all/model/model/search_app_item_model.dart';
import 'package:all/model/model/search_section_model.dart';

abstract class ISearchSectionView extends BaseView {

}

abstract class ISearchSectionPresenter extends BasePresenter<ISearchSectionView> {
  ISearchSectionPresenter(ISearchSectionView view) : super(view);

  SearchSectionModel get searchSectionModel;

  startLoadSection();
  startAddAppItem(SearchAppItemModel model);
}