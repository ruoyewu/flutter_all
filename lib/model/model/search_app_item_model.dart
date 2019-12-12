import 'package:all/model/bean/qingmang_bean.dart';
import 'package:flutter/cupertino.dart';

class SearchAppItemModel extends ChangeNotifier {
	SearchAppItemModel(this._appItem);

	AppItem _appItem;

	AppItem get appItem => _appItem;

	set appItem (AppItem value) {
		_appItem = value;
		notifyListeners();
	}

	update() {
		notifyListeners();
	}
}