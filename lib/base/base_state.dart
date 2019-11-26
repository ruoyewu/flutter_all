
import 'package:all/base/base_presenter.dart';
import 'package:flutter/cupertino.dart';

abstract class BaseState<T extends StatefulWidget, P extends BasePresenter> extends State<T> {
  P _p;
  P get presenter => _p;
  set presenter(P p) {
    _p = p;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    if (_p != null) {
      _p.dispose();
      _p = null;
    }
  }
}