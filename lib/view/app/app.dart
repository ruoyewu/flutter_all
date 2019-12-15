import 'package:all/model/bean/qingmang_bean.dart';
import 'package:all/model/model/article_list_item_model.dart';
import 'package:all/model/ui_data.dart';
import 'package:all/utils/provider_consumer.dart';
import 'package:all/view/app/app_list.dart';
import 'package:all/view/detail/article_detail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

typedef OnArticleItemTap = Function(ArticleListItem, {List<ArticleListItem> list});

class AppPage extends StatelessWidget {
  ArticleListItemModel _articleListItemModel = ArticleListItemModel();

  @override
  Widget build(BuildContext context) {
    AppItem item = ModalRoute.of(context).settings.arguments;
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 500) {
          return _buildPage(item, (item, {list}) {
            Navigator.pushNamed(context, UIData.ROUTE_ARTICLE_DETAIL,
                arguments: {'index': list.indexOf(item), 'list': list});
          });
        } else {
          return Stack(
            children: <Widget>[
              SizedBox(
                width: 350,
                child: _buildPage(item, (item, {list}) {
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

  Widget _buildPage(AppItem item, OnArticleItemTap onArticleItemTap) {
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
              children: buildPages(item, onArticleItemTap),
            )
          : AppListWidget(
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

  List<Widget> buildTabs(AppItem item) {
    return item.channel
        .map((channel) => Tab(
              text: channel.title,
            ))
        .toList();
  }

  List<Widget> buildPages(AppItem item, OnArticleItemTap onArticleItemTap) {
    return item.channel
        .map((channel) => AppListWidget(
              key: ValueKey(channel),
              channel: channel,
              onArticleItemTap: onArticleItemTap,
            ))
        .toList();
  }
}
