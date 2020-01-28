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
  RecommendListPage(this.type);

  final type;

  @override
  State<StatefulWidget> createState() {
    return _RecommendListState();
  }
}

class _RecommendListState
    extends BaseState<RecommendListPage, IRecommendPresenter>
    implements IRecommendView {
  ResultRecommend _recommend;

  @override
  Widget build(BuildContext context) {
    return body(context);
  }

  Widget _buildBody() {
    return RefreshIndicator(
      onRefresh: () => presenter.startLoadMore(isRefresh: true),
      child: ProviderConsumer<ArticleListModel>(presenter.articleListModel,
          (context, model, _) {
        return ArticleListWidget.type(
          widget.type,
          model,
          onArticleItemTap: (item) {
            Navigator.pushNamed(context, UIData.ROUTE_ARTICLE_DETAIL,
                arguments: {'item': item});
          },
          onLoadingMore: presenter.startLoadMore,
          itemType: model.type,
        );
      }),
    );
  }

  @override
  Widget buildBody(BuildContext context) {
    Map arguments = ModalRoute.of(context).settings.arguments;
    _recommend = arguments['recommend'];
    presenter = RecomendPresenter(this, _recommend);

    return Scaffold(
      appBar: AppBar(
        title: Text(_recommend.title),
      ),
      body: _buildBody(),
    );
  }
}
