import 'package:all/model/bean/qingmang_bean.dart';
import 'package:all/model/model/article_list_model.dart';
import 'package:all/model/remote_data.dart';
import 'package:all/model/user_setting.dart';
import 'package:all/presenter/contract/app_contract.dart';

class ArticleListPresenter extends IArticleListPresenter {
  ArticleListPresenter(IArticleListView view, this.channel) : super(view);

  AppChannel channel;
  String nextUrl;

  ArticleListModel _articleListModel;

  @override
  void initModel() async {
    _articleListModel = ArticleListModel();
    _articleListModel.type = await UserSetting.articleListType.value;
  }

  @override
  void dispose() {
    super.dispose();
    _articleListModel.dispose();
  }

  @override
  ArticleListModel get articleListModel => _articleListModel;

  @override
  Future<void> startLoadMore({bool isRefresh = false}) {
    if (isRefresh || nextUrl == null) {
      return RemoteData.articleList(channel.id).then((result) {
        if (result.isSuccessful) {
          List<ArticleListItem> list = result.hasData
              ? result.entityList
                  .map((entry) => ArticleListItem.fromJson(entry))
                  .toList()
              : List();
          _articleListModel.articleList = list;
          _articleListModel.hasMore = result.hasMore;
          nextUrl = result.nextUrl;
        }
      });
    } else {
      return RemoteData.request(nextUrl).then((result) {
        if (result.isSuccessful) {
          List<ArticleListItem> list = result.entityList
              .map((entry) => ArticleListItem.fromJson(entry))
              .toList();
          _articleListModel.addAll(list);
          _articleListModel.hasMore = result.hasMore;
          if (result.hasMore) {
            nextUrl = result.nextUrl;
          } else {
            nextUrl = '';
          }
        }
      });
    }
  }
}
