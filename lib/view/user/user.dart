import 'dart:ui';

import 'package:all/base/base_state.dart';
import 'package:all/model/bean/user_info.dart';
import 'package:all/model/model/user_info_model.dart';
import 'package:all/model/ui_data.dart';
import 'package:all/presenter/contract/user_contract.dart';
import 'package:all/presenter/user_presenter.dart';
import 'package:all/utils/image_util.dart';
import 'package:all/utils/provider_consumer.dart';
import 'package:all/view/user/user_collection.dart';
import 'package:all/view/user/user_history.dart';
import 'package:all/view/user/user_info.dart';
import 'package:all/view/user/user_not_login.dart';
import 'package:all/view/widget/widget.dart';
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
    Future.delayed(Duration(milliseconds: 0), () {
      presenter.startLoadUserInfo(
          id: ModalRoute.of(context).settings.arguments);
    });
  }

  @override
  onResultInfo(String info) {
    Widgets.showSnackBar(_snackBarContext, info);
  }

  onLoginTap({String id}) {
    if (id == null) {
      Navigator.pushNamed(context, UIData.ROUTE_LOGIN).then((result) {
        if (result != null) {
          presenter.userInfoModel.userInfo = result;
        }
      });
    } else {
      Widgets.showSimpleDialog(context, ['上传头像', '注销登录']).then((index) {
        switch (index) {
          case 0:
            Widgets.showSimpleDialog(context, ['相册选取', '相机拍摄']).then((index) {
              presenter.startPickerImage(index);
            });
            break;
          case 1:
            presenter.startLogout();
            break;
        }
      });
    }
  }

  onImagePickerTap(int type) {}

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
                  return false;
                },
                child: NestedScrollView(
                  headerSliverBuilder: (context, _) {
                    return <Widget>[
                      SliverAppBar(
                        pinned: true,
                        expandedHeight: 300,
                        title: Text(''),
                        flexibleSpace: FlexibleSpaceBar(
                          key: _key,
                          background: Stack(
                            fit: StackFit.expand,
                            children: <Widget>[
                              FadeInImage(
                                width: double.infinity,
                                height: double.infinity,
                                fit: BoxFit.cover,
                                placeholder:
                                    AssetImage('assets/images/ic_avatar.png'),
                                image: ImageUtil.image(
                                    model.userInfo.avatar ?? ''),
                              ),
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
                        bottom: TabBar(
                          tabs: _tabView(),
                        ),
                      ),
                    ];
                  },
                  body: TabBarView(
                      children: _contentView(
                          hasUser, hasUser ? model.userInfo.id : null)),
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
              backgroundColor: Colors.transparent,
              backgroundImage: ImageUtil.image(userInfo.avatar,
                  placeHolder: 'assets/images/ic_avatar.png'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(
              userInfo.name ?? '点击登录',
              style: TextStyle(fontSize: 18, color: Colors.black87),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Text(
              userInfo.sign ?? '',
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.black54),
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

  List<Widget> _contentView(bool hasUser, String userId) {
    if (hasUser) {
      return [
        UserCollectionWidget(presenter, userId),
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
