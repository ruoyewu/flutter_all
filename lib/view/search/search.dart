import 'package:all/base/base_state.dart';
import 'package:all/presenter/contract/search_contract.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
@override
  State<StatefulWidget> createState() {
    return _SearchPageState();
  }
}

class _SearchPageState extends BaseState<SearchPage, ISearchPresenter> {
	@override
  Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(

			),
			body: Column(),
		);
  }
}