import 'package:all/base/base_state.dart';
import 'package:all/model/bean/qingmang_bean.dart';
import 'package:all/model/model/search_app_item_model.dart';
import 'package:all/model/model/search_section_model.dart';
import 'package:all/model/ui_data.dart';
import 'package:all/presenter/contract/search_section_contract.dart';
import 'package:all/presenter/search_section_presenter.dart';
import 'package:all/utils/provider_consumer.dart';
import 'package:all/view/app.dart';
import 'package:all/view/widget/heart_loading.dart';
import 'package:all/view/widget/widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SectionListPage extends StatefulWidget {
  SectionListPage(this.type);

  final type;

  @override
  State<StatefulWidget> createState() {
    return _SectionListState.type(type);
  }
}

abstract class _SectionListState
    extends BaseState<SectionListPage, ISearchSectionPresenter>
    implements ISearchSectionView {

  static type(Type type) {
    switch (type) {
      case Type.MATERIAL:
        return _SectionListStateMaterial();
      case Type.CUPRETINO:
        return _SectionListStateCupertino();
    }
  }

  Section _section;
  bool _firstLoad = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_firstLoad) {
      Map arguments = ModalRoute.of(context).settings.arguments;
      _section = arguments['section'];

      presenter = SearchSectionPresenter(this, _section.id);
      _firstLoad = false;
    }

    return body(context);
  }

  Widget _buildBody({bool shrink = false}) {
    return ProviderConsumer<SearchSectionModel>(presenter.searchSectionModel,
        (context, model, _) {
      return GridView.builder(
        shrinkWrap: shrink,
          physics: shrink ? NeverScrollableScrollPhysics() : AlwaysScrollableScrollPhysics(),
          itemCount: model.hasMore
              ? ((model.list?.length ?? 0) + 1)
              : ((model.list?.length ?? 0)),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4, childAspectRatio: 0.6),
          itemBuilder: (context, index) {
            if (index < model.list.length) {
              return _buildAppItem(model.list[index]);
            } else {
              return _buildLoading();
            }
          });
    });
  }

  Widget _buildAppItem(AppItem app) {
    SearchAppItemModel appItemModel = SearchAppItemModel(app);
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, UIData.ROUTE_APP,
            arguments: appItemModel.appItem);
      },
      child: SizedBox(
        width: MediaQuery.of(context).size.width / 4,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: IntrinsicHeight(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  child: Image.network(
                    app.icon,
                    width: 60,
                    height: 60,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                    app.title,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
                ProviderConsumer<SearchAppItemModel>(appItemModel,
                    (context, model, _) {
                  return InkWell(
                    onTap: () => presenter.startAddAppItem(model),
                    child: Container(
                      decoration: Widgets.buttonBoxDecoration,
                      child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 2, horizontal: 15),
                          child: Icon(
                            model.appItem.userSaved ? Icons.check : Icons.add,
                            size: 18,
                          )),
                    ),
                  );
                })
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoading() {
    presenter.startLoadSection();
    return HeartLoadingPage();
  }
}

class _SectionListStateCupertino extends _SectionListState {
  @override
  Widget buildBody(BuildContext context) {
    Map arguments = ModalRoute.of(context).settings.arguments;
    final heroTag = arguments['hero'];
    final lastTitle = arguments['title'];
    return CupertinoPageScaffold(
      child: CustomScrollView(
        slivers: <Widget>[
          CupertinoSliverNavigationBar(
            heroTag: heroTag,
            previousPageTitle: lastTitle,
            largeTitle: Text(_section.title),
          ),
          SliverToBoxAdapter(
            child: Material(child: _buildBody(shrink: true)),
          )
//        SliverList(
//          delegate: SliverChildBuilderDelegate(
//            (context, index) {
//
//            }
//          ),
//        )
        ],
      ),
    );
  }
}

class _SectionListStateMaterial extends _SectionListState {
  @override
  Widget buildBody(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_section.title),
      ),
      body: _buildBody(),
    );
  }
}