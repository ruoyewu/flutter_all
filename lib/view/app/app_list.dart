import 'package:all/base/base_state.dart';
import 'package:all/model/bean/qingmang_bean.dart';
import 'package:all/model/model/app_model.dart';
import 'package:all/model/ui_data.dart';
import 'package:all/presenter/article_list_presenter.dart';
import 'package:all/presenter/contract/app_contract.dart';
import 'package:all/utils/date_format.dart';
import 'package:all/utils/provider_consumer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppListWidget extends StatefulWidget {
  AppListWidget({
//    @required this.app,
//    @required this.categoryName,
    @required this.channel
  });

//  final app;
//  final categoryName;
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
  void onItemClick(ArticleListItem item) {
//    Navigator.pushNamed(context, UIData.ROUTE_WEB, arguments: {
//      'title': item.title,
//      'url': item.subEntry[0].action.url
//    });
    Navigator.pushNamed(context, UIData.ROUTE_ARTICLE_DETAIL, arguments: {
      'item': item
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RefreshIndicator(
        onRefresh: () => presenter.startLoadMore(isRefresh: true),
        child: ProviderConsumer<ArticleListModel>(presenter.articleListModel,
            (context, model, _) {
          return ListView.builder(
              itemCount: model.articleList.length + 1,
              itemBuilder: (context, index) {
                if (index < model.articleList.length) {
                  return buildItem(model.articleList[index]);
                } else {
                  return buildLoading();
                }
              });
        }));
  }

  Widget buildItem(ArticleListItem item) {
//    log("title ${item.title}, image: ${item.image}");
//    if (_isOneHeader(item)) {
//      return _buildOneHeader(item);
//    }
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
    List<Widget> children = List();
    if (item.subEntry[0].tag != null && item.subEntry[0].tag.length > 0) {
      children.add(Padding(
        padding: const EdgeInsets.only(bottom: 5),
        child: Align(
          alignment: Alignment.center,
          child: Text(
            "-  " + item.subEntry[0].tag[0].tagName + "  -",
            style: TextStyle(fontSize: 14, color: Colors.blueGrey),
          ),
        ),
      ));
    }
    if (item.subEntry[0].title != null) {
      children.add(Text(
        item.subEntry[0].title,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: 18, color: Colors.black87),
      ));
    }
    if (item.subEntry[0].author != null) {
      children.add(Text(
        "- " + (item.subEntry[0].author == null ? '' : item.subEntry[0].author.name),
        style: TextStyle(fontSize: 14, color: Colors.grey),
      ));
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    );
  }

  Widget itemBody(ArticleListItem item) {
    List<Widget> children = List();
    if (item.subEntry[0].cover != null || item.subEntry[0].image != null) {
      String image = item.subEntry[0].cover == null ? item.subEntry[0].image[0].url : item.subEntry[0].cover[0].url;
      children.add(Container(
        padding: EdgeInsets.symmetric(vertical: 5),
        width: double.infinity,
        height: 250,
        child: Ink.image(
          image: NetworkImage(image),
          fit: BoxFit.cover,
        )));
    }
    if (item.subEntry[0].snippet != null) {
      children.add(Text(
        item.subEntry[0].snippet,
        overflow: TextOverflow.ellipsis,
        maxLines: 3,
        style: TextStyle(fontSize: 15, color: Colors.black54),
      ));
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
//              item.age == "" ? item.date : item.age,
            DateUtil.formatMillis(item.subEntry[0].datePublished, 'YYYY/MM/dd HH:mm:ss'),
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
      child: Text(
        "loading",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 15),
      ),
    );
  }

  bool _isOneHeader(ArticleListItem item) {
//    return widget.app == "one" && item.category == "0";
  return false;
  }

//  Widget _buildOneHeader(ArticleListItem item) {
//    return InkWell(
//      onTap: () {},
//      child: Padding(
//        padding: const EdgeInsets.symmetric(vertical: 10),
//        child: Column(
//          children: <Widget>[
//            Text(
//              item.date.substring(0, 10).replaceAll("-", " / "),
//              style: TextStyle(
//                  fontWeight: FontWeight.bold,
//                  color: Colors.blueGrey,
//                  fontSize: 20),
//            ),
//            Container(
//                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 0),
//                width: double.infinity,
//                height: 250,
//                child: Ink.image(
//                  image: NetworkImage(item.image),
//                  fit: BoxFit.cover,
//                )),
//            Text(
//              item.otherInfo.replaceAll("|", " | "),
//              style: TextStyle(color: Colors.grey, fontSize: 13),
//            ),
//            Container(
//              alignment: Alignment.centerLeft,
//              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 16),
//              child: Text(
//                item.forward,
//                style: TextStyle(color: Colors.black87, fontSize: 16),
//              ),
//            ),
//            Text(
//              item.title,
//              style: TextStyle(color: Colors.black54, fontSize: 12),
//            )
//          ],
//        ),
//      ),
//    );
//  }
}
