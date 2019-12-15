import 'package:all/base/base_view.dart';
import 'package:all/model/bean/net_result.dart';
import 'package:all/model/bean/user_info.dart';
import 'package:all/model/model/login_verify_model.dart';
import 'package:all/model/remote_data.dart';
import 'package:all/model/user_setting.dart';
import 'package:all/presenter/contract/login_contract.dart';
import 'package:all/utils/encrypt.dart';

class LoginPresenter extends ILoginPresenter {
  LoginPresenter(BaseView view) : super(view);

  LoginVerifyModel _loginVerifyModel;

  @override
  void initModel() {
    _loginVerifyModel = LoginVerifyModel();
  }

  @override
  LoginVerifyModel get loginVerifyModel => _loginVerifyModel;

  @override
  startLogin(String id, String password) {
    if (id.length < 6) {
      view.onResultInfo('用户 ID 长度需大于 6');
      return;
    }
    if (password.length < 6) {
      view.onResultInfo('用户密码长度需大于 6');
      return;
    }
    Encrypt encrypt = Encrypt.sInstance;
    password = encrypt.encrypt(password);
    Future<NetResult> result = RemoteData.login(encrypt.encrypt(id), password);
    result.then((result) {
      if (isDisposed) return;
      if (result.successful) {
        UserInfo userInfo = UserInfo.fromJson(result.info);
        view.onLoginOk(userInfo);
        UserSetting.sInstance.then((setting) {
          setting.isUserLogin = true;
          setting.loginUserId = id;
          setting.loginUserPassword = password;
          setting.loginUserName = userInfo.name;
        });
      } else {
        view.onResultInfo(result.info);
      }
    });
  }

  @override
  startRegister(
      String id, String name, String password, String phone, String code) {
    Encrypt encrypt = Encrypt.sInstance;
    Future<NetResult> result = RemoteData.register(
        encrypt.encrypt(id),
        encrypt.encrypt(password),
        encrypt.encrypt(phone),
        encrypt.encrypt(code),
        encrypt.encrypt(name));
    result.then((result) {
      if (isDisposed) return;
      view.onResultInfo(result.info);
      if (result.successful) {
        view.onRegisterOk();
      }
    });
  }

  @override
  startSendVerifyCode(String phone) {
    Encrypt encrypt = Encrypt.sInstance;
    Future<NetResult> result = RemoteData.verifyCode(encrypt.encrypt(phone),
        encrypt.encrypt('86'), encrypt.encrypt('register'));
    result.then((result) {
      view.onResultInfo(result.info);
      if (result.successful) {
        _nextSecond(60);
      }
    });
  }

  _nextSecond(int left) {
    if (isDisposed) return;
    _loginVerifyModel.update(left);
    if (left > 0) {
      Future.delayed(Duration(seconds: 1), () {
        _nextSecond(left - 1);
      });
    }
  }
}
