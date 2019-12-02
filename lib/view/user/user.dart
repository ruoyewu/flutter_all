import 'dart:developer';
import 'dart:ui';

import 'package:all/base/base_state.dart';
import 'package:all/model/bean/user_info.dart';
import 'package:all/model/model/user_info_model.dart';
import 'package:all/model/ui_data.dart';
import 'package:all/presenter/contract/user_contract.dart';
import 'package:all/presenter/user_presenter.dart';
import 'package:all/utils/provider_consumer.dart';
import 'package:all/view/user/user_collection.dart';
import 'package:all/view/user/user_history.dart';
import 'package:all/view/user/user_info.dart';
import 'package:all/view/user/user_not_login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _UserPageState();
  }
}

class _UserPageState extends BaseState<UserPage, IUserPresenter>
    implements IUserView {
  BuildContext _snackBarContext;

  @override
  void initState() {
    super.initState();
    presenter = UserPresenter(this);
    presenter.startLoadUserInfo();
  }

  @override
  onResultInfo(String info) {
    Scaffold.of(_snackBarContext).hideCurrentSnackBar();
    Scaffold.of(_snackBarContext).showSnackBar(SnackBar(
      content: Text(info),
    ));
  }

  onLoginTap({String id}) {
    if (id == null) {
      Navigator.pushNamed(context, UIData.ROUTE_LOGIN).then((result) {
        if (result != null) {
          presenter.userInfoModel.userInfo = result;
        }
      });
    } else {

    }
  }

  GlobalKey _key = GlobalKey(debugLabel: 'test');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) {
          _snackBarContext = context;
          return DefaultTabController(
            length: 3,
            child: ProviderConsumer<UserInfoModel>(presenter.userInfoModel,
                (context, model, _) {
              bool hasUser = model.userInfo.id != null;
              return NotificationListener(
                onNotification: (notification) {
                  log("on notification: ${notification.runtimeType}");
                  log("${_key.currentState.runtimeType}");
                  return false;
                },
                child: NestedScrollView(
                  headerSliverBuilder: (context, _) {
                    return <Widget>[
                      SliverAppBar(
                        pinned: true,
                        expandedHeight: 300,
                        title: Text('title'),
                        flexibleSpace: NotificationListener(
                          onNotification: (notification) {
                            log("on notification");
                            return false;
                          },
                          child: FlexibleSpaceBar(
                            key: _key,
                            background: Stack(
                              fit: StackFit.expand,
                              children: <Widget>[
                                FadeInImage.assetNetwork(
                                    width: double.infinity,
                                    height: double.infinity,
                                    placeholder: 'assets/images/ic_avatar.png',
                                    image: model.userInfo.avatar ?? ''),
                                ClipRect(
                                  child: BackdropFilter(
                                      filter:
                                          ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                                      child: Container(
                                        color: Colors.black.withOpacity(0),
                                        child: _userAvatarCenter(model.userInfo),
                                      )),
                                )
                              ],
                            ),
                          ),
                        ),
                        bottom: TabBar(
                          tabs: _tabView(),
                        ),
                      ),
                    ];
                  },
                  body: TabBarView(children: _contentView(hasUser)),
                ),
              );
            }),
          );
        },
      ),
    );
  }
  
  Widget _userAvatarCenter(UserInfo userInfo) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          GestureDetector(
            onTap: () => onLoginTap(id: userInfo.id),
            child: CircleAvatar(
              radius: 35,
              backgroundImage: AssetImage('assets/images/ic_avatar.png'),
              child: Image.network(
                userInfo.avatar?? ''
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(
              userInfo.name?? '点击登录',
              style: TextStyle(
                fontSize: 18,
                color: Colors.black87
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Text(
              userInfo.sign?? '',
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.black54
              ),
            ),
          )
        ],
      ),
    );
  }

  List<Widget> _tabView() {
    return [
      Tab(
        text: '收藏文章',
      ),
      Tab(
        text: '个人历程',
      ),
      Tab(
        text: '个人信息',
      ),
    ];
  }

  List<Widget> _contentView(bool hasUser) {
    if (hasUser) {
      return [
        UserCollectionWidget(presenter),
        UserHistoryWidget(presenter),
        UserInfoWidget(presenter),
      ];
    } else {
      return [
        UserNotLoginWidget(onLoginTap),
        UserNotLoginWidget(onLoginTap),
        UserNotLoginWidget(onLoginTap),
      ];
    }
  }
}
