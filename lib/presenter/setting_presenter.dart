import 'package:all/model/user_setting.dart';
import 'package:all/presenter/contract/setting_contract.dart';

class SettingPresenter extends ISettingPresenter {
  SettingPresenter(ISettingView view) : super(view);

  @override
  startSetArticleListType(int type) async {
  	UserSetting setting = await UserSetting.sInstance;
  	setting.articleListType = type;
  }

}