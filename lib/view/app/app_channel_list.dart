import 'dart:developer';
import 'dart:math' show min;

import 'package:all/base/base_state.dart';
import 'package:all/model/bean/qingmang_bean.dart';
import 'package:all/model/model/article_list_model.dart';
import 'package:all/model/user_color.dart';
import 'package:all/model/user_theme.dart';
import 'package:all/presenter/article_list_presenter.dart';
import 'package:all/presenter/contract/app_contract.dart';
import 'package:all/utils/function.dart';
import 'package:all/utils/image_util.dart';
import 'package:all/utils/provider_consumer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppChannelListWidget extends StatefulWidget {
  AppChannelListWidget(this.type, this.item,
      {this.onArticleItemTap, this.onAppChannelMoreTap});

  final type;
  final AppItem item;
  final OnArticleItemTap onArticleItemTap;
  final OnAppChannelMoreTap onAppChannelMoreTap;

  @override
  State<StatefulWidget> createState() {
    return _AppChannelListStateCupertino();
  }
}

abstract class _AppChannelListState
    extends BaseState<AppChannelListWidget, IArticleListPresenter>
    implements IArticleListView {
  UserTextTheme _userTextTheme;

  @override
  Widget build(BuildContext context) {
    _userTextTheme = UserTextTheme.auto(context);
    return body(context);
  }
}

class _AppChannelListStateCupertino extends _AppChannelListState {
  @override
  Widget buildBody(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        return _buildChannelItem(widget.item.channel[index]);
      }, childCount: widget.item.channel.length),
    );
  }

  Widget _buildChannelItem(AppChannel channel) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: <Widget>[_buildHeader(channel), _buildContent(channel)],
      ),
    );
  }

  Widget _buildHeader(AppChannel channel) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              channel.title,
              style: _userTextTheme.h3,
            ),
          ),
          CupertinoButton(
            onPressed: () => widget.onAppChannelMoreTap(channel),
            child: Text(
              '查看更多',
              style: TextStyle(fontSize: 15),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildContent(AppChannel channel) {
    IArticleListPresenter presenter = ArticleListPresenter(this, channel);
    presenter.startLoadMore(isRefresh: true);
    return ProviderConsumer<ArticleListModel>(presenter.articleListModel,
        (context, model, _) {
      return AppChannelArticleWidget(
        model.articleList,
        size: Size(MediaQuery.of(context).size.width, 240,),
        onArticleItemTap: widget.onArticleItemTap,
      );
    });
  }
}

class AppChannelArticleWidget extends StatelessWidget {
  AppChannelArticleWidget(this.articleList, {this.line = 3, this.size, this.onArticleItemTap});

  final Size size;
  final int line;
  final List<ArticleListItem> articleList;
  OnArticleItemTap onArticleItemTap;
  UserTextTheme _userTextTheme;

  @override
  Widget build(BuildContext context) {
    _userTextTheme = UserTextTheme.auto(context);
    final pageCount = (articleList.length * 1.0 / line).ceil();
    final pageWidth = size.width * 0.5;
    return SizedBox.fromSize(
      size: size,
      child: PageView.builder(
        itemBuilder: (context, index) {
          return SizedBox(
            width: pageWidth,
            height: size.height,
            child: _buildChannelItem(articleList, index),
          );
        },
        itemCount: pageCount,
      ),
    );
  }

  Widget _buildChannelItem(List<ArticleListItem> list, int pageIndex) {
    final height = size.height / line;
    final itemCount = min(line, list.length - pageIndex * line);
    return ListView.builder(
      padding: EdgeInsets.all(0),
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return SizedBox(
          height: height,
          child: _buildArticleItem(list[pageIndex * line + index]),
        );
      },
      itemCount: itemCount,
    );
  }

  Widget _buildArticleItem(ArticleListItem item) {
    final title = item.subEntry[0]?.title?? '';
    final image = item.subEntry[0]?.cover[0]?.url?? item.subEntry[0]?.image[0]?.url?? '';
    log(item.subEntry[0].cover.length.toString());
    return Material(
      color: UserColor.COLOR_TRANSPARENT,
      child: InkWell(
        onTap: () {
          onArticleItemTap(item);
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text(title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: _userTextTheme.itemTitle,),
              ),
              SizedBox(
                width: 10,
              ),
              CircleAvatar(
                radius: 30,
                backgroundImage: ImageUtil.image(image),
              )
            ],
          ),
        ),
      ),
    );
  }
}
