import 'package:all/base/base_state.dart';
import 'package:all/model/model/app_list_model.dart';
import 'package:all/model/ui_data.dart';
import 'package:all/model/user_color.dart';
import 'package:all/presenter/contract/home_contract.dart';
import 'package:all/presenter/home_presenter.dart';
import 'package:all/utils/provider_consumer.dart';
import 'package:all/view/app.dart';
import 'package:all/view/widget/widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'home_list.dart';

class HomeContainerPage extends StatefulWidget {
  HomeContainerPage({this.type = Type.MATERIAL});

  final heroTag = 'home';
  final Type type;

  @override
  State<StatefulWidget> createState() {
    return _HomeContainerState.type(type);
  }
}

abstract class _HomeContainerState
    extends BaseState<HomeContainerPage, IHomePresenter>
    with SingleTickerProviderStateMixin
    implements IHomeView {
  BuildContext _snackbarContext;

  static type(Type type) {
    switch (type) {
      case Type.MATERIAL:
        return _HomeContainerStateMaterial();
      case Type.CUPRETINO:
        return _HomeContainerStateCupertino();
    }
  }

  @override
  void initState() {
    super.initState();
    presenter = HomePresenter(this);
    presenter.startRefresh();
    presenter.startDefaultLogin();
  }

  @override
  void onResultInfo(String info) {
    Widgets.showSnackBar(_snackbarContext, info);
  }

  @override
  TickerProvider get tickerProvider => this;

  onItemTap(item) {
    Navigator.pushNamed(context, UIData.ROUTE_APP,
        arguments: {'item': item, 'hero': widget.heroTag, 'title': 'ALL'});
  }

  @override
  Widget build(BuildContext context) {
    return body(context);
  }
}

class _HomeContainerStateCupertino extends _HomeContainerState {
  Widget buildBody(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        CupertinoSliverRefreshControl(
          refreshIndicatorExtent: 100,
          refreshTriggerPullDistance: 120,
          onRefresh: () {
            return presenter.startRefresh();
          },
        ),
        CupertinoSliverNavigationBar(
          heroTag: widget.heroTag,
          largeTitle: const Text("ALL"),
          backgroundColor: UserColor.COLOR_TRANSPARENT_ALABASTER,
        ),
        ProviderConsumer<AppListModel>(
            presenter.homeListModel,
            (context, model, _) => HomeListWidget.type(
                  widget.type,
                  presenter,
                  model.appItemList,
                  onItemTap: onItemTap,
                ))
      ],
    );
  }
}

class _HomeContainerStateMaterial extends _HomeContainerState {
  @override
  Widget buildBody(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ALL"),
      ),
      body: ProviderConsumer<AppListModel>(
          presenter.homeListModel,
          (context, model, _) => RefreshIndicator(
                onRefresh: presenter.startRefresh,
                child: HomeListWidget.type(
                  widget.type,
                  presenter,
                  model.appItemList,
                  onItemTap: onItemTap,
                ),
              )),
    );
  }
}
