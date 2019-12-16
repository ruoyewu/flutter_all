import 'package:all/model/bean/qingmang_bean.dart';
import 'package:all/model/model/article_list.dart';
import 'package:all/model/user_theme.dart';
import 'package:all/utils/date_format.dart';
import 'package:flutter/material.dart';

import 'heart_loading.dart';

typedef OnArticleItemTap = Function(
    ArticleListItem item, List<ArticleListItem> list);
typedef OnLoadingMore = Function();

class ArticleListWidget extends StatelessWidget {
  ArticleListWidget(this.model, {@required this.onArticleItemTap, @required this.onLoadingMore});

  final ArticleListModel model;
  OnArticleItemTap onArticleItemTap;
  OnLoadingMore onLoadingMore;

  UserTextTheme _userTextTheme;

  @override
  Widget build(BuildContext context) {
    _userTextTheme = UserTextTheme.auto(context);
    return ListView.builder(
        itemCount: model.articleList.length + 1,
        itemBuilder: (context, index) {
          if (index < model.articleList.length) {
            return buildItem(model.articleList[index]);
          } else {
            return buildLoading(model.hasMore);
          }
        });
  }

  Widget buildItem(ArticleListItem item) {
    return InkWell(
      onTap: () => onArticleItemTap(item, model.articleList),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            itemHeader(item),
            itemBody(item),
            itemFooter(item),
          ],
        ),
      ),
    );
  }

  Widget itemHeader(ArticleListItem item) {
    List<Widget> children = List();
    if (item.subEntry[0].tag != null && item.subEntry[0].tag.length > 0) {
      children.add(Padding(
        padding: const EdgeInsets.only(bottom: 5),
        child: Align(
          alignment: Alignment.center,
          child: Text("-  " + item.subEntry[0].tag[0].tagName + "  -",
              style: _userTextTheme.itemTag),
        ),
      ));
    }
    if (item.subEntry[0].title != null) {
      children.add(Text(item.subEntry[0].title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: _userTextTheme.itemTitle));
    }
    if (item.subEntry[0].author != null) {
      children.add(Text(
          "- " +
              (item.subEntry[0].author == null
                  ? ''
                  : item.subEntry[0].author.name),
          style: _userTextTheme.itemAuthor));
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    );
  }

  Widget itemBody(ArticleListItem item) {
    List<Widget> children = List();
    if (item.subEntry[0].cover != null || item.subEntry[0].image != null) {
      String image = item.subEntry[0].cover == null
          ? item.subEntry[0].image[0].url
          : item.subEntry[0].cover[0].url;
      children.add(AspectRatio(
        aspectRatio: 16 / 9,
        child: Container(
            padding: EdgeInsets.symmetric(vertical: 5),
            width: double.infinity,
            child: Ink.image(
              image: NetworkImage(image),
              fit: BoxFit.cover,
            )),
      ));
    }
    if (item.subEntry[0].snippet != null) {
      children.add(Text(item.subEntry[0].snippet,
          overflow: TextOverflow.ellipsis,
          maxLines: 3,
          style: _userTextTheme.itemForward));
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    );
  }

  Widget itemFooter(ArticleListItem item) {
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

  Widget buildLoading(bool hasMore) {
    if (hasMore) {
      onLoadingMore();
    }
    return HeartLoadingBar(
      isLoading: hasMore,
    );
  }
}
