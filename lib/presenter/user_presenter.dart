import 'package:all/base/base_view.dart';
import 'package:all/model/bean/article_collection_list.dart';
import 'package:all/model/bean/article_collection_list_item.dart';
import 'package:all/model/bean/article_info.dart';
import 'package:all/model/bean/user_info.dart';
import 'package:all/model/model/article_collection_model.dart';
import 'package:all/model/model/user_info_model.dart';
import 'package:all/model/remote_data.dart';
import 'package:all/model/user_cache.dart';
import 'package:all/model/user_setting.dart';
import 'package:all/presenter/contract/user_contract.dart';
import 'package:all/utils/encrypt.dart';

class UserPresenter extends IUserPresenter {
  UserPresenter(BaseView view) : super(view);

  UserInfoModel _userInfoModel;
  ArticleCollectionModel _articleCollectionModel;
  int _nextCollection = 0;

  @override
  void initModel() {
    _userInfoModel = UserInfoModel();
    _articleCollectionModel = ArticleCollectionModel();
  }

  @override
  startLoadUserInfo({String id = null}) {
    if (id == null) {
      UserSetting.sInstance.then((setting) {
        if (setting.isUserLogin) {
          _startLoadUserInfo(Encrypt.sInstance.encrypt(setting.loginUserId));
        }
      });
    } else {
      _startLoadUserInfo(Encrypt.sInstance.encrypt(id));
    }
  }

  @override
  startLoadCollection(String user, {bool isRefresh = false}) {
    if (isRefresh) {
      _nextCollection = 0;
    }
    return RemoteData.articleCollection(user, _nextCollection).then((result) {
      if (isDisposed) return;
      if (result.successful) {
        ArticleCollectionList list = ArticleCollectionList.fromJson(result.info);
        _nextCollection = list.next;
        if (isRefresh) {
          _articleCollectionModel.articleCollectionList = list;
        } else {
          _articleCollectionModel.addAll(list, list.list.length == 10);
        }
      } else {
        view.onResultInfo(result.info);
      }
    });
  }

  @override
  startLogout() {
    RemoteData.logout().then((result) {
      _userInfoModel.userInfo = UserInfo();
      UserSetting.sInstance.then((setting) {
        setting.isUserLogin = false;
      });
    });
  }

  @override
  UserInfoModel get userInfoModel => _userInfoModel;

  @override
  ArticleCollectionModel get articleCollectionModel => _articleCollectionModel;

  @override
  String appIcon(String article) {
    return UserCache.appItemMap[article.split('_')[0]].icon;
  }

  @override
  onDetailResult(ArticleInfo info, ArticleCollectionListItem item) {
    if (info != null && !info.isCollect) {
      ArticleCollectionList list = _articleCollectionModel.articleCollectionList;
      list.list.remove(item);
      _articleCollectionModel.articleCollectionList = list;
    }
  }

  _startLoadUserInfo(String id) async {
    RemoteData.getUserInfo(id).then((result) {
      if (result.successful) {
        UserInfo userInfo = UserInfo.fromJson(result.info);
        _userInfoModel.userInfo = userInfo;
      } else {
        view.onResultInfo(result.info);
      }
    });
  }
}