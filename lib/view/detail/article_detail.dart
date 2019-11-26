import 'dart:developer';

import 'package:all/base/base_state.dart';
import 'package:all/model/bean/article_detail.dart';
import 'package:all/model/bean/article_list_item.dart';
import 'package:all/model/model/article_detail_model.dart';
import 'package:all/presenter/article_detail_presenter.dart';
import 'package:all/presenter/contract/article_detail_contract.dart';
import 'package:all/utils/provider_consumer.dart';
import 'package:all/view/detail/article_detail_content.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ArticleDetailTestPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageView(
      children: <Widget>[
        ArticleDetailPage()
      ],
    );
  }
}

class ArticleDetailPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ArticleDetailState();
  }
}

class _ArticleDetailState extends BaseState<ArticleDetailPage, IArticleDetailPresenter>
  with AutomaticKeepAliveClientMixin
  implements IArticleDetailView {

  bool _firstLoad = true;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    log("build article detail page");
    super.build(context);
    Map arguments = ModalRoute.of(context).settings.arguments;
    final app = arguments["app"];
    ArticleListItem item = arguments["item"];
    if (_firstLoad) {
      presenter = ArticleDetailPresenter(this, app: app, category: item.category, id: item.id);
      _firstLoad = false;
      Future.delayed(Duration(milliseconds: 500), () {
        presenter.startLoadArticle();
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(item.title),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Stack(
          children: <Widget>[
            SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  ProviderConsumer<ArticleDetailModel>(
                    presenter.articleDetailModel,
                      (context, model, _) {
                      if (model == null || model.articleDetail == null) {
                        return Column();
                      }
                      return Column(
                        children: <Widget>[
                          _buildHeader(model.articleDetail),
                          _buildContent(model.articleDetail),
                        ],
                      );
                    }
                  ),
                  _buildComment()
                ],
              ),
            ),
            _buildInfo(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(ArticleDetail detail) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              detail.content.title,
              style: TextStyle(fontSize: 20, color: Colors.black87),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: detail.content.subtitle != "" ?
              Text(
                "—— " + detail.content.subtitle,
                style: TextStyle(fontSize: 18, color: Colors.black54),
              ) : null,
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              detail.content.author,
              style: TextStyle(fontSize: 14, color: Colors.black45),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildContent(ArticleDetail detail) {
    return ArticleDetailContentWidget(detail.content.itemList);
  }

  Widget _buildInfo() {
    return SizedBox.expand();
  }

  Widget _buildComment() {
    return Column();
  }

}