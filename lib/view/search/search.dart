import 'package:all/base/base_state.dart';
import 'package:all/model/bean/qingmang_bean.dart';
import 'package:all/model/model/search_all_section_model.dart';
import 'package:all/model/model/search_app_item_model.dart';
import 'package:all/model/model/search_recommend_model.dart';
import 'package:all/model/ui_data.dart';
import 'package:all/model/user_color.dart';
import 'package:all/model/user_theme.dart';
import 'package:all/presenter/contract/search_contract.dart';
import 'package:all/presenter/search_presenter.dart';
import 'package:all/utils/provider_consumer.dart';
import 'package:all/view/search/search_result.dart';
import 'package:all/view/widget/widget.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SearchPageState();
  }
}

class _SearchPageState extends BaseState<SearchPage, ISearchPresenter>
    implements ISearchView {
  UserTextTheme _userTextTheme;

  @override
  void initState() {
    super.initState();
    presenter = SearchPresenter(this);
    presenter.startLoadRecommend();
    presenter.startLoadSections();
  }

  @override
  Widget build(BuildContext context) {
//    _userTextTheme = UserTextTheme.auto(context);
//    return ListView(
//      children: <Widget>[_buildRecommend(), _buildSections()],
//    );
    return Scaffold(
      appBar: AppBar(
        title: Text('发现'),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              showSearch<String>(
                  context: context, delegate: SearchResult(presenter));
            },
            icon: Icon(Icons.search),
          ),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[_buildRecommend(), _buildSections()],
      ),
    );
  }

  Widget _buildRecommend() {
    return SizedBox(
      height: 100,
      child: ProviderConsumer<SearchRecommendModel>(
          presenter.searchRecommendModel, (context, model, _) {
        return ListView.builder(
            itemCount: model.list?.length ?? 0,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return _buildRecommendItem(model.list[index]);
            });
      }),
    );
  }

  Widget _buildRecommendItem(ResultRecommend item) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, UIData.ROUTE_RECOMMEND_LIST, arguments: {
            'recommend': item
          });
        },
        child: SizedBox(
          width: 120,
          height: 80,
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                Image.network(
                  item.cover[0].url,
                  fit: BoxFit.cover,
                ),
                Container(
                  color: UserColor.COLOR_TRANSPARENT_BLACK,
                  alignment: Alignment.center,
                  child: Text(
                    item.title,
                    style:
                        TextStyle(fontSize: 14, color: UserColor.COLOR_MERCURY),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSections() {
    return ProviderConsumer<SearchAllSectionModel>(
        presenter.searchAllSectionModel, (context, model, _) {
      return ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          itemCount: model.list?.length ?? 0,
          itemBuilder: (context, index) {
            return _buildSectionItem(model.list[index]);
          });
    });
  }

  Widget _buildSectionItem(Section section) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, UIData.ROUTE_SECTION, arguments: {
          'section': section
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          children: <Widget>[
            Text(
              section.title,
              style: _userTextTheme.itemTitle,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Text(
                section.description ?? '',
                style: _userTextTheme.little,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Container(
                height: 130,
                alignment: Alignment.center,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: section.subEntity?.length ?? 0,
                    itemBuilder: (context, index) {
                      return _buildAppItem(section.subEntity[index]);
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildAppItem(AppItem app) {
    SearchAppItemModel appItemModel = SearchAppItemModel(app);
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, UIData.ROUTE_APP, arguments: appItemModel.appItem);
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
}
