import 'package:all/base/base_state.dart';
import 'package:all/model/bean/qingmang_bean.dart';
import 'package:all/model/model/article_list_model.dart';
import 'package:all/model/ui_data.dart';
import 'package:all/presenter/contract/recommend_contract.dart';
import 'package:all/presenter/recommend_presenter.dart';
import 'package:all/utils/provider_consumer.dart';
import 'package:all/view/widget/article_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RecommendListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RecommendListState();
  }
}

class _RecommendListState
    extends BaseState<RecommendListPage, IRecommendPresenter>
    implements IRecommendView {
  ResultRecommend _recommend;
  bool _firstLoad = true;

  @override
  Widget build(BuildContext context) {
    if (_firstLoad) {
      _firstLoad = false;
      Map arguments = ModalRoute.of(context).settings.arguments;
      _recommend = arguments['recommend'];
      presenter = RecomendPresenter(this, _recommend);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(_recommend.title),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return RefreshIndicator(
      onRefresh: () => presenter.startLoadMore(isRefresh: true),
      child: ProviderConsumer<ArticleListModel>(presenter.articleListModel,
          (context, model, _) {
        return ArticleListWidget(
          model,
          onArticleItemTap: (item, list) {
            Navigator.pushNamed(context, UIData.ROUTE_ARTICLE_DETAIL,
                arguments: {'index': list.indexOf(item), 'list': list});
          },
          onLoadingMore: presenter.startLoadMore,
          type: model.type,
        );
      }),
    );
  }
}
