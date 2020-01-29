import 'package:all/model/bean/qingmang_bean.dart';
import 'package:all/model/model/search_all_section_model.dart';
import 'package:all/model/model/search_app_item_model.dart';
import 'package:all/model/model/search_app_model.dart';
import 'package:all/model/model/search_history_model.dart';
import 'package:all/model/model/search_recommend_model.dart';
import 'package:all/model/remote_data.dart';
import 'package:all/model/user_setting.dart';
import 'package:all/presenter/contract/search_contract.dart';

class SearchPresenter extends ISearchPresenter {
  SearchPresenter(ISearchView view) : super(view);

  SearchAppModel _searchAppModel;
  SearchHistoryModel _searchHistoryModel;
  SearchRecommendModel _searchRecommendModel;
  SearchAllSectionModel _searchAllSectionModel;
  String _lastSearch;

  @override
  void initModel() {
    _searchAppModel = SearchAppModel();
    _searchHistoryModel = SearchHistoryModel();
    _searchRecommendModel = SearchRecommendModel();
    _searchAllSectionModel = SearchAllSectionModel();
  }

  @override
  void dispose() {
    super.dispose();

    _searchHistoryModel.dispose();
    _searchAppModel.dispose();
    _searchRecommendModel.dispose();
    _searchAllSectionModel.dispose();
  }

  @override
  SearchAppModel get searchAppModel => _searchAppModel;

  @override
  SearchHistoryModel get searchHistoryModel => _searchHistoryModel;

  @override
  SearchRecommendModel get searchRecommendModel => _searchRecommendModel;

  @override
  SearchAllSectionModel get searchAllSectionModel => _searchAllSectionModel;

  @override
  startSearch(String search) async {
    if (_lastSearch == search) return;
    _lastSearch = search;
    _searchAppModel.searchAppList = null;
    final result = await RemoteData.searchApp(search);
    if (result.isSuccessful) {
      final set = (await UserSetting.userApp.lazy).toSet();
      _searchAppModel.searchAppList = result.hasData
          ? result.entityList.map((entry) {
              AppItem item = AppItem.fromJson(entry);
              item.userSaved = set.contains(item.detail.appDetail.packageName);
              return item;
            }).toList()
          : [];
    }
  }

  @override
  startAddAppItem(SearchAppItemModel model) async {
    final list = await UserSetting.userApp.lazy;
    if (!model.appItem.userSaved) {
      list.add(model.appItem.detail.appDetail.packageName);
    } else {
      list.remove(model.appItem.detail.appDetail.packageName);
    }
    UserSetting.userApp.value = list;
    model.appItem.userSaved = !model.appItem.userSaved;
    model.update();
  }

  @override
  startRefreshSearchHistory() async {
    _searchHistoryModel.list = await UserSetting.searchHistory.lazy;
  }

  @override
  startAddSearchHistory(String search) async {
    if (search == null || search.isEmpty) return;
    final searchHistory = await UserSetting.searchHistory.lazy;
    final index = searchHistory.indexOf(search);
    if (index >= 0) {
      searchHistory.removeAt(index);
    }
    searchHistory.insert(0, search);
    UserSetting.searchHistory.value = searchHistory;
  }

  @override
  startClearHistory() async {
    UserSetting.searchHistory.value = [];
    _searchHistoryModel.list = [];
  }

  @override
  startLoadRecommend() async {
    final result = await RemoteData.recommend();
    if (result.isSuccessful) {
      List<ResultRecommend> list = result.entityList
          .map((item) => ResultRecommend.fromJson(item))
          .toList();
      _searchRecommendModel.list = list;
    }
  }

  @override
  startLoadSections() async {
    final result = await RemoteData.allSection();
    if (result.isSuccessful) {
      List<Section> list =
          result.entityList.map((item) => Section.fromJson(item)).toList();
      final saved = (await UserSetting.userApp.lazy).toSet();
      final delete = Set();
      for (Section section in list) {
        if (section.subEntity == null) {
          delete.add(section);
          continue;
        }
        for (AppItem item in section.subEntity) {
          item.userSaved = saved.contains(item.detail.appDetail.packageName);
        }
      }
      for (Section section in delete) {
        list.remove(section);
      }
      _searchAllSectionModel.list = list;
    }
  }
}
