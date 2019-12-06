import 'package:all/base/base_presenter.dart';
import 'package:all/base/base_view.dart';
import 'package:all/model/bean/article_collection_list_item.dart';
import 'package:all/model/bean/article_info.dart';
import 'package:all/model/model/article_collection_model.dart';
import 'package:all/model/model/user_info_model.dart';

abstract class IUserView extends BaseView {
  onResultInfo(String info);


}

abstract class IUserPresenter extends BasePresenter<IUserView> {
  IUserPresenter(BaseView view) : super(view);

  UserInfoModel get userInfoModel;
  ArticleCollectionModel get articleCollectionModel;

  String appIcon(String article);
  onDetailResult(ArticleInfo info, ArticleCollectionListItem item);

  Future<String> startPickerImage(int type);
  startLoadUserInfo({String id = null});
  startLoadCollection(String user, {bool isRefresh = false});
  startLogout();
}
