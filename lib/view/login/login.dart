import 'package:all/base/base_state.dart';
import 'package:all/model/bean/user_info.dart';
import 'package:all/model/model/login_segment_value_model.dart';
import 'package:all/presenter/contract/login_contract.dart';
import 'package:all/presenter/login_presenter.dart';
import 'package:all/utils/provider_consumer.dart';
import 'package:all/view/app.dart';
import 'package:all/view/login/login_login.dart';
import 'package:all/view/login/login_register.dart';
import 'package:all/view/widget/widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  LoginPage(this.type);

  final type;

  @override
  State<StatefulWidget> createState() {
    return _LoginPageState.type(type);
  }
}

abstract class _LoginPageState extends BaseState<LoginPage, ILoginPresenter>
    with SingleTickerProviderStateMixin
    implements ILoginView {
  static type(Type type) {
    switch (type) {
      case Type.MATERIAL:
        return _LoginPageStateMaterial();
      case Type.CUPRETINO:
        return _LoginPageStateCupertino();
    }
  }

  @override
  void initState() {
    super.initState();
    presenter = LoginPresenter(this);
  }

  @override
  onLoginOk(UserInfo userInfo) {
    Navigator.pop(context, userInfo);
  }

  onRegisterTap();

  @override
  Widget build(BuildContext context) {
    return body(context);
  }

  List<Widget> _buildPages() {
    return [
      LoginLoginWidget(
        presenter,
        onRegisterTap: onRegisterTap,
      ),
      LoginRegisterWidget(presenter)
    ];
  }
}

class _LoginPageStateCupertino extends _LoginPageState {
  PageController _pageController;
  LoginSegmentValueModel _segmentValueModel;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _segmentValueModel = LoginSegmentValueModel();
  }

  @override
  onRegisterOk() {
    _pageController.animateTo(0,
        duration: kTabScrollDuration, curve: Curves.ease);
  }

  @override
  onResultInfo(String info) {}

  @override
  onRegisterTap() {
    _pageController.animateTo(MediaQuery.of(context).size.width,
        duration: kTabScrollDuration, curve: Curves.ease);
  }

  @override
  Widget buildBody(BuildContext context) {
    Map arguments = ModalRoute.of(context).settings.arguments;
    final lastTitle = arguments['title'];
    final heroTag = arguments['hero'];
    return CupertinoPageScaffold(
      child: CustomScrollView(
        slivers: <Widget>[
          CupertinoSliverNavigationBar(
            heroTag: heroTag,
            previousPageTitle: lastTitle,
            largeTitle: const Text('登录'),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Column(
                children: _buildContainer(),
              ),
            ),
          )
        ],
      ),
    );
  }

  Map<int, Widget> _buildSegmentChildren() {
    return {
      0: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 3),
        child: const Text(
          '登录',
          style: TextStyle(fontSize: 14),
        ),
      ),
      1: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 3),
        child: const Text(
          '注册',
          style: TextStyle(fontSize: 14),
        ),
      )
    };
  }

  List<Widget> _buildContainer() {
    return <Widget>[
      ProviderConsumer<LoginSegmentValueModel>(_segmentValueModel,
          (context, model, _) {
        return CupertinoSlidingSegmentedControl(
          children: _buildSegmentChildren(),
          onValueChanged: (int value) {
            model.value = value;
            _pageController.animateTo(value * MediaQuery.of(context).size.width,
                duration: kTabScrollDuration, curve: Curves.ease);
          },
          groupValue: model.value,
        );
      }),
      SizedBox(
        height: MediaQuery.of(context).size.height * 0.6,
        child: Material(
          child: PageView(
            controller: _pageController,
            children: _buildPages(),
            onPageChanged: (value) {
              _segmentValueModel.value = value;
            },
          ),
        ),
      ),
    ];
  }
}

class _LoginPageStateMaterial extends _LoginPageState {
  TabController _tabController;
  BuildContext _snackBarContext;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 2,
      vsync: this,
    );
  }

  @override
  onRegisterOk() {
    _tabController.animateTo(0);
  }

  @override
  onResultInfo(String info) {
    Widgets.showSnackBar(_snackBarContext, info);
  }

  @override
  onRegisterTap() {
    _tabController.animateTo(1);
  }

  @override
  Widget buildBody(BuildContext context) {
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
            children: _buildPages(),
          );
        }));
  }
}
