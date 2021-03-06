import 'package:all/model/bean/qingmang_bean.dart';
import 'package:all/model/bean/qingmang_result.dart';
import 'package:all/model/model/search_app_item_model.dart';
import 'package:all/model/model/search_section_model.dart';
import 'package:all/model/remote_data.dart';
import 'package:all/model/user_setting.dart';
import 'package:all/presenter/contract/search_section_contract.dart';

class SearchSectionPresenter extends ISearchSectionPresenter {
  SearchSectionPresenter(ISearchSectionView view, this.sectionId) : super(view);

  final sectionId;

  SearchSectionModel _searchSectionModel;
  String _nextUrl;

  @override
  void initModel() {
    _searchSectionModel = SearchSectionModel();
  }

  @override
  void dispose() {
    super.dispose();
    _searchSectionModel.dispose();
  }

  @override
  SearchSectionModel get searchSectionModel => _searchSectionModel;

  @override
  startLoadSection() async {
    Result result = (_nextUrl == null)
        ? await RemoteData.section(sectionId)
        : await RemoteData.request(_nextUrl);
    if (isDisposed) return;
    if (result.isSuccessful) {
      List<AppItem> list =
          result.entityList?.map((item) => AppItem.fromJson(item))?.toList() ??
              [];
      Set<AppItem> delete = Set();
      for (AppItem item in list) {
        if (item.detail == null) {
          delete.add(item);
          continue;
        }
        item.userSaved = (await UserSetting.userApp.lazy)
            .contains(item.detail.appDetail.packageName);
      }
      for (AppItem item in delete) {
        list.remove(item);
      }
      _searchSectionModel.list = list;
      _searchSectionModel.hasMore = result.hasMore;
      if (result.hasMore) {
        _nextUrl = result.nextUrl;
      } else {
        _nextUrl = '';
      }
    }
  }

  @override
  startAddAppItem(SearchAppItemModel model) async {
    List<String> list = await UserSetting.userApp.lazy;
    if (!model.appItem.userSaved) {
      list.add(model.appItem.detail.appDetail.packageName);
    } else {
      list.remove(model.appItem.detail.appDetail.packageName);
    }
    UserSetting.userApp.value = list;
    model.appItem.userSaved = !model.appItem.userSaved;
    model.update();
  }
}
