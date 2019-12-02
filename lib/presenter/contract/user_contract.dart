import 'package:all/base/base_presenter.dart';
import 'package:all/base/base_view.dart';
import 'package:all/model/model/user_info_model.dart';

abstract class IUserView extends BaseView {
  onResultInfo(String info);
}

abstract class IUserPresenter extends BasePresenter<IUserView> {
  IUserPresenter(BaseView view) : super(view);

  UserInfoModel get userInfoModel;

  startLoadUserInfo({String id = null});
  startRefreshCollection();
}
