import 'package:all/base/base_view.dart';
import 'package:all/model/bean/user_info.dart';
import 'package:all/model/model/user_info_model.dart';
import 'package:all/model/remote_data.dart';
import 'package:all/model/user_setting.dart';
import 'package:all/presenter/contract/user_contract.dart';

class UserPresenter extends IUserPresenter {
  UserPresenter(BaseView view) : super(view);

  UserInfoModel _userInfoModel;

  @override
  void initModel() {
    _userInfoModel = UserInfoModel();
  }

  @override
  startLoadUserInfo({String id = null}) {
  	if (id == null) {
  		UserSetting.sInstance.then((setting) {
  			if (setting.isUserLogin) {
  				_startLoadUserInfo(setting.loginUserId);
			  }
		  });
	  } else {
  		_startLoadUserInfo(id);
	  }
  }

  @override
  startRefreshCollection() {
    // TODO: implement startRefreshCollection
    return Future.value();
  }

  @override
  UserInfoModel get userInfoModel => _userInfoModel;

  _startLoadUserInfo(String id) async {
		RemoteData.getUserInfo(id).then((result) {
			if (result.result) {
				UserInfo userInfo = UserInfo.fromJson(result.info);
				_userInfoModel.userInfo = userInfo;
			} else {
				view.onResultInfo(result.info);
			}
		});
  }
}