import 'package:all/model/bean/qingmang_bean.dart';
import 'package:all/model/user_theme.dart';
import 'package:all/presenter/contract/home_contract.dart';
import 'package:all/view/widget/widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef OnItemTapCallback = void Function(AppItem item);

class HomeListWidget extends StatelessWidget {
  HomeListWidget(this.presenter, this.appItemList, {this.onItemTap});

  IHomePresenter presenter;
  final List<AppItem> appItemList;
  final OnItemTapCallback onItemTap;
  UserTextTheme _userTextTheme;

  @override
  Widget build(BuildContext context) {
    _userTextTheme = UserTextTheme.auto(context);
    return ListView.builder(
        itemCount: appItemList.length,
        itemBuilder: (context, index) {
          return item(context, index);
        });
  }

  Widget item(BuildContext context, int index) {
    AppItem item = appItemList[index];
    assert(item != null);
    return Dismissible(
      key: ValueKey(item),
      confirmDismiss: (_) {
        return Widgets.showAlertDialog(context, title: '是否删除 ${item.title} ?').then((result) {
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
                title: Text(item.title, style: _userTextTheme.title,),
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(item.icon),
                )),
          )),
    );
  }
}
