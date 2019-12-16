import 'package:all/base/base_state.dart';
import 'package:all/model/bean/qingmang_bean.dart';
import 'package:all/model/model/search_app_item_model.dart';
import 'package:all/model/model/search_section_model.dart';
import 'package:all/model/ui_data.dart';
import 'package:all/presenter/contract/search_section_contract.dart';
import 'package:all/presenter/search_section_presenter.dart';
import 'package:all/utils/provider_consumer.dart';
import 'package:all/view/widget/heart_loading.dart';
import 'package:all/view/widget/widget.dart';
import 'package:flutter/material.dart';

class SectionListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SectionListState();
  }
}

class _SectionListState
    extends BaseState<SectionListPage, ISearchSectionPresenter>
    implements ISearchSectionView {
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

    return Scaffold(
      appBar: AppBar(
        title: Text(_section.title),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return ProviderConsumer<SearchSectionModel>(presenter.searchSectionModel,
        (context, model, _) {
      return GridView.builder(
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
