
import 'package:all/base/base_presenter.dart';
import 'package:all/base/base_view.dart';
import 'package:all/model/model/home_model.dart';
import 'package:flutter/cupertino.dart';

abstract class IHomeView extends BaseView {
  void showDialog(String msg);

  TickerProvider get tickerProvider;
}

abstract class IHomePresenter extends BasePresenter<IHomeView> {
  IHomePresenter(IHomeView view) : super(view);

  HomeFabAnimationModel get homeFabAnimationModel;
  HomeListModel get homeListModel;

  void startFabAnimation();
  Future<void> startRefresh();
}