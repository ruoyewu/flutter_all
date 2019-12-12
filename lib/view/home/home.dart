import 'dart:developer';

import 'package:all/base/base_state.dart';
import 'package:all/model/bean/qingmang_bean.dart' hide ResultIcons;
import 'package:all/model/model/home_model.dart';
import 'package:all/model/ui_data.dart';
import 'package:all/presenter/contract/home_contract.dart';
import 'package:all/presenter/home_presenter.dart';
import 'package:all/utils/provider_consumer.dart';
import 'package:all/view/home/home_list.dart';
import 'package:all/view/widget/widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'home_search.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends BaseState<HomePage, IHomePresenter>
    with SingleTickerProviderStateMixin
    implements IHomeView {

  BuildContext _snackbarContext;

  @override
  void initState() {
    super.initState();
    presenter = HomePresenter(this);
    presenter.startRefresh();
    presenter.startDefaultLogin();
  }

  @override
  void showDialog(String msg) {
    log(msg);
  }

  @override
  void onResultInfo(String info) {
    Widgets.showSnackBar(_snackbarContext, info);
  }

  @override
  TickerProvider get tickerProvider => this;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("ALL"),
          actions: <Widget>[
            IconButton(
              onPressed: () {
                showSearch<String>(
                        context: context, delegate: HomeSearchWidget(presenter))
                    .then((result) {
                  presenter.startRefresh();
                });
              },
              icon: Icon(Icons.search),
            ),
          ],
        ),
        body: Stack(
          children: <Widget>[
            container(context),
            buttons(context),
          ],
        ));
  }

  Widget container(BuildContext context) {
    return ProviderConsumer<HomeListModel>(
        presenter.homeListModel,
        (context, model, _) => RefreshIndicator(
              onRefresh: presenter.startRefresh,
              child: HomeListWidget(
                model.appItemList,
                onItemTap: (AppItem item) {
                  Navigator.pushNamed(context, UIData.ROUTE_APP,
                      arguments: item);
                },
              ),
            ));
  }

  Widget buttons(BuildContext context) {
    return SizedBox.expand(
      child: ProviderConsumer<HomeFabAnimationModel>(
        presenter.homeFabAnimationModel,
        (context, model, _) => Stack(
          alignment: Alignment.bottomRight,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 16, bottom: model.offsetSetting),
              child: FloatingActionButton(
                heroTag: "fab_setting",
                child: Icon(
                  Icons.settings,
                  color: Colors.white70,
                ),
                onPressed: () {},
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 16, bottom: model.offsetUser),
              child: FloatingActionButton(
                heroTag: "fab_user",
                child: Icon(
                  Icons.person,
                  color: Colors.white70,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, UIData.ROUTE_USER);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 16, bottom: 16),
              child: Transform.rotate(
                angle: model.rotateAdd,
                child: FloatingActionButton(
                  heroTag: "fab_add",
                  child: Icon(
                    Icons.add,
                    color: Colors.white70,
                  ),
                  onPressed: this.presenter.startFabAnimation,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
