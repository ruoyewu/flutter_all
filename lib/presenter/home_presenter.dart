import 'dart:math' as math;

import 'package:all/model/bean/app_item.dart';
import 'package:all/model/model/home_model.dart';
import 'package:all/model/remote_data.dart';
import 'package:all/model/ui_data.dart';
import 'package:all/model/user_cache.dart';
import 'package:all/model/user_setting.dart';
import 'package:all/presenter/contract/home_contract.dart';
import 'package:all/utils/encrypt.dart';
import 'package:flutter/animation.dart';

class HomePresenter extends IHomePresenter {
  static const int ANIMATION_DURATION = 300;

  HomeFabAnimationModel _homeFabAnimationModel;
  AnimationController _animationFab;
  bool _isAnimationFabForward = true;

  HomeListModel _homeListModel;

  HomePresenter(IHomeView view) : super(view);

  @override
  void initModel() {
    _homeFabAnimationModel = HomeFabAnimationModel();
    _homeListModel = HomeListModel();
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
  }

  @override
  HomeFabAnimationModel get homeFabAnimationModel => _homeFabAnimationModel;

  @override
  HomeListModel get homeListModel => _homeListModel;

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
    return RemoteData.api().then((allApi) {
      if (isDisposed) return;

      Map<String, AppItem> map = Map();
      for (AppItem item in allApi.appItemList) {
        map[item.name] = item;
      }
      UserCache.appItemMap = map;
      _homeListModel.update(allApi.appList, map);
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
}
