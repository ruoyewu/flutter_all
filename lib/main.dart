import 'package:all/view/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
	runApp(MyApp());
	SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
		systemNavigationBarColor: Colors.black,
		systemNavigationBarDividerColor: null,
		statusBarColor: null,
		statusBarIconBrightness: Brightness.dark,
		statusBarBrightness: Brightness.dark,
		systemNavigationBarIconBrightness: Brightness.light
	));
}
