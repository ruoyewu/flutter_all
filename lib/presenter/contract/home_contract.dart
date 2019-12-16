
import 'package:all/base/base_presenter.dart';
import 'package:all/base/base_view.dart';
import 'package:all/model/bean/qingmang_bean.dart';
import 'package:all/model/model/app_list_model.dart';
import 'package:all/model/model/home_model.dart';
import 'package:flutter/material.dart';

abstract class IHomeView extends BaseView {
  void showDialog(String msg);
  void onResultInfo(String info);

  TickerProvider get tickerProvider;
}

abstract class IHomePresenter extends BasePresenter<IHomeView> {
  IHomePresenter(IHomeView view) : super(view);

  HomeFabAnimationModel get homeFabAnimationModel;
  AppListModel get homeListModel;

  void startFabAnimation();
  startRefresh();
  startRemoveAppItem(AppItem item);
  startDefaultLogin();
}