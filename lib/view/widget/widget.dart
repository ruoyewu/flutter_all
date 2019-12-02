import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Widgets {
	static BoxDecoration get buttonBoxDecoration => BoxDecoration(
		border: Border.all(color: Colors.black12, width: 1),
	);

	static SnackBar defaultSnackBar(String info) => SnackBar(
		content: Text(info),
	);

	static showSnackBar(BuildContext context, String info) {
		Scaffold.of(context)
			..hideCurrentSnackBar()
			..showSnackBar(defaultSnackBar(info));
	}
}