import 'dart:developer';

import 'package:all/base/base_state.dart';
import 'package:all/model/bean/article_comment_list_item.dart';
import 'package:all/model/bean/article_detail.dart';
import 'package:all/model/bean/article_detail_content.dart';
import 'package:all/model/bean/article_list_item.dart';
import 'package:all/model/model/article_comment_model.dart';
import 'package:all/model/model/article_detail_info_model.dart';
import 'package:all/model/model/article_detail_model.dart';
import 'package:all/model/ui_data.dart';
import 'package:all/presenter/article_detail_presenter.dart';
import 'package:all/presenter/contract/article_detail_contract.dart';
import 'package:all/utils/date_format.dart';
import 'package:all/utils/provider_consumer.dart';
import 'package:all/view/detail/article_detail_content.dart';
import 'package:all/view/widget/widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ArticleDetailPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ArticleDetailState();
  }
}

class _ArticleDetailState
    extends BaseState<ArticleDetailPage, IArticleDetailPresenter>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin
    implements IArticleDetailView {
  static const ANIMATION_DURATION = 300;

  ScrollController _scrollController;
  GlobalKey _articleKey;
  BuildContext _snackBarContext;
  bool _firstLoad = true;

  @override
  bool get wantKeepAlive => true;

  @override
  TickerProvider get tickerProvider => this;

  @override
  onResultInfo(String info) {
    Widgets.showSnackBar(_snackBarContext, info);
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _articleKey = GlobalKey(debugLabel: 'article_key');
  }

  @override
  Widget build(BuildContext context) {
    log("build article detail page");
    super.build(context);

    Map arguments = ModalRoute.of(context).settings.arguments;
    ArticleListItem item = arguments["item"];
    final app = arguments["app"];
    if (_firstLoad) {
      presenter = ArticleDetailPresenter(this, app: app, item: item);
      _firstLoad = false;
      if (app == 'ifanr') {
        Future.delayed(Duration(milliseconds: 500), () {
          presenter.articleDetailModel.update(ArticleDetail(
              app: app,
              category: item.category,
              id: item.id,
              content: ArticleDetailContent(
                  author: item.author,
                  date: item.date,
                  title: item.title,
                  subtitle: "",
                  itemList: item.content)));
        });
      } else {
        presenter.startLoadArticle();
      }
      presenter.startLoadArticleInfo();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(item.title),
      ),
      body: Builder(
        builder: (context) {
          _snackBarContext = context;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Stack(
              children: <Widget>[
                Scrollbar(
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    child: Column(
                      children: <Widget>[
                        ProviderConsumer<ArticleDetailModel>(
                            presenter.articleDetailModel, (context, model, _) {
                          if (model == null || model.articleDetail == null) {
                            return Column();
                          }
                          return Column(
                            key: _articleKey,
                            children: <Widget>[
                              _buildHeader(model.articleDetail),
                              _buildContent(model.articleDetail),
                              ProviderConsumer<ArticleCommentModel>(
                                  presenter.articleCommentModel,
                                  (context, model, _) {
                                return _buildComment(model);
                              }),
                            ],
                          );
                        })
                      ],
                    ),
                  ),
                ),
                _buildInfo(),
              ],
            ),
          );
        },
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
            child: detail.content.subtitle != ""
                ? Text(
                    "—— " + detail.content.subtitle,
                    style: TextStyle(fontSize: 18, color: Colors.black54),
                  )
                : null,
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
    return SizedBox.expand(
      child: ProviderConsumer<ArticleDetailInfoModel>(
          presenter.articleDetailInfoModel, (context, model, _) {
        return Stack(
          alignment: Alignment.bottomRight,
          children: <Widget>[
            Padding(
                padding:
                    EdgeInsets.only(right: 16, bottom: model.offsetCommentNum),
                child: Card(
                  elevation: model.elevation,
                  color: Colors.blueGrey,
                  child: InkWell(
                    onTap: () {
                      _scrollController.animateTo(
                          _articleKey.currentContext.size.height,
                          duration: Duration(milliseconds: ANIMATION_DURATION),
                          curve: Curves.easeInToLinear);
                    },
                    child: SizedBox(
                      width: 50,
                      height: 25,
                      child: Center(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            SizedBox(
                              width: 15,
                              height: 15,
                              child: FittedBox(
                                child: Icon(
                                  Icons.edit,
                                  color: Colors.white70,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Text(
                                model.articleInfo.commentNum.toString(),
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white70),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )),
            Padding(
                padding:
                    EdgeInsets.only(right: 16, bottom: model.offsetFavoriteNum),
                child: Card(
                  elevation: model.elevation,
                  color: Colors.blueGrey,
                  child: InkWell(
                    onTap: () {
                      _scrollController.animateTo(0,
                          duration: Duration(milliseconds: ANIMATION_DURATION),
                          curve: Curves.easeInToLinear);
                    },
                    child: SizedBox(
                      width: 50,
                      height: 25,
                      child: Center(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            SizedBox(
                              width: 15,
                              height: 15,
                              child: FittedBox(
                                child: Icon(
                                  Icons.favorite,
                                  color: Colors.white70,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Text(
                                model.articleInfo.praiseNum.toString(),
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white70),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )),
            Padding(
              padding: EdgeInsets.only(right: 16, bottom: model.offsetEdit),
              child: FloatingActionButton(
                heroTag: 'hero_article_detail_b',
                onPressed: () {},
                elevation: model.elevation,
                child: Icon(
                  Icons.edit,
                  color: Colors.white70,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 16, bottom: model.offsetCollect),
              child: FloatingActionButton(
                heroTag: 'hero_article_detail_c',
                onPressed: presenter.startCollect,
                elevation: model.elevation,
                child: Icon(
                  model.articleInfo.isCollect
                      ? Icons.bookmark
                      : Icons.bookmark_border,
                  color: model.articleInfo.isCollect
                      ? UIData.COLOR_CRAIL
                      : Colors.white70,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 16, bottom: model.offsetFavorite),
              child: FloatingActionButton(
                  heroTag: 'hero_article_detail_d',
                  onPressed: presenter.startPraise,
                  elevation: model.elevation,
                  child: Icon(
                    model.articleInfo.isPraise
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: model.articleInfo.isPraise
                        ? UIData.COLOR_CRAIL
                        : Colors.white70,
                  )),
            ),
            Padding(
              padding: EdgeInsets.only(right: 16, bottom: 16),
              child: Transform.rotate(
                angle: model.rotateAdd,
                child: FloatingActionButton(
                  heroTag: 'hero_article_detail_add',
                  onPressed: presenter.startAnimation,
//                  onPressed: () {
//                    log(_key.currentContext.size.height.toString());
//                  },
//                  elevation: model.elevation,
                  child: Icon(
                    Icons.add,
                    color: Colors.white70,
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildComment(ArticleCommentModel model) {
    final commentList = model.articleCommentList.list;
    final commentCount = commentList == null ? 0 : commentList.length;
    final count = model.hasMore ? commentCount + 1 : commentCount;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Text(
            '文章评论',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: count,
          itemBuilder: (context, index) {
            if (index < commentCount) {
              return _buildCommentItem(commentList[index]);
            } else {
              return _buildLoading();
            }
          },
        )
      ],
    );
  }

  Widget _buildCommentItem(ArticleCommentListItem item) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        _buildCommentHeader(item),
        _buildCommentContent(item),
        _buildCommentFooter(item),
      ],
    );
  }

  Widget _buildCommentHeader(ArticleCommentListItem item) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: IntrinsicWidth(
        child: Row(
          children: <Widget>[
            CircleAvatar(
              radius: 25,
              backgroundImage: AssetImage('assets/images/ic_avatar.png'),
              child: Image.network(item.user.avatar),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  item.user.name,
                  style: TextStyle(
                    color: UIData.COLOR_MOUNTAIN_MIST,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
            Text(
              DateUtil.formatMillis(item.time, 'YYYY:MM:DD HH:mm:ss'),
              style: TextStyle(
                color: UIData.COLOR_MOUNTAIN_MIST,
                fontSize: 13
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildCommentContent(ArticleCommentListItem item) {
    List<Widget> children = List();
    if (item.parent != null) {
      children.add(
        Container(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          decoration: Widgets.buttonBoxDecoration,
          child: Text(
            item.parent.content,
            style: TextStyle(
              color: UIData.COLOR_MONSOON,
              fontSize: 14
            ),
          ),
        )
      );
    }
    children.add(Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Text(
        item.content,
        style: TextStyle(
          color: UIData.COLOR_MONSOON,
          fontSize: 14
        ),
      ),
    ));
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: children,
    );
  }

  Widget _buildCommentFooter(ArticleCommentListItem item) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Icon(
          Icons.favorite_border,
          color: UIData.COLOR_MOUNTAIN_MIST,
          size: 20
        ),
        Padding(
          padding: const EdgeInsets.only(left: 5),
          child: Text(
            item.praiseNum.toString(),
            style: TextStyle(
              fontSize: 12
            ),
          ),
        )
      ],
    );
  }

  Widget _buildLoading() {
    log("load comment");
    presenter.startLoadComment();
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
