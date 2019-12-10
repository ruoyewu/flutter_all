import 'package:all/model/bean/qingmang_bean.dart';
import 'package:flutter/cupertino.dart';

class SearchAppModel extends ChangeNotifier {
	List<AppItem> _searchAppList = List();

	List<AppItem> get searchAppList => _searchAppList;

	set searchAppList (List<AppItem> value) {
		_searchAppList = value;
		notifyListeners();
	}
}