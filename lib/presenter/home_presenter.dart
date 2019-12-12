import 'dart:developer';
import 'dart:math' as math;

import 'package:all/model/bean/qingmang_bean.dart';
import 'package:all/model/model/home_model.dart';
import 'package:all/model/model/search_app_item_model.dart';
import 'package:all/model/model/search_app_model.dart';
import 'package:all/model/model/search_history_model.dart';
import 'package:all/model/remote_data.dart';
import 'package:all/model/ui_data.dart';
import 'package:all/model/user_setting.dart';
import 'package:all/presenter/contract/home_contract.dart';
import 'package:all/utils/encrypt.dart';
import 'package:flutter/animation.dart';

class HomePresenter extends IHomePresenter {
  static const int ANIMATION_DURATION = 300;

  HomeFabAnimationModel _homeFabAnimationModel;
  SearchAppModel _searchAppModel;
  HomeListModel _homeListModel;
  SearchHistoryModel _searchHistoryModel;

  AnimationController _animationFab;
  bool _isAnimationFabForward = true;
  String _lastSearch;


  HomePresenter(IHomeView view) : super(view);

  @override
  void initModel() {
    _homeFabAnimationModel = HomeFabAnimationModel();
    _homeListModel = HomeListModel();
    _searchAppModel = SearchAppModel();
    _searchHistoryModel = SearchHistoryModel();
  }

  @override
  void initView() {
    _animationFab = AnimationController(
      duration: Duration(milliseconds: ANIMATION_DURATION),
      vsync: view.tickerProvider,
    );
  }

  @override
  void initListener() {
    _animationFab.addListener(() {
      if (isDisposed) return;
      var offset = UIData.OFFSET_DEFAULT;
      var height = UIData.SIZE_FAB;
      var value = _animationFab.value;

      _homeFabAnimationModel.update(
          value * (height + offset) * 2 + offset,
          value * 0.5 + 0.5,
          value * (height + offset) + offset,
          value * 0.5 + 0.5,
          value * math.pi * 3 / 4);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _animationFab.dispose();
    _homeListModel.dispose();
    _searchHistoryModel.dispose();
    searchAppModel.dispose();
  }

  @override
  HomeFabAnimationModel get homeFabAnimationModel => _homeFabAnimationModel;

  @override
  HomeListModel get homeListModel => _homeListModel;

  @override
  SearchAppModel get searchAppModel => _searchAppModel;

  @override
  SearchHistoryModel get searchHistoryModel => _searchHistoryModel;

  @override
  void startFabAnimation() {
    if (_isAnimationFabForward) {
      _animationFab.animateTo(1, curve: Curves.decelerate);
    } else {
      _animationFab.animateTo(0, curve: Curves.decelerate);
    }
    _isAnimationFabForward = !_isAnimationFabForward;
  }

  @override
  Future<void> startRefresh() {
    return UserSetting.sInstance.then((setting) {
      String pns = '';
      setting.savedAppItem.forEach((item) => pns += item + ',');
      log('$pns');
      return RemoteData.appDetail(pns).then((result) {
        if (result.hasData) {
          final list = result.entityList.map((item) => AppItem.fromJson(item)).toList();
          homeListModel.appItemList = list;
        }
      });
    });
  }

  @override
  startRemoveAppItem(AppItem item) {
    UserSetting.sInstance.then((setting) {
      final list = _homeListModel.appItemList;
      list.remove(item);
      _homeListModel.appItemList = list;
      setting.savedAppItem = list.map((item) => item.detail.appDetail.packageName).toList();
    });
  }

  @override
  startDefaultLogin() {
    UserSetting.sInstance.then((setting) {
      if (setting.isUserLogin) {
        RemoteData.login(Encrypt.sInstance.encrypt(setting.loginUserId),
                setting.loginUserPassword)
            .then((result) {
          if (!result.successful) {
            setting.isUserLogin = false;
            setting.loginUserId = '';
            setting.loginUserPassword = '';
          }
        });
      }
    });
  }

  @override
  startSearch(String search) {
    if (_lastSearch == search) return;
    _lastSearch = search;
    _searchAppModel.searchAppList = null;
    RemoteData.searchApp(search).then((result) {
      if (result.hasData) {
        UserSetting.sInstance.then((setting) {
          final set = setting.savedAppItem.toSet();
          _searchAppModel.searchAppList = result.entityList.map((entry)  {
            AppItem item = AppItem.fromJson(entry);
            item.userSaved = set.contains(item.detail.appDetail.packageName);
            return item;
          }).toList();

//          _searchAppModel.searchAppList.forEach((item) {
//            log('package name: ${item.detail.appDetail.packageName}');
//          });
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
}
