import 'package:all/base/base_state.dart';
import 'package:all/model/model/article_list_model.dart';
import 'package:all/presenter/article_list_presenter.dart';
import 'package:all/presenter/contract/app_contract.dart';
import 'package:all/utils/function.dart';
import 'package:all/utils/provider_consumer.dart';
import 'package:all/view/app.dart';
import 'package:all/view/widget/article_list.dart';
import 'package:flutter/material.dart';

class AppListWidget extends StatefulWidget {
  AppListWidget(this.type,
      {@required this.channel, @required this.onArticleItemTap, Key key})
      : super(key: key);

  OnArticleItemTap onArticleItemTap;
  final channel;
  final type;

  @override
  State<StatefulWidget> createState() {
    return _AppListWidgetState.type(type);
  }
}

abstract class _AppListWidgetState
    extends BaseState<AppListWidget, IArticleListPresenter>
    with AutomaticKeepAliveClientMixin
    implements IArticleListView {

  static type(Type type) {
    switch(type) {
      case Type.MATERIAL:
        return _AppListWidgetStateMaterial();
      case Type.CUPRETINO:
        return _AppListWidgetStateCupertino();
    }
  }

  @override
  void initState() {
    super.initState();
    presenter = ArticleListPresenter(this, widget.channel);
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return body(context);
  }
}

class _AppListWidgetStateCupertino extends _AppListWidgetState {
  @override
  Widget buildBody(BuildContext context) {
    return ProviderConsumer<ArticleListModel>(
      presenter.articleListModel,
        (context, model, _) {
        return ArticleListWidget.type(
          widget.type,
          model,
          onArticleItemTap: (item) =>
            widget.onArticleItemTap(item),
          onLoadingMore: presenter.startLoadMore,
          itemType: model.type,
        );
      },
    );
  }
}

class _AppListWidgetStateMaterial extends _AppListWidgetState {
  @override
  Widget buildBody(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => presenter.startLoadMore(isRefresh: true),
      child: ProviderConsumer<ArticleListModel>(presenter.articleListModel,
          (context, model, _) {
          return ArticleListWidget.type(
            widget.type,
            model,
            onArticleItemTap: (item) =>
              widget.onArticleItemTap(item),
            onLoadingMore: presenter.startLoadMore,
            itemType: model.type,
          );
        }));
  }
}