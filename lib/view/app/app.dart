import 'package:all/model/bean/qingmang_bean.dart';
import 'package:all/model/model/article_list_item_model.dart';
import 'package:all/model/ui_data.dart';
import 'package:all/utils/provider_consumer.dart';
import 'package:all/view/app/app_list.dart';
import 'package:all/view/detail/article_detail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef OnArticleItemTap = Function(ArticleListItem);

class AppPage extends StatelessWidget {
  ArticleListItemModel _articleListItemModel = ArticleListItemModel();

  @override
  Widget build(BuildContext context) {
    AppItem item = ModalRoute.of(context).settings.arguments;
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 500) {
          return _buildPage(item, (item) {
            Navigator.pushNamed(context, UIData.ROUTE_ARTICLE_DETAIL, arguments: {
              'item': item
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
                    _articleListItemModel,
                      (cotext, model, _) {
                      return ArticleDetailPage(item: _articleListItemModel.articleListItem,);
                    }
                  ),
                ),
              )
            ],
          );
        }
      },
    );
  }

  Widget _buildPage(AppItem item, OnArticleItemTap onArticleItemTap) {
    return DefaultTabController(
      key: ValueKey(item),
      length: item.channel.length,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                pinned: true,
                floating: false,
                title: Text(item.title),
                bottom: TabBar(
                  indicatorSize: TabBarIndicatorSize.label,
                  isScrollable: true,
                  tabs: buildTabs(item),
                ),
              ),
            ];
          },
          body: TabBarView(
            children: buildPages(item, onArticleItemTap),
          ),
        ),
      ),
    );
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
              channel: channel,
            onArticleItemTap: onArticleItemTap,
            ))
        .toList();
  }
}
