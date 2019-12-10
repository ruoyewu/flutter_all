import 'package:all/model/bean/qingmang_bean.dart';
import 'package:all/model/model/app_model.dart';
import 'package:all/model/remote_data.dart';
import 'package:all/presenter/contract/app_contract.dart';

class ArticleListPresenter extends IArticleListPresenter {
  ArticleListPresenter(IArticleListView view, this.channel) : super(view);

//  final app;
//  final category;
  AppChannel channel;
//  int start = 0;
  String nextUrl;

  ArticleListModel _articleListModel;

  @override
  void initModel() {
    _articleListModel = ArticleListModel();
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
      return RemoteData.articleList(0, 10, channel.id).then((result) {
        if (result.isSuccessful) {
          List<ArticleListItem> list = result.entityList.map((entry) => ArticleListItem.fromJson(entry)).toList();
          _articleListModel.articleList = list;
          nextUrl = result.nextUrl;
        }
      });
    } else {
      return RemoteData.request(nextUrl).then((result) {
        if (result.isSuccessful) {
          List<ArticleListItem> list = result.entityList.map((entry) => ArticleListItem.fromJson(entry)).toList();
          _articleListModel.addAll(list);
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