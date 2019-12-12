import 'package:all/model/model/search_app_item_model.dart';
import 'package:all/model/model/search_app_model.dart';
import 'package:all/model/model/search_history_model.dart';
import 'package:all/model/ui_data.dart';
import 'package:all/presenter/contract/home_contract.dart';
import 'package:all/utils/provider_consumer.dart';
import 'package:all/view/widget/heart_loading.dart';
import 'package:all/view/widget/widget.dart';
import 'package:flutter/material.dart';

class HomeSearchWidget extends SearchDelegate<String> {
  HomeSearchWidget(this.presenter);

  IHomePresenter presenter;

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(
          Icons.clear,
          color: Colors.black,
        ),
        onPressed: () => query = "",
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
          color: Colors.black,
        ),
        onPressed: () => close(context, null));
  }

  @override
  Widget buildResults(BuildContext context) {
    presenter.startSearch(query);
    presenter.startAddSearchHistory(query);

    return ProviderConsumer<SearchAppModel>(presenter.searchAppModel,
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
                          color: UIData.COLOR_MONSOON))),
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
                                child: Icon(itemModel.appItem.userSaved
                                  ? Icons.clear
                                  : Icons.check)),
                            ),
                          )
                        ),
                      );
                    });
                  } else {
                    return _buildSearchResultFooter(model.hasMore);
                  }
                },
              )
            ],
          ),
        ),
      );
    });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    presenter.startRefreshSearchHistory();

    return ProviderConsumer<SearchHistoryModel>(presenter.searchHistoryModel,
        (context, model, _) {
      if (model.list != null) {
        final itemCount = model.list.length > 0 ? model.list.length + 1 : 0;
        return SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                child: Text(
                  '搜索历史',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: UIData.COLOR_MONSOON),
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
//                        buildResults(context);
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
    });
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
          style: TextStyle(color: UIData.COLOR_MONSOON),
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
