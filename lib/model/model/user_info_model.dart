import 'package:all/model/bean/user_info.dart';
import 'package:flutter/cupertino.dart';

class UserInfoModel extends ChangeNotifier {
	UserInfoModel() {
		refresh();
	}

	UserInfo _userInfo;

	UserInfo get userInfo => _userInfo;

	set userInfo (UserInfo value) {
		_userInfo = value;
		notifyListeners();
	}

	refresh() {
		_userInfo = UserInfo();
		notifyListeners();
	}

}