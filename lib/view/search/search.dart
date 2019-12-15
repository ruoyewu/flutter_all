import 'package:all/base/base_state.dart';
import 'package:all/presenter/contract/search_contract.dart';
import 'package:all/presenter/search_presenter.dart';
import 'package:all/view/search/search_result.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
@override
  State<StatefulWidget> createState() {
    return _SearchPageState();
  }
}

class _SearchPageState extends BaseState<SearchPage, ISearchPresenter> implements ISearchView {

  @override
  void initState() {
    super.initState();
    presenter = SearchPresenter(this);
  }

	@override
  Widget build(BuildContext context) {
	  return Scaffold(
      appBar: AppBar(
        title: Text('发现'),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              showSearch<String>(
                context: context, delegate: HomeSearchWidget(presenter));
            },
            icon: Icon(Icons.search),
          ),
        ],
      ),
    );
  }
}