import 'package:all/model/bean/qingmang_bean.dart';
import 'package:all/model/model/article_list_model.dart';
import 'package:all/model/user_theme.dart';
import 'package:all/utils/date_format.dart';
import 'package:all/utils/function.dart';
import 'package:all/view/app.dart';
import 'package:flutter/material.dart';

import 'heart_loading.dart';

abstract class ArticleListWidget extends StatelessWidget {
  ArticleListWidget._(this.model,
      {@required this.onArticleItemTap,
      @required this.onLoadingMore,
      this.type = 1});

  // ignore: missing_return
  factory ArticleListWidget.type(Type type, ArticleListModel model,
    {OnArticleItemTap onArticleItemTap,
      OnLoadingMore onLoadingMore,
      int itemType = 1}) {
    switch (type) {
      case Type.MATERIAL:
        return _ArticleListWidgetMaterial(model, onArticleItemTap: onArticleItemTap, onLoadingMore: onLoadingMore, type: itemType,);
      case Type.CUPRETINO:
        return _ArticleListWidgetCupertino(model, onArticleItemTap: onArticleItemTap, onLoadingMore: onLoadingMore, type: itemType,);
    }
  }

  final ArticleListModel model;
  OnArticleItemTap onArticleItemTap;
  OnLoadingMore onLoadingMore;
  int type;

  Widget buildLoading(bool hasMore) {
    if (hasMore) {
      onLoadingMore();
    }
    return HeartLoadingBar(
      isLoading: hasMore,
    );
  }
}

class _ArticleListWidgetCupertino extends ArticleListWidget {
  _ArticleListWidgetCupertino(ArticleListModel model,
      {OnArticleItemTap onArticleItemTap,
      OnLoadingMore onLoadingMore,
      int type = 1})
      : super._(model,
            onArticleItemTap: onArticleItemTap,
            onLoadingMore: onLoadingMore,
            type: type);

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        if (index < model.articleList.length) {
          return Material(
            child: ArticleListItemWidget(
              model.articleList[index],
              type: type,
              onArticleItemTap: () {
                this.onArticleItemTap(
                    model.articleList[index]);
              },
            ),
          );
        } else {
          return buildLoading(model.hasMore);
        }
      }, childCount: model.articleList.length + 1),
    );
  }
}

class _ArticleListWidgetMaterial extends ArticleListWidget {
  _ArticleListWidgetMaterial(ArticleListModel model,
      {OnArticleItemTap onArticleItemTap,
      OnLoadingMore onLoadingMore,
      int type = 1})
      : super._(model,
            onArticleItemTap: onArticleItemTap,
            onLoadingMore: onLoadingMore,
            type: type);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: model.articleList.length + 1,
        itemBuilder: (context, index) {
          if (index < model.articleList.length) {
            return ArticleListItemWidget(
              model.articleList[index],
              type: type,
              onArticleItemTap: () {
                this.onArticleItemTap(
                    model.articleList[index]);
              },
            );
          } else {
            return buildLoading(model.hasMore);
          }
        });
  }
}

class ArticleListItemWidget extends StatelessWidget {
  ArticleListItemWidget(this.item, {this.onArticleItemTap, this.type = 1});

  ArticleListItem item;
  int type;
  GestureTapCallback onArticleItemTap;
  UserTextTheme _userTextTheme;

  @override
  Widget build(BuildContext context) {
    _userTextTheme = UserTextTheme.auto(context);
    return buildItem(item, context);
  }

  Widget buildItem(ArticleListItem item, BuildContext context) {
    switch (type) {
      case 0:
        return _buildType1(item, context);
      case 1:
        return _buildType2(item, context);
    }
  }

  Widget _buildType1(ArticleListItem item, BuildContext context) {
    return InkWell(
      onTap: onArticleItemTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildHeader(item),
            ..._buildTitle(item),
            _buildBody(item, 16 / 9),
            _buildForward(item),
            _buildFooter(item),
          ],
        ),
      ),
    );
  }

  Widget _buildType2(ArticleListItem item, BuildContext context) {
    return InkWell(
      onTap: onArticleItemTap,
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          children: <Widget>[
            _buildHeader(item),
            Row(
//              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      ..._buildTitle(item, showAuthor: false),
                      _buildForward(item),
                    ],
                  ),
                ),
                if (item.hasCover)
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: _buildBody(item, 1),
                    ),
                  ),
              ],
            ),
            _buildFooter(item)
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(ArticleListItem item) {
    if (item.subEntry[0].tag != null) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 5),
        child: Align(
          alignment: Alignment.center,
          child: Text("-  " + item.subEntry[0].tag[0].tagName + "  -",
              style: _userTextTheme.itemTag),
        ),
      );
    } else {
      return SizedBox();
    }
  }

  List<Widget> _buildTitle(ArticleListItem item, {bool showAuthor = true}) {
    List<Widget> children = List();
    if (item.hasTitle) {
      children.add(Text(item.subEntry[0].title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: _userTextTheme.itemTitle));
    }
    if (showAuthor && item.hasAuthor) {
      children.add(Text(
          "- " +
              (item.subEntry[0].author == null
                  ? ''
                  : item.subEntry[0].author.name),
          style: _userTextTheme.itemAuthor));
    }
    return children;
  }

  Widget _buildBody(ArticleListItem item, double ratio) {
    if (item.hasCover) {
      String image = item.coverImg;
      return AspectRatio(
        aspectRatio: ratio,
        child: Container(
            padding: EdgeInsets.symmetric(vertical: 5),
            width: double.infinity,
            child: Ink.image(
              image: NetworkImage(image),
              fit: BoxFit.cover,
            )),
      );
    } else {
      return SizedBox();
    }
  }

  Widget _buildForward(ArticleListItem item) {
    if (item.subEntry[0].snippet != null) {
      return Text(item.subEntry[0].snippet,
          overflow: TextOverflow.ellipsis,
          maxLines: 3,
          style: _userTextTheme.itemForward);
    } else {
      return SizedBox();
    }
  }

  Widget _buildFooter(ArticleListItem item) {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Column(
        children: <Widget>[
          Align(
            alignment: Alignment.centerRight,
            child: Text(
                DateUtil.formatMillis(
                    item.subEntry[0].datePublished, 'YYYY/MM/dd HH:mm:ss'),
                textAlign: TextAlign.end,
                style: _userTextTheme.itemTime),
          )
        ],
      ),
    );
  }
}
