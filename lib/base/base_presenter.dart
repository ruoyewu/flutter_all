
import 'package:all/base/base_view.dart';

abstract class BasePresenter<V extends BaseView> {
  V _v;
  V get view => _v;

  bool _isDisposed;
  bool get isDisposed => _isDisposed;

  BasePresenter(V view) {
    attach(view);

    initModel();
    initView();
    initListener();
    initData();
  }

  void attach(V view) {
    assert(view != null);
    _v = view;
    _isDisposed = false;
  }

  void initModel() {}
  void initView() {}
  void initListener() {}
  void initData() {}

  void dispose() {
    if (_v != null) {
      _v = null;
      _isDisposed = true;
    }
  }
}