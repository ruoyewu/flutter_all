import 'package:all/base/base_state.dart';
import 'package:all/model/bean/user_info.dart';
import 'package:all/presenter/contract/login_contract.dart';
import 'package:all/presenter/login_presenter.dart';
import 'package:all/view/login/login_login.dart';
import 'package:all/view/login/login_register.dart';
import 'package:all/view/widget/widget.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends BaseState<LoginPage, ILoginPresenter>
    with SingleTickerProviderStateMixin
    implements ILoginView {

  TabController _tabController;
  BuildContext _snackBarContext;

  @override
  void initState() {
    super.initState();
    presenter = LoginPresenter(this);
    _tabController = TabController(
      length: 2,
      vsync: this,
    );
  }

  @override
  onResultInfo(String info) {
    Widgets.showSnackBar(_snackBarContext, info);
  }

  @override
  onLoginOk(UserInfo userInfo) {
    Navigator.pop(context, userInfo);
  }

  @override
  onRegisterOk() {
    _tabController.animateTo(0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('用户登录'),
          bottom: TabBar(
            controller: _tabController,
            indicatorSize: TabBarIndicatorSize.label,
            isScrollable: false,
            tabs: <Widget>[
              Tab(text: '登录'),
              Tab(
                text: '注册',
              )
            ],
          ),
        ),
        body: Builder(builder: (context) {
          _snackBarContext = context;
          return TabBarView(
            controller: _tabController,
            children: <Widget>[
              LoginLoginWidget(
                presenter,
                onRegisterTap: () {
                  _tabController.animateTo(1);
                },
              ),
              LoginRegisterWidget(presenter)
            ],
          );
        }));
  }
}
