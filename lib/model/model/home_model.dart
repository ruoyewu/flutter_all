import 'package:all/model/bean/qingmang_bean.dart';
import 'package:flutter/cupertino.dart';

class HomeFabAnimationModel with ChangeNotifier {
  double _offsetSetting = 16;
  double _scaleSetting = 1;
  double _offsetUser = 16;
  double _scaleUser = 1;
  double _rotateAdd = 0;

  double get offsetSetting => _offsetSetting;

  double get offsetUser => _offsetUser;

  double get rotateAdd => _rotateAdd;

  double get scaleSetting => _scaleSetting;

  double get scaleUser => _scaleUser;

  update(double offsetSetting, double scaleSetting, double offsetUser,
      double scaleUser, double rotateAdd) {
    _scaleUser = scaleUser;
    _offsetUser = offsetUser;
    _scaleSetting = scaleSetting;
    _offsetSetting = offsetSetting;
    _rotateAdd = rotateAdd;
    notifyListeners();
  }
}

class HomeListModel with ChangeNotifier {
  List<AppItem> _appItemList = List();

  List<AppItem> get appItemList => _appItemList;

  set appItemList(List<AppItem> value) {
    _appItemList = value;
    notifyListeners();
  }
}
