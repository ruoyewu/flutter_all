
import 'package:all/model/bean/article_collection_list_item.dart';
import 'package:all/model/model/article_collection_model.dart';
import 'package:all/model/ui_data.dart';
import 'package:all/presenter/contract/user_contract.dart';
import 'package:all/utils/provider_consumer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserCollectionWidget extends StatelessWidget {
  UserCollectionWidget(this.presenter, this.user);

  IUserPresenter presenter;
  String user;

  onCollectionItemTap(BuildContext context, ArticleCollectionListItem item) {
    Navigator.pushNamed(context, UIData.ROUTE_ARTICLE_DETAIL, arguments: {
      'app': item.article.split('_')[0],
      'item': item.content
    }).then((result) {
      presenter.onDetailResult(result, item);
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => presenter.startLoadCollection(user, isRefresh: true),
      child: ProviderConsumer<ArticleCollectionModel>(
        presenter.articleCollectionModel,
        (context, model, _) {
          final hasMore = model.hasMore;
          final list = model.articleCollectionList.list;
          final count = hasMore ? list.length + 1 : list.length;
          return ListView.builder(
            itemCount: count,
            itemBuilder: (context, index) {
              if (index < list.length) {
                return _buildCollectionItem(context, list[index]);
              } else {
                return _buildLoading();
              }
            },
          );
        }
      )
    );
  }

  Widget _buildCollectionItem(BuildContext context, ArticleCollectionListItem item) {
    List<Widget> children = List();
    children.add(SizedBox(
      width: 45,
      height: 45,
      child: ClipOval(
        child: Image.network(presenter.appIcon(item.article),),
      ),
    ));
    children.add(Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Text(
          item.content.title,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 16,
            color: UIData.COLOR_MONSOON
          ),
        ),
      ),
    ));
    if (item.content.image != '') {
      children.add(SizedBox(
        width: 80,
        height: 80,
        child: Image.network(item.content.image, fit: BoxFit.cover,),
      ));
    }
    return InkWell(
      onTap: () => onCollectionItemTap(context, item),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        child: Row(
          children: children,
        ),
      ),
    );
  }

  Widget _buildLoading() {
    presenter.startLoadCollection(user);
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
}
