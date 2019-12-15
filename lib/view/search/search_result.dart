import 'package:all/model/model/search_app_item_model.dart';
import 'package:all/model/model/search_app_model.dart';
import 'package:all/model/model/search_history_model.dart';
import 'package:all/model/ui_data.dart';
import 'package:all/model/user_color.dart';
import 'package:all/presenter/contract/search_contract.dart';
import 'package:all/utils/provider_consumer.dart';
import 'package:all/view/widget/heart_loading.dart';
import 'package:all/view/widget/widget.dart';
import 'package:flutter/material.dart';

class HomeSearchWidget extends SearchDelegate<String> {
  HomeSearchWidget(this.presenter) : super(searchFieldLabel: '请输入搜索内容...');

  ISearchPresenter presenter;

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(
          Icons.clear,
        ),
        onPressed: () {
          if (query != '') {
            query = '';
          } else {
            Navigator.pop(context);
          }
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: () => close(context, null));
  }

  @override
  Widget buildResults(BuildContext context) {
    presenter.startSearch(query);
    presenter.startAddSearchHistory(query);

    return SizedBox.expand(
      child: ProviderConsumer<SearchAppModel>(presenter.searchAppModel,
          (context, model, _) {
        if (model.searchAppList == null) {
          return HeartLoadingPage();
        }
        return Scrollbar(
            child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  child: Text('搜索结果',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: UserColor.COLOR_MONSOON))),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: model.searchAppList.length,
                itemBuilder: (context, index) {
                  if (index < model.searchAppList.length) {
                    final itemModel =
                        SearchAppItemModel(model.searchAppList[index]);
                    return ProviderConsumer<SearchAppItemModel>(itemModel,
                        (context, itemModel, _) {
                      return InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, UIData.ROUTE_APP,
                              arguments: itemModel.appItem);
                        },
                        child: ListTile(
                            title: Text(itemModel.appItem.title),
                            leading: CircleAvatar(
                              backgroundImage:
                                  NetworkImage(itemModel.appItem.icon),
                            ),
                            trailing: InkWell(
                              onTap: () {
                                presenter.startAddAppItem(itemModel);
                              },
                              child: SizedBox(
                                height: 30,
                                width: 60,
                                child: DecoratedBox(
                                    decoration: Widgets.buttonBoxDecoration,
                                    child: Icon(
                                      itemModel.appItem.userSaved
                                          ? Icons.clear
                                          : Icons.check,
                                      color: UserColor.COLOR_MOUNTAIN_MIST,
                                    )),
                              ),
                            )),
                      );
                    });
                  } else {
                    return _buildSearchResultFooter(model.hasMore);
                  }
                },
              )
            ],
          ),
        ));
      }),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    presenter.startRefreshSearchHistory();

    return SizedBox.expand(
      child: ProviderConsumer<SearchHistoryModel>(presenter.searchHistoryModel,
          (context, model, _) {
        if (model.list != null) {
          final itemCount = model.list.length > 0 ? model.list.length + 1 : 0;
          return SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  child: Text(
                    '搜索历史',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: UserColor.COLOR_MONSOON),
                  ),
                ),
                ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: itemCount,
                    itemBuilder: (context, index) {
                      if (index < model.list.length) {
                        return InkWell(
                          onTap: () {
                            query = model.list[index];
                            showResults(context);
                          },
                          child: ListTile(
                            title: Text(model.list[index]),
                          ),
                        );
                      } else {
                        return _buildClearHistory();
                      }
                    }),
              ],
            ),
          );
        } else {
          return HeartLoadingPage();
        }
      }),
    );
  }


  ThemeData appBarTheme (BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return theme.copyWith(
      primaryIconTheme: theme.primaryIconTheme.copyWith(color: UserColor.auto(context).iconColor),
      primaryColorBrightness: Brightness.dark,
      textTheme: TextTheme(
        title: TextStyle(fontSize: 16),
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(fontSize: 16)
      )
    );
  }

  Widget _buildClearHistory() {
    return InkWell(
      onTap: presenter.startClearHistory,
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: Widgets.buttonBoxDecoration,
        alignment: Alignment.center,
        child: Text(
          '清空历史记录',
          textAlign: TextAlign.center,
          style: TextStyle(color: UserColor.COLOR_MONSOON),
        ),
      ),
    );
  }

  Widget _buildSearchResultFooter(bool hasMore) {
    return HeartLoadingBar(
      isLoading: hasMore,
    );
  }
}
