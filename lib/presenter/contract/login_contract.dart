import 'package:all/base/base_presenter.dart';
import 'package:all/base/base_view.dart';
import 'package:all/model/bean/user_info.dart';
import 'package:all/model/model/login_verify_model.dart';

abstract class ILoginView extends BaseView {
  onResultInfo(String info);
  onLoginOk(UserInfo info);
  onRegisterOk();
}

abstract class ILoginPresenter extends BasePresenter<ILoginView> {
  ILoginPresenter(BaseView view) : super(view);

  LoginVerifyModel get loginVerifyModel;

  startSendVerifyCode(String phone);
  startLogin(String id, String password);
  startRegister(String id, String name, String password, String phone, String code);
}