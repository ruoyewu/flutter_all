import 'package:all/model/bean/app_item.dart';
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


  update(double offsetSetting, double scaleSetting, double offsetUser, double scaleUser, double rotateAdd) {
    _scaleUser = scaleUser;
    _offsetUser = offsetUser;
    _scaleSetting = scaleSetting;
    _offsetSetting = offsetSetting;
    _rotateAdd = rotateAdd;
    notifyListeners();
  }
}

class HomeListModel with ChangeNotifier {
  List<String> _appNameList = List();
  Map<String, AppItem> _appItemMap = Map();

  List<String> get appNameList => _appNameList;

  Map<String, AppItem> get appItemMap => _appItemMap;

  update(List<String> appNameList, Map<String, AppItem> appItemMap) {
    _appItemMap = appItemMap;
    _appNameList = appNameList;
    notifyListeners();
  }
}