import 'package:shared_preferences/shared_preferences.dart';

abstract class UserSetting<T> {
	static final loginId          = StringUserSetting('login_user_id', '');
	static final loginPassword    = StringUserSetting('login_user_password', '');
	static final loginUserName    = StringUserSetting('login_user_name', '');
	static final isLogin          = BoolUserSetting('is_user_login', false);
	static final userApp          = StringListUserSetting('user_app', []);
	static final searchHistory    = StringListUserSetting('search_history', []);
	static final articleListType  = IntUserSetting('article_list_type', 1);
	static final userMaterial     = BoolUserSetting('user_material', false);

	static SharedPreferences _sp;

	String key;
	T defaultValue;

	UserSetting(this.key, this.defaultValue);

	static Future<SharedPreferences> get sp async {
		if (_sp == null) {
			SharedPreferences sp = await SharedPreferences.getInstance();
			_sp = sp;
		}
		return _sp;
	}

	Future<T> get lazy async {
		return await _getValue()?? defaultValue;
	}

	set value(T value) {
		return _setValue(value);
	}

	Future<T> _getValue();
	_setValue(T value);
}

class StringUserSetting extends UserSetting<String> {
	StringUserSetting (String key, String defaultValue) : super(key, defaultValue);

  @override
  Future<String> _getValue() {
  	return UserSetting.sp.then((sp) {
  		return sp.getString(key);
	  });
  }

  @override
  _setValue(String value) {
  	UserSetting.sp.then((sp) {
  		sp.setString(key, value);
	  });
  }
}

class BoolUserSetting extends UserSetting<bool> {
  BoolUserSetting(String key, bool defaultValue) : super(key, defaultValue);

  @override
  Future<bool> _getValue() {
  	return UserSetting.sp.then((sp) {
  		return sp.getBool(key);
	  });
  }

  @override
  _setValue(bool value) {
  	UserSetting.sp.then((sp) {
  		sp.setBool(key, value);
	  });
  }
}

class StringListUserSetting extends UserSetting<List<String>> {
  StringListUserSetting(String key, List<String> defaultValue) : super(key, defaultValue);

  @override
  Future<List<String>> _getValue() {
  	return UserSetting.sp.then((sp) {
  		return sp.getStringList(key);
	  });
  }

  @override
  _setValue(List<String> value) {
  	UserSetting.sp.then((sp) {
  		sp.setStringList(key, value);
	  });
  }
}

class IntUserSetting extends UserSetting<int> {
  IntUserSetting(String key, int defaultValue) : super(key, defaultValue);

  @override
  Future<int> _getValue() {
  	return UserSetting.sp.then((sp) {
  		return sp.getInt(key);
	  });
  }

  @override
  _setValue(int value) {
  	UserSetting.sp.then((sp) {
  		sp.setInt(key, value);
	  });
  }
}