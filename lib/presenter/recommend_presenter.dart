import 'package:all/model/bean/qingmang_bean.dart';
import 'package:all/model/bean/qingmang_result.dart';
import 'package:all/model/model/article_list_model.dart';
import 'package:all/model/remote_data.dart';
import 'package:all/model/user_setting.dart';
import 'package:all/presenter/contract/recommend_contract.dart';

class RecomendPresenter extends IRecommendPresenter {
  RecomendPresenter(IRecommendView view, this.recommend) : super(view);

  final ResultRecommend recommend;
  ArticleListModel _articleListModel;
  String _nextUrl;

  @override
  void initModel() async {
    super.initModel();
    _articleListModel = ArticleListModel();
    _articleListModel.type = await UserSetting.articleListType.lazy;
  }

  @override
  void dispose() {
    super.dispose();
    _articleListModel.dispose();
  }

  @override
  ArticleListModel get articleListModel => _articleListModel;

  @override
  startLoadMore({bool isRefresh = false}) async {
    Result result = (_nextUrl == null || isRefresh)
        ? await RemoteData.recommendList('', url: recommend.action.url)
        : await RemoteData.request(_nextUrl);
    if (result.isSuccessful) {
      List<ArticleListItem> list = result.entityList
              ?.map((item) => ArticleListItem.fromJson(item))
              ?.toList() ??
          [];
      if (isRefresh) {
        _articleListModel.articleList = list;
      } else {
        _articleListModel.addAll(list);
      }
      _articleListModel.hasMore = result.hasMore;
      _nextUrl = result.nextUrl ?? '';
    }
  }
}
