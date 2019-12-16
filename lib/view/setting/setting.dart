import 'package:all/base/base_state.dart';
import 'package:all/presenter/contract/setting_contract.dart';
import 'package:all/presenter/setting_presenter.dart';
import 'package:flutter/material.dart';

class SettingPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SettingPageState();
  }
}

class _SettingPageState extends BaseState<SettingPage, ISettingPresenter>
    implements ISettingView {

  @override
  void initState() {
    super.initState();
    presenter = SettingPresenter(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('设置'),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[

        ],
      ),
    );
  }

  Widget _buildArticleListType() {

  }
}
