import 'package:all/presenter/contract/user_contract.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserCollectionWidget extends StatelessWidget {
  UserCollectionWidget(this.presenter);

  IUserPresenter presenter;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: presenter.startRefreshCollection,
      child: ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: 1000,
          itemBuilder: (context, _) {
            return Text('test');
          }),
    );
  }
}
