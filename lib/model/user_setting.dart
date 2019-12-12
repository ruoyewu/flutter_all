import 'package:shared_preferences/shared_preferences.dart';

class UserSetting {
	static const IS_USER_LOGIN = 'is_user_login';
	static const LOGIN_USER_ID = 'login_user_id';
	static const LOGIN_USER_PASSWORD = 'login_user_password';
	static const LOGIN_USER_NAME = 'login_user_name';
	static const AUTO_SHOW_DETAIL_BAR = 'auto_show_detail_bar';
	static const USER_APP = 'user_app';
	static const SEARCH_HISTORY = 'search_history';

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

	List<String> get savedAppItem => _sp.getStringList(USER_APP)?? [];

	set savedAppItem(List<String> appItems) {
		_sp.setStringList(USER_APP, appItems);
	}

	List<String> get searchHistory => _sp.getStringList(SEARCH_HISTORY)?? [];

	set searchHistory(List<String> items) {
		_sp.setStringList(SEARCH_HISTORY, items);
	}

	static _getSP() async {
		return await SharedPreferences.getInstance();
	}
}