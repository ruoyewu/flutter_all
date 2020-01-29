import 'package:all/model/bean/qingmang_bean.dart';
import 'package:all/model/model/article_list_item_model.dart';
import 'package:all/model/ui_data.dart';
import 'package:all/model/user_color.dart';
import 'package:all/utils/function.dart';
import 'package:all/utils/provider_consumer.dart';
import 'package:all/view/app.dart';
import 'package:all/view/app/app_channel_list.dart';
import 'package:all/view/app/app_list.dart';
import 'package:all/view/detail/article_detail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

abstract class AppPage extends StatelessWidget {
  static type(Type type) {
    switch (type) {
      case Type.MATERIAL:
        return _AppPageMaterial();
      case Type.CUPRETINO:
        return _AppPageCupertino();
    }
  }

  ArticleListItemModel _articleListItemModel = ArticleListItemModel();
  var heroTag;
  var lastTitle;

  @override
  Widget build(BuildContext context) {
    Map arguments = ModalRoute.of(context).settings.arguments;
    AppItem item = arguments['item'];
    heroTag = arguments['hero'];
    lastTitle = arguments['title'];
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 500) {
          return _buildPage(item, (item) {
            Navigator.pushNamed(context, UIData.ROUTE_ARTICLE_DETAIL,
                arguments: {
                  'item': item,
                  'hero': heroTag,
                  'title': item.title
                });
          }, onAppChannelMoreTap: (channel) {
            Navigator.pushNamed(context, UIData.ROUTE_APP_CHANNEL, arguments: {
              'title': item.title,
              'hero': heroTag,
              'channel': channel
            });
          });
        } else {
          return Stack(
            children: <Widget>[
              SizedBox(
                width: 350,
                child: _buildPage(item, (item) {
                  _articleListItemModel.articleListItem = item;
                }),
              ),
              Transform.translate(
                offset: Offset(350, 0),
                child: SizedBox(
                  width: constraints.maxWidth - 350,
                  child: ProviderConsumer<ArticleListItemModel>(
                      _articleListItemModel, (cotext, model, _) {
                    return ArticleDetailPage(
                      Type.MATERIAL,
                      item: _articleListItemModel.articleListItem,
                      showTitle: false,
                    );
                  }),
                ),
              )
            ],
          );
        }
      },
    );
  }

  Widget _buildPage(AppItem item, OnArticleItemTap onArticleItemTap,
      {OnAppChannelMoreTap onAppChannelMoreTap});

  List<Widget> buildTabs(AppItem item) {
    return item.channel
        .map((channel) => Tab(
              text: channel.title,
            ))
        .toList();
  }

  List<Widget> buildPages(
      Type type, AppItem item, OnArticleItemTap onArticleItemTap) {
    return item.channel
        .map((channel) => AppListWidget(
              type,
              key: ValueKey(channel),
              channel: channel,
              onArticleItemTap: onArticleItemTap,
            ))
        .toList();
  }
}

class _AppPageCupertino extends AppPage {
  @override
  Widget _buildPage(AppItem item, onArticleItemTap,
      {OnAppChannelMoreTap onAppChannelMoreTap}) {
    return CupertinoPageScaffold(
      child: CustomScrollView(
        slivers: <Widget>[
          CupertinoSliverRefreshControl(
            refreshTriggerPullDistance: 120,
            refreshIndicatorExtent: 100,
            onRefresh: () => Future.delayed(Duration(seconds: 2)),
          ),
          CupertinoSliverNavigationBar(
            heroTag: heroTag,
            previousPageTitle: lastTitle,
            largeTitle: Text(item.title),
            backgroundColor: UserColor.COLOR_TRANSPARENT_ALABASTER,
          ),
          item.channel.length == 1
              ? AppListWidget(
                  Type.CUPRETINO,
                  channel: item.channel[0],
                  onArticleItemTap: onArticleItemTap,
                )
              : AppChannelListWidget(
                  Type.CUPRETINO,
                  item,
                  onArticleItemTap: onArticleItemTap,
                  onAppChannelMoreTap: onAppChannelMoreTap,
                ),
        ],
      ),
    );
  }
}

class _AppPageMaterial extends AppPage {
  @override
  Widget _buildPage(AppItem item, onArticleItemTap,
      {OnAppChannelMoreTap onAppChannelMoreTap}) {
    int channelCount = item.channel.length;
    Widget widget = Scaffold(
      appBar: AppBar(
        title: Text(item.title),
        bottom: channelCount > 1
            ? TabBar(
                indicatorSize: TabBarIndicatorSize.label,
                isScrollable: true,
                tabs: buildTabs(item),
              )
            : null,
      ),
      body: channelCount > 1
          ? TabBarView(
              children: buildPages(Type.MATERIAL, item, onArticleItemTap),
            )
          : AppListWidget(
              Type.MATERIAL,
              channel: item.channel[0],
              onArticleItemTap: onArticleItemTap,
            ),
    );
    if (channelCount > 1) {
      widget = DefaultTabController(
        length: channelCount,
        child: widget,
      );
    }
    return widget;
  }
}
