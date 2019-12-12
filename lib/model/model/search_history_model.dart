import 'package:flutter/cupertino.dart';

class SearchHistoryModel extends ChangeNotifier {
	List<String> _list;

	List<String> get list => _list;

	set list (List<String> value) {
		_list = value;
		notifyListeners();
	}

}