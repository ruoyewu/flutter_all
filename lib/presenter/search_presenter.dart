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
	startSearch(String search) {
		if (_lastSearch == search) return;
		_lastSearch = search;
		_searchAppModel.searchAppList = null;
		RemoteData.searchApp(search).then((result) {
			if (result.isSuccessful) {
				UserSetting.sInstance.then((setting) {
					final set = setting.savedAppItem.toSet();
					_searchAppModel.searchAppList = result.hasData
						? result.entityList.map((entry) {
						AppItem item = AppItem.fromJson(entry);
						item.userSaved =
							set.contains(item.detail.appDetail.packageName);
						return item;
					}).toList()
						: [];
				});
			}
		});
	}

	@override
	startAddAppItem(SearchAppItemModel model) {
		UserSetting.sInstance.then((setting) {
			List<String> list = setting.savedAppItem;
			if (!model.appItem.userSaved) {
				list.add(model.appItem.detail.appDetail.packageName);
			} else {
				list.remove(model.appItem.detail.appDetail.packageName);
			}
			setting.savedAppItem = list;
			model.appItem.userSaved = !model.appItem.userSaved;
			model.update();
		});
	}

	@override
	startRefreshSearchHistory() {
		UserSetting.sInstance.then((setting) {
			_searchHistoryModel.list = setting.searchHistory;
		});
	}

	@override
	startAddSearchHistory(String search) {
		if (search == null || search.isEmpty) return;
		UserSetting.sInstance.then((setting) {
			List<String> list = setting.searchHistory;
			final index = list.indexOf(search);
			if (index >= 0) {
				list.removeAt(index);
			}
			list.insert(0, search);
			setting.searchHistory = list;
		});
	}

	@override
	startClearHistory() {
		UserSetting.sInstance.then((setting) {
			setting.searchHistory = [];
			_searchHistoryModel.list = [];
		});
	}

	@override
  startLoadRecommend() {
		return RemoteData.recommend().then((result) {
			if (result.isSuccessful) {
				List<ResultRecommend> list = result.entityList.map((item) => ResultRecommend.fromJson(item)).toList();
				_searchRecommendModel.list = list;
			}
		});
  }

  @override
  startLoadSections() {
		return RemoteData.allSection().then((result) {
			if (result.isSuccessful) {
				List<Section> list = result.entityList.map((item) => Section.fromJson(item)).toList();
				UserSetting.sInstance.then((setting) {
					Set<String> saved = setting.savedAppItem.toSet();
					Set<Section> delete = Set();
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
				});
			}
		});
  }
}