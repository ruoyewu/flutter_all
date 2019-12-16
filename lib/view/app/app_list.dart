import 'package:all/base/base_state.dart';
import 'package:all/model/bean/qingmang_bean.dart';
import 'package:all/model/model/article_list.dart';
import 'package:all/presenter/article_list_presenter.dart';
import 'package:all/presenter/contract/app_contract.dart';
import 'package:all/utils/provider_consumer.dart';
import 'package:all/view/widget/article_list.dart';
import 'package:flutter/material.dart';

typedef OnArticleItemTap = Function(
    ArticleListItem item, List<ArticleListItem> list);

class AppListWidget extends StatefulWidget {
  AppListWidget(
      {@required this.channel, @required this.onArticleItemTap, Key key})
      : super(key: key);

  OnArticleItemTap onArticleItemTap;
  final channel;

  @override
  State<StatefulWidget> createState() {
    return _AppListWidgetState();
  }
}

class _AppListWidgetState
    extends BaseState<AppListWidget, IArticleListPresenter>
    with AutomaticKeepAliveClientMixin
    implements IArticleListView {
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
    return RefreshIndicator(
        onRefresh: () => presenter.startLoadMore(isRefresh: true),
        child: ProviderConsumer<ArticleListModel>(presenter.articleListModel,
            (context, model, _) {
          return ArticleListWidget(
            model,
            onArticleItemTap: (item, list) =>
                widget.onArticleItemTap(item, list),
            onLoadingMore: presenter.startLoadMore,
          );
        }));
  }
}
