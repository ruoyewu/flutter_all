import 'package:all/model/bean/qingmang_bean.dart';
import 'package:all/model/user_theme.dart';
import 'package:all/presenter/contract/home_contract.dart';
import 'package:all/utils/function.dart';
import 'package:all/view/app.dart';
import 'package:all/view/widget/widget.dart';
import 'package:flutter/material.dart';

class HomeListWidget extends StatelessWidget {
  HomeListWidget._(this.presenter, this.appItemList, {this.onItemTap});

  // ignore: missing_return
  factory HomeListWidget.type(
      Type type, IHomePresenter presenter, List<AppItem> appItemList,
      {OnAppItemTapCallback onItemTap}) {
    switch (type) {
      case Type.MATERIAL:
        return _HomeListWidgetMaterial(
          presenter,
          appItemList,
          onItemTapCallback: onItemTap,
        );
      case Type.CUPRETINO:
        return _HomeListWidgetCupertino(
          presenter,
          appItemList,
          onItemTapCallback: onItemTap,
        );
    }
  }

  final IHomePresenter presenter;
  final List<AppItem> appItemList;
  final OnAppItemTapCallback onItemTap;
  UserTextTheme _userTextTheme;

  @override
  Widget build(BuildContext context) {
    _userTextTheme = UserTextTheme.auto(context);
  }

  Widget item(BuildContext context, int index) {
    AppItem item = appItemList[index];
    assert(item != null);
    return Dismissible(
      key: ValueKey(item),
      confirmDismiss: (_) {
        return Widgets.showAlertDialog(context, title: '是否删除 ${item.title} ?')
            .then((result) {
          if (result != null && result == 0) {
            return true;
          } else {
            return false;
          }
        });
      },
      onDismissed: (_) {
        presenter.startRemoveAppItem(item);
      },
      background: Container(
        width: 50,
        height: double.infinity,
        color: Colors.redAccent,
        alignment: Alignment.centerRight,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            '删除',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ),
      child: InkWell(
          onTap: () => onItemTap(item),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: ListTile(
                title: Text(
                  item.title,
                  style: _userTextTheme.title,
                ),
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(item.icon),
                )),
          )),
    );
  }
}

class _HomeListWidgetCupertino extends HomeListWidget {
  _HomeListWidgetCupertino(IHomePresenter presenter, List<AppItem> appItemList,
      {OnAppItemTapCallback onItemTapCallback})
      : super._(presenter, appItemList, onItemTap: onItemTapCallback);

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SliverSafeArea(
      top: false,
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return Material(child: item(context, index));
          },
          childCount: appItemList?.length ?? 0,
        ),
      ),
    );
  }
}

class _HomeListWidgetMaterial extends HomeListWidget {
  _HomeListWidgetMaterial(IHomePresenter presenter, List<AppItem> appItemList,
      {OnAppItemTapCallback onItemTapCallback})
      : super._(presenter, appItemList, onItemTap: onItemTapCallback);

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ListView.builder(
        itemCount: appItemList?.length ?? 0,
        itemBuilder: (context, index) {
          return item(context, index);
        });
  }
}
