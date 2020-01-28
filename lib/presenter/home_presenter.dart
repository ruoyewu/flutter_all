import 'dart:math' as math;

import 'package:all/model/bean/qingmang_bean.dart';
import 'package:all/model/model/app_list_model.dart';
import 'package:all/model/model/home_model.dart';
import 'package:all/model/remote_data.dart';
import 'package:all/model/ui_data.dart';
import 'package:all/model/user_setting.dart';
import 'package:all/presenter/contract/home_contract.dart';
import 'package:all/utils/encrypt.dart';
import 'package:flutter/animation.dart';

class HomePresenter extends IHomePresenter {
  static const int ANIMATION_DURATION = 300;

  HomeFabAnimationModel _homeFabAnimationModel;
  AppListModel _homeListModel;

  AnimationController _animationFab;
  bool _isAnimationFabForward = true;

  HomePresenter(IHomeView view) : super(view);

  @override
  void initModel() {
    _homeFabAnimationModel = HomeFabAnimationModel();
    _homeListModel = AppListModel();
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
  AppListModel get homeListModel => _homeListModel;

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
  Future<void> startRefresh() async {
    String pns = '';
    (await UserSetting.userApp.value).forEach((item) => pns += item + ',');
    final result = await RemoteData.appDetail(pns);
    if (result.hasData) {
      final list =
          result.entityList.map((item) => AppItem.fromJson(item)).toList();
      homeListModel.appItemList = list;
    }
  }

  @override
  startRemoveAppItem(AppItem item) async {
    final list = _homeListModel.appItemList;
    list.remove(item);
    _homeListModel.appItemList = list;
    UserSetting.userApp.val =
        list.map((item) => item.detail.appDetail.packageName).toList();
  }

  @override
  startDefaultLogin() async {
    final isLogin = UserSetting.isLogin;
    final userId = UserSetting.loginId;
    final userPassword = UserSetting.loginPassword;
    if (await isLogin.value) {
      final result = await RemoteData.login(
          Encrypt.sInstance.encrypt(await userId.value),
          await userPassword.value);
      if (!result.successful) {
        isLogin.val = false;
        userId.val = '';
        userPassword.val = '';
      }
    }
  }
}
