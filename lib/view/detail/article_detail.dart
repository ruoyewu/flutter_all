import 'dart:convert';

import 'package:all/base/base_state.dart';
import 'package:all/model/bean/article_comment_list_item.dart';
import 'package:all/model/bean/qingmang_bean.dart';
import 'package:all/model/model/article_comment_item_model.dart';
import 'package:all/model/model/article_comment_model.dart';
import 'package:all/model/model/article_detail_info_model.dart';
import 'package:all/model/model/article_detail_model.dart';
import 'package:all/model/ui_data.dart';
import 'package:all/model/user_color.dart';
import 'package:all/model/user_theme.dart';
import 'package:all/presenter/article_detail_presenter.dart';
import 'package:all/presenter/contract/article_detail_contract.dart';
import 'package:all/utils/date_format.dart';
import 'package:all/utils/image_util.dart';
import 'package:all/utils/provider_consumer.dart';
import 'package:all/view/app.dart';
import 'package:all/view/detail/article_detail_content.dart';
import 'package:all/view/image/image.dart';
import 'package:all/view/widget/heart_loading.dart';
import 'package:all/view/widget/widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

//class ArticleDetailListPage extends StatelessWidget {
//  ArticleDetailListPage(this.type);
//
//  final type;
//
//  @override
//  Widget build(BuildContext context) {
//    Map arguments = ModalRoute.of(context).settings.arguments;
//    final list = arguments['list'];
//    final index = arguments['index'];
//
//    return PageView.builder(
//        controller: PageController(initialPage: index),
//        itemCount: list.length,
//        itemBuilder: (context, index) {
//          return ArticleDetailPage(
//            type,
//            item: list[index],
//          );
//        });
//  }
//}

class ArticleDetailPage extends StatefulWidget {
  ArticleDetailPage(this.type, {this.item, this.showTitle = true});

  final type;
  ArticleListItem item;
  bool showTitle;

  @override
  State<StatefulWidget> createState() {
    return _ArticleDetailState.type(type);
  }
}

abstract class _ArticleDetailState
    extends BaseState<ArticleDetailPage, IArticleDetailPresenter>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin
    implements IArticleDetailView {
  static const MAX_WIDTH = 800.0;
  static const ANIMATION_DURATION = 300;

  ScrollController _scrollController;
  TextEditingController _commentEditController;
  GlobalKey _articleKey;
  BuildContext _snackBarContext;
  UserColor _userColor;
  ArticleListItem item;
  var heroTag;
  var lastTitle;
  bool shouldRebuild;

  static type(Type type) {
    switch (type) {
      case Type.MATERIAL:
        return _ArticleDetailStateMaterial();
      case Type.CUPRETINO:
        return _ArticleDetailStateCupertino();
    }
  }

  @override
  bool get wantKeepAlive => true;

  @override
  TickerProvider get tickerProvider => this;

  onCommentSubmit({int parent = 0}) {
    presenter.startSendComment(parent, _commentEditController.text);
    _commentEditController.clear();
    Navigator.pop(context);
  }

  onShowCommentDialog(ArticleCommentListItem item) {
    presenter.commentDialogTitles(item).then((titles) {
      Widgets.showSimpleDialog(context, titles).then((index) {
        switch (index) {
          case 0:
            Clipboard.setData(ClipboardData(text: item.content));
            onResultInfo('复制成功');
            break;
          case 1:
            onResultInfo('举报成功');
            break;
          case 2:
            presenter.showEditDialog(item);
            break;
          case 3:
            presenter.startDeleteComment(item.id);
            break;
        }
      });
    });
  }

  onOriginalUrlTap(ArticleListItem item) {
    Navigator.pushNamed(context, UIData.ROUTE_WEB,
        arguments: {'url': item.subEntry[0].action.url, 'title': item.title});
  }

  Future<bool> onWillPop() {
    Navigator.pop(context, presenter.articleDetailInfoModel.articleInfo);
    return Future.value(false);
  }

  @override
  scrollToComment() {
    final scrollSize = _articleKey.currentContext.size.height;
    final maxScrollSize = _scrollController.position.maxScrollExtent;
    final realScroll = scrollSize > maxScrollSize ? maxScrollSize : scrollSize;
    _scrollController.animateTo(realScroll,
        duration: Duration(milliseconds: ANIMATION_DURATION),
        curve: Curves.easeInToLinear);
  }

  @override
  scrollToPosition(double y) {
    _scrollController.animateTo(y,
        duration: Duration(milliseconds: 100), curve: Curves.easeInToLinear);
  }

  @override
  onResultInfo(String info, {int code}) {
    if (code == 401) {
      Widgets.showButtonSnackBar(_snackBarContext, info, '登录', () {
        Navigator.of(context).pushNamed(UIData.ROUTE_LOGIN).then((result) {
          if (result != null) {
            Widgets.showSnackBar(_snackBarContext, '登录成功');
          }
        });
      });
    } else {
      Widgets.showSnackBar(_snackBarContext, info);
    }
  }

  @override
  onShowEditDialog(String userName, ArticleCommentListItem parent) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: _snackBarContext,
        builder: (context) {
          return AnimatedPadding(
              duration: const Duration(milliseconds: 100),
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: _buildCommentEdit(userName, parent));
        });
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _articleKey = GlobalKey(debugLabel: 'article_key');
    _commentEditController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    _userColor = UserColor.auto(context);

    shouldRebuild = false;
    if (widget.item != null) {
      shouldRebuild = true;
      item = widget.item;
    } else {
      try {
        Map arguments = ModalRoute.of(context).settings.arguments;
        item = arguments["item"];
        heroTag = arguments['hero'];
        lastTitle = arguments['title'];
      } catch (e) {
        print(e);
      }
    }
    if (item == null) {
      return Scaffold(
        body: HeartLoadingPage(),
      );
    }

    if (shouldRebuild) {
      (presenter as ArticleDetailPresenter).item = item;
      (presenter as ArticleDetailPresenter).nextComment = 0;
      presenter.articleCommentModel.articleCommentList.list?.clear();
      presenter.startLoadArticle();
      presenter.startLoadArticleInfo();
      presenter.startLoadComment();
    }

    return body(context);
  }


  Widget buildBody (BuildContext context) {
    presenter = ArticleDetailPresenter(this, item: item);
    presenter.startLoadArticle();
    presenter.startLoadArticleInfo();
  }

  Widget _buildHeader(ArticleDetail detail) {
    List<Widget> children = List();
    if (detail.title != null) {
      children.add(Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Text(
          detail.title,
          style: TextStyle(
            fontSize: 18,
          ),
        ),
      ));

//      if (detail.snippet != null && detail.snippet != '') {
//        children.add(Align(
//          alignment: Alignment.centerRight,
//          child: Text(
//            detail.snippet,
//            style: TextStyle(fontSize: 16, color: Colors.black54),
//          ),
//        ));
//      }
    }

    if (detail.author != null) {
      children.add(Align(
        alignment: Alignment.center,
        child: Text(
          detail.author.name,
          style: TextStyle(
            fontSize: 14,
          ),
        ),
      ));
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Column(children: children),
    );
  }

  Widget _buildContent(ArticleDetail detail) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Builder(
        builder: (context) {
          return ArticleDetailContentWidget(
            (json.decode(detail.detail.articleDetail.contentHtml) as List)
                .map((item) => ArticleContentItem.fromJson(item)),
            onImagePress: (list, url, positionList) {
              Navigator.of(context)
                  .push(PageRouteBuilder(
                      opaque: false,
                      pageBuilder: (context, _1, _2) {
                        return ImagePage();
                      },
                      settings:
                          RouteSettings(name: UIData.ROUTE_IMAGE, arguments: {
                        'imageList': list,
                        'image': url,
                        'position': positionList,
                        'scrollFunction': this.scrollToPosition,
                        'suffix': detail.idString
                      })))
                  .then((_) {
//              SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
              });
            },
            onLinkPress: (url) {
              Navigator.pushNamed(context, UIData.ROUTE_WEB,
                  arguments: {'title': detail.title, 'url': url});
            },
            articleId: detail.idString,
          );
        },
      ),
    );
  }

  Widget _buildBottom() {
    final userTextTheme = UserTextTheme.auto(context);
    return Material(
      elevation: 5,
      color: _userColor.highlightBackgroundColor,
      child: SafeArea(
        top: false,
        child: Container(
          height: 50,
          child: ProviderConsumer<ArticleDetailInfoModel>(
              presenter.articleDetailInfoModel, (context, model, _) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                IconButton(
                  onPressed: () => presenter.showEditDialog(null),
                  icon: Icon(
                    Icons.comment,
                    color: _userColor.selectColor,
                  ),
                ),
                Text(
                  model.articleInfo.commentNum.toString(),
                  style: userTextTheme.little,
                ),
                IconButton(
                  onPressed: presenter.startCollect,
                  icon: Icon(
                    model.articleInfo.isCollect
                        ? Icons.bookmark
                        : Icons.bookmark_border,
                    color: _userColor.selectColor,
                  ),
                ),
                Text(
                  model.articleInfo.collectNum.toString(),
                  style: userTextTheme.little,
                ),
                IconButton(
                  onPressed: presenter.startPraise,
                  icon: Icon(
                      model.articleInfo.isPraise
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: _userColor.selectColor),
                ),
                SizedBox(
                  width: 25,
                  child: Text(
                    model.articleInfo.praiseNum.toString(),
                    maxLines: 1,
                    style: userTextTheme.little,
                  ),
                )
              ],
            );
          }),
        ),
      ),
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
    ArticleCommentItemModel model = ArticleCommentItemModel();
    model.articleCommentListItem = item;
    return InkWell(
      onTap: () => onShowCommentDialog(item),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        child: ProviderConsumer<ArticleCommentItemModel>(model,
            (context, model, _) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildCommentHeader(model.articleCommentListItem),
              _buildCommentContent(model.articleCommentListItem),
              _buildCommentFooter(model),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildCommentHeader(ArticleCommentListItem item) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: <Widget>[
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, UIData.ROUTE_USER,
                arguments: item.user.id),
            child: CircleAvatar(
              radius: 15,
              backgroundImage: ImageUtil.image(item.user.avatar,
                  placeHolder: 'assets/images/ic_avatar.png'),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                item.user.name,
                style: TextStyle(
                  color: UserColor.COLOR_MOUNTAIN_MIST,
                  fontSize: 15,
                ),
              ),
            ),
          ),
          Text(
            DateUtil.formatMillis(item.time, 'YYYY/MM/dd HH:mm:ss'),
            style:
                TextStyle(color: UserColor.COLOR_MOUNTAIN_MIST, fontSize: 13),
          )
        ],
      ),
    );
  }

  Widget _buildCommentContent(ArticleCommentListItem item) {
    List<Widget> children = List();
    if (item.parent != null) {
      children.add(Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: Widgets.buttonBoxDecoration,
        child: Text(
          '${item.parent.user.name} : ${item.parent.content}',
          maxLines: 10,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(color: UserColor.COLOR_MOUNTAIN_MIST, fontSize: 14),
        ),
      ));
    }
    children.add(Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        item.content,
        style: TextStyle(color: UserColor.COLOR_MONSOON, fontSize: 14),
      ),
    ));
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    );
  }

  Widget _buildCommentFooter(ArticleCommentItemModel item) {
    return Align(
      alignment: Alignment.centerRight,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          InkWell(
            onTap: () => presenter.startPraiseComment(item),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(
                      item.articleCommentListItem.isPraise
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: item.articleCommentListItem.isPraise
                          ? UserColor.COLOR_CRAIL
                          : UserColor.COLOR_MOUNTAIN_MIST,
                      size: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: SizedBox(
                      width: 20,
                      child: Text(
                        item.articleCommentListItem.praiseNum.toString(),
                        textAlign: TextAlign.start,
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () => presenter.showEditDialog(item.articleCommentListItem),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(Icons.edit,
                      color: UserColor.COLOR_MOUNTAIN_MIST, size: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: SizedBox(
                      width: 20,
                      child: Text(
                        item.articleCommentListItem.commentNum.toString(),
                        textAlign: TextAlign.start,
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCommentEdit(String userName, ArticleCommentListItem parent) {
    List<Widget> children = List();
    children.add(Text(
      userName,
      style: TextStyle(color: Colors.blueGrey, fontSize: 15),
    ));
    if (parent != null) {
      children.add(Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(5)),
          border: Border.all(color: UserColor.COLOR_MERCURY, width: 1),
        ),
        child: Text(
          '${parent.user.name} : ${parent.content}',
          maxLines: 5,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(color: UserColor.COLOR_MOUNTAIN_MIST, fontSize: 14),
        ),
      ));
    }
    children.add(Theme(
      data: ThemeData(
        primaryColor: Colors.blueGrey,
        primarySwatch: Colors.blueGrey,
//          fontFamily: 'Longzhao'
      ),
      child: TextField(
        controller: _commentEditController,
        minLines: 5,
        maxLines: 8,
        style: TextStyle(color: UserColor.COLOR_MONSOON, height: 1.5),
        decoration: InputDecoration(
          labelText: '写下你的评论...',
        ),
      ),
    ));
    return IntrinsicHeight(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: children,
              ),
            ),
            SizedBox(
              width: 80,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  FloatingActionButton(
                    onPressed: () =>
                        onCommentSubmit(parent: parent != null ? parent.id : 0),
                    child: Icon(
                      Icons.check,
                      color: Colors.white70,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildLoading() {
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

class _ArticleDetailStateCupertino extends _ArticleDetailState {
  @override
  Widget buildBody(BuildContext context) {
    super.buildBody(context);
    return CupertinoPageScaffold(
      child: Builder(builder: (context) {
        _snackBarContext = context;
        return Column(
          children: <Widget>[
            Expanded(
              child: CupertinoScrollbar(
                child: CustomScrollView(
                  controller: _scrollController,
                  slivers: <Widget>[
                    if (widget.showTitle)
                      CupertinoSliverNavigationBar(
                        // ignore: sdk_version_ui_as_code
                        heroTag: heroTag,
                        previousPageTitle: lastTitle,
                        largeTitle: Text(
                          item.subEntry[0].title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    SliverToBoxAdapter(
                      child: ProviderConsumer<ArticleDetailModel>(
                          presenter.articleDetailModel, (context, model, _) {
                        if (model == null || model.articleDetail == null) {
                          return Column();
                        }
                        if (shouldRebuild) {
                          scrollToPosition(0);
                        }
                        return Column(
                          children: <Widget>[
                            Column(
                              key: _articleKey,
                              children: <Widget>[
                                _buildHeader(model.articleDetail),
                                _buildContent(model.articleDetail),
//                        _buildFooter(item)
                              ],
                            ),
                            ProviderConsumer<ArticleCommentModel>(
                                presenter.articleCommentModel,
                                (context, model, _) {
                              return _buildComment(model);
                            }),
                          ],
                        );
                      }),
                    )
                  ],
                ),
              ),
            ),
            _buildBottom()
          ],
        );
      }),
    );
  }
}

class _ArticleDetailStateMaterial extends _ArticleDetailState {
  @override
  Widget buildBody(BuildContext context) {
    super.buildBody(context);
    return Scaffold(
      appBar: widget.showTitle
          ? AppBar(
              title: Text(item.subEntry[0].title ?? item.title),
              actions: <Widget>[
//                if (Platform == null || Platform.isAndroid || Platform.isIOS)
                IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, UIData.ROUTE_WEB, arguments: {
                      'url': item.subEntry[0].action.url,
                      'title': item.subEntry[0].title
                    });
                  },
                  icon: Icon(Icons.share),
                )
              ],
            )
          : null,
      bottomNavigationBar: _buildBottom(),
      body: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: _ArticleDetailState.MAX_WIDTH),
          child: Builder(
            builder: (context) {
              _snackBarContext = context;

              List<Widget> children = List();
              children.add(Scrollbar(
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: ProviderConsumer<ArticleDetailModel>(
                      presenter.articleDetailModel, (context, model, _) {
                    if (model == null || model.articleDetail == null) {
                      return Column();
                    }
                    if (shouldRebuild) {
                      scrollToPosition(0);
                    }
                    return Column(
                      children: <Widget>[
                        Column(
                          key: _articleKey,
                          children: <Widget>[
                            _buildHeader(model.articleDetail),
                            _buildContent(model.articleDetail),
//                        _buildFooter(item)
                          ],
                        ),
                        ProviderConsumer<ArticleCommentModel>(
                            presenter.articleCommentModel, (context, model, _) {
                          return _buildComment(model);
                        }),
                      ],
                    );
                  }),
                ),
              ));
//              children.add(_buildInfo());
              return Stack(
                children: children,
              );
            },
          ),
        ),
      ),
    );
  }
}
