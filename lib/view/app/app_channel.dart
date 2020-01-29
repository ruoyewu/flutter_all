import 'package:all/base/base_state.dart';
import 'package:all/model/bean/qingmang_bean.dart';
import 'package:all/model/model/article_list_model.dart';
import 'package:all/model/ui_data.dart';
import 'package:all/presenter/article_list_presenter.dart';
import 'package:all/presenter/contract/app_contract.dart';
import 'package:all/utils/provider_consumer.dart';
import 'package:all/view/app.dart';
import 'package:all/view/widget/article_list.dart';
import 'package:flutter/cupertino.dart';

class AppChannelPage extends StatefulWidget {
  AppChannelPage(this.type);

  final type;

  @override
  State<StatefulWidget> createState() {
    return _AppChannelState();
  }
}

class _AppChannelState extends BaseState<AppChannelPage, IArticleListPresenter>
    implements IArticleListView {
  @override
  Widget buildBody(BuildContext context) {
    Map arguments = ModalRoute.of(context).settings.arguments;
    final lastTitle = arguments['title'];
    final heroTag = arguments['hero'];
    AppChannel channel = arguments['channel'];

    presenter = ArticleListPresenter(this, channel);

    return CupertinoPageScaffold(
      child: CustomScrollView(
        slivers: [
          CupertinoSliverRefreshControl(
            refreshTriggerPullDistance: 120,
            refreshIndicatorExtent: 100,
            onRefresh: () => presenter.startLoadMore(isRefresh: true),
          ),
          CupertinoSliverNavigationBar(
            heroTag: heroTag,
            previousPageTitle: lastTitle,
            largeTitle: Text(channel.title),
          ),
          ProviderConsumer<ArticleListModel>(presenter.articleListModel,
              (context, model, _) {
            return ArticleListWidget.type(
              Type.CUPRETINO,
              model,
              onArticleItemTap: (item) {
                Navigator.pushNamed(context, UIData.ROUTE_ARTICLE_DETAIL,
                    arguments: {
                      'item': item,
                      'hero': heroTag,
                      'title': item.title
                    });
              },
              onLoadingMore: presenter.startLoadMore,
              itemType: model.type,
            );
          })
        ],
      ),
    );
  }
}
