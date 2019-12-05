import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Widgets {
	static BoxDecoration get buttonBoxDecoration =>
		BoxDecoration(
			border: Border.all(color: Colors.black12, width: 1),
		);

	static SnackBar defaultSnackBar (String info) =>
		SnackBar(
			content: Text(info),
		);

	static SnackBar defaultButtonSnackBar (String info, String buttonTitle,
		Function onTap) =>
		SnackBar(
			content: Text(info),
			action: SnackBarAction(
				onPressed: onTap,
				label: buttonTitle,
			),
		);

	static showSnackBar (BuildContext context, String info) {
		Scaffold.of(context)
			..hideCurrentSnackBar()
			..showSnackBar(defaultSnackBar(info));
	}

	static showButtonSnackBar (BuildContext context, String info,
		String buttonTitle, Function onTap) {
		Scaffold.of(context)
			..hideCurrentSnackBar()
			..showSnackBar(defaultButtonSnackBar(info, buttonTitle, onTap));
	}

	static Future<T> showSimpleDialog<T>(context, List<String> titles) async {
		List<SimpleDialogOption> children = List();
		for (int i = 0; i < titles.length; i++) {
			String title = titles[i];
			children.add(SimpleDialogOption(
				onPressed: () {
					Navigator.pop(context, i);
				},
				child: Padding(
					padding: const EdgeInsets.symmetric(vertical: 10),
					child: Text(
						title
					),
				),
			));
		}
		return showDialog<T>(
			context: context,
			builder: (context) {
				return SimpleDialog(
					children: children,
				);
			}
		);
	}
}