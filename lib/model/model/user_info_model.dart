import 'package:all/model/bean/user_info.dart';
import 'package:flutter/cupertino.dart';

class UserInfoModel extends ChangeNotifier {
	UserInfo _userInfo = UserInfo();

	UserInfo get userInfo => _userInfo;

	set userInfo (UserInfo value) {
		_userInfo = value;
		notifyListeners();
	}

}