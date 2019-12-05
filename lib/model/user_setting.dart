import 'package:shared_preferences/shared_preferences.dart';

class UserSetting {
	static const IS_USER_LOGIN = 'is_user_login';
	static const LOGIN_USER_ID = 'login_user_id';
	static const LOGIN_USER_PASSWORD = 'login_user_password';
	static const LOGIN_USER_NAME = 'login_user_name';
	static const AUTO_SHOW_DETAIL_BAR = 'auto_show_detail_bar';

	static UserSetting _sInstance;
	SharedPreferences _sp;

	static Future<UserSetting> get sInstance async {
		if (_sInstance != null) {
			return Future.value(_sInstance);
		}
		SharedPreferences sp = await _getSP();
		_sInstance = UserSetting();
		_sInstance._sp = sp;
		return _sInstance;
	}

	set isUserLogin(bool login) {
		_sp.setBool(IS_USER_LOGIN, login);
	}

	bool get isUserLogin {
		return _sp.getBool(IS_USER_LOGIN)?? false;
	}

	set loginUserId(String id) {
		_sp.setString(LOGIN_USER_ID, id);
	}

	String get loginUserId {
		return _sp.get(LOGIN_USER_ID)?? '';
	}

	set loginUserPassword(String password) {
		_sp.setString(LOGIN_USER_PASSWORD, password);
	}

	String get loginUserPassword {
		return _sp.getString(LOGIN_USER_PASSWORD)?? '';
	}

	String get loginUserName {
		return _sp.get(LOGIN_USER_NAME)?? '';
	}

	set loginUserName(String name) {
		_sp.setString(LOGIN_USER_NAME, name);
	}

	bool get autoShowDetailBar => _sp.getBool(AUTO_SHOW_DETAIL_BAR)?? true;

	set autoShowDetailBar(bool show) {
		_sp.setBool(AUTO_SHOW_DETAIL_BAR, show);
	}

	static _getSP() async {
		return await SharedPreferences.getInstance();
	}
}