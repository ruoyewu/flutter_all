import 'package:all/base/base_state.dart';
import 'package:all/model/bean/article_list_item.dart';
import 'package:all/model/model/app_model.dart';
import 'package:all/model/ui_data.dart';
import 'package:all/presenter/article_list_presenter.dart';
import 'package:all/presenter/contract/app_contract.dart';
import 'package:all/utils/provider_consumer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppListWidget extends StatefulWidget {
  AppListWidget({
    @required this.app,
    @required this.categoryName,
  });

  final app;
  final categoryName;

  @override
  State<StatefulWidget> createState() {
    return _AppListWidgetState();
  }
}

class _AppListWidgetState extends BaseState<AppListWidget, IArticleListPresenter>
  with AutomaticKeepAliveClientMixin
  implements IArticleListView {

  @override
  void initState() {
    super.initState();
    presenter = ArticleListPresenter(this, widget.app, widget.categoryName);
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void onItemClick(ArticleListItem item) {
//    item.openType = "2";
    final openType = ArticleOpenType.values[int.parse(item.openType)];
    switch (openType) {
      case ArticleOpenType.NONE:
        break;
      case ArticleOpenType.ARTICLE:
        Navigator.pushNamed(context, UIData.ROUTE_ARTICLE_DETAIL, arguments: {
          "app": widget.app,
          "item": item
        });
        break;
      case ArticleOpenType.ORIGINAL_URL:
        Navigator.pushNamed(context, UIData.ROUTE_WEB, arguments: {
          "title": item.title,
          "url": item.originalUrl
        });
        break;
      case ArticleOpenType.IMAGE:

        break;
      case ArticleOpenType.VIDEO:

        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RefreshIndicator(
      onRefresh: presenter.startRefresh,
      child: ProviderConsumer<ArticleListModel>(
        presenter.articleListModel,
        (context, model, _) {
          return ListView.builder(
            itemCount: model.articleList.list.length + 1,
            itemBuilder: (context, index) {
              if (index < model.articleList.list.length) {
                return buildItem(model.articleList.list[index]);
              } else {
                return buildLoading();
              }
            }
          );
        }
      )
    );
  }

  Widget buildItem(ArticleListItem item) {
//    log("title ${item.title}, image: ${item.image}");
    if (_isOneHeader(item)) {
      return _buildOneHeader(item);
    }
    return InkWell(
      onTap: () => onItemClick(item),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: Align(
            alignment: Alignment.center,
            child: Text(
              "-  " + item.type + "  -",
              style: TextStyle(fontSize: 14, color: Colors.blueGrey),
            ),
          ),
        ),
        Text(
          item.title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontSize: 18, color: Colors.black87),
        ),
        Text(
          "- " + item.author,
          style: TextStyle(fontSize: 14, color: Colors.grey),
        ),
      ],
    );
  }

  Widget itemBody(ArticleListItem item) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(vertical: 5),
          width: double.infinity,
          height: 250,
          child: Ink.image(image: NetworkImage(item.image), fit: BoxFit.cover,)
        ),
        Text(
          item.forward,
          overflow: TextOverflow.ellipsis,
          maxLines: 3,
          style: TextStyle(fontSize: 15, color: Colors.black54),
        ),

      ],
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
              item.age == "" ? item.date : item.age,
              textAlign: TextAlign.end,
              style: TextStyle(fontSize: 13, color: Colors.grey),
            ),
          )
        ],
      ),
    );
  }

  Widget buildLoading() {
    presenter.startLoadMore();
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: Text("loading", textAlign: TextAlign.center, style: TextStyle(fontSize: 15),),
    );
  }

  bool _isOneHeader(ArticleListItem item) {
    return widget.app == "one" && item.category == "0";
  }

  Widget _buildOneHeader(ArticleListItem item) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          children: <Widget>[
            Text(
              item.date.substring(0, 10).replaceAll("-", " / "),
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blueGrey, fontSize: 20),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 0),
              width: double.infinity,
              height: 250,
              child: Ink.image(image: NetworkImage(item.image), fit: BoxFit.cover,)
            ),
            Text(
              item.otherInfo.replaceAll("|", " | "),
              style: TextStyle(color: Colors.grey, fontSize: 13),
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 16),
              child: Text(
                item.forward,
                style: TextStyle(color: Colors.black87, fontSize: 16),
              ),
            ),
            Text(
              item.title,
              style: TextStyle(color: Colors.black54, fontSize: 12),
            )
          ],
        ),
      ),
    );
  }
}