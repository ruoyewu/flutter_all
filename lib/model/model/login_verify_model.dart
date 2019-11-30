import 'package:flutter/cupertino.dart';

class LoginVerifyModel extends ChangeNotifier {
	int _timeLeft = 0;

	int get timeLeft => _timeLeft;

	update(int timeLeft) {
		_timeLeft = timeLeft;
		notifyListeners();
	}
}