
import 'package:all/base/base_presenter.dart';
import 'package:flutter/material.dart';

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
  Widget build(BuildContext context) {
    return body(context);
  }

  Widget _body;
  Widget body(BuildContext context) {
    if (_body == null) {
      _body = buildBody(context);
    }
    return _body;
  }
  Widget buildBody(BuildContext context);

  @override
  void dispose() {
    super.dispose();
    if (_p != null) {
      _p.dispose();
      _p = null;
    }
  }
}