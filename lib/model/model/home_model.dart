import 'package:all/model/bean/app_item.dart';
import 'package:flutter/cupertino.dart';

class HomeFabAnimationModel with ChangeNotifier {
  double _offsetSetting = 16;
  double _offsetUser = 16;
  double _rotateAdd = 0;

  double get offsetSetting => _offsetSetting;

  double get offsetUser => _offsetUser;

  double get rotateAdd => _rotateAdd;

  update(double offsetSetting, double offsetUser, double rotateAdd) {
    _offsetUser = offsetUser;
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