import 'package:all/model/user_color.dart';
import 'package:all/view/app.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Widgets {
	static BoxDecoration get buttonBoxDecoration =>
		BoxDecoration(
			border: Border.all(color: UserColor.COLOR_PALE_SLATE, width: 1),
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

	static Future<T> showAlertDialog<T> (context,
		{String title, String info}) async {
		return showDialog(
			context: context,
			builder: (context) {
				return true
					? AlertDialog(
					title: title != null ? Text(title) : null,
					actions: <Widget>[
						RawMaterialButton(
							onPressed: () {
								Navigator.pop(context, 1);
							},
							child: Text(
								'取消',
								style: TextStyle(color: UserColor.COLOR_MONSOON),
							),
						),
						RawMaterialButton(
							onPressed: () {
								Navigator.pop(context, 0);
							},
							child: Text(
								'确定',
								style: TextStyle(color: Colors.blueGrey),
							),
						),
					],
				)
					: CupertinoAlertDialog(
					title: title != null ? Text(title) : null,
					actions: <Widget>[
						CupertinoButton(
							onPressed: () {
								Navigator.pop(context, 1);
							},
							child: Text(
								'取消',
								style: TextStyle(color: UserColor.COLOR_MONSOON),
							),
						),
						CupertinoButton(
							onPressed: () {
								Navigator.pop(context, 0);
							},
							child: Text(
								'确定',
								style: TextStyle(color: Colors.blueGrey),
							),
						),
					],
				);
			});
	}

	static Future<T> showSimpleDialog<T> (context, List<String> titles,
		{type = Type.MATERIAL}) async {
		var children = List<Widget>();
		for (int i = 0; i < titles.length; i++) {
			String title = titles[i];
			children.add(type == Type.MATERIAL ? SimpleDialogOption(
				onPressed: () {
					Navigator.pop(context, i);
				},
				child: Padding(
					padding: const EdgeInsets.symmetric(vertical: 10),
					child: Text(title),
				),
			) : CupertinoActionSheetAction(
				onPressed: () {
					Navigator.pop(context, i);
				},
				child: Text(title),
			));
		}
		return type == Type.MATERIAL
			? showDialog<T>(
			context: context,
			builder: (context) {
				return SimpleDialog(
					children: children,
				);
			})
			: showCupertinoModalPopup(context: context, builder: (context) {
			return CupertinoActionSheet(
				actions: children
			);
		});

	}
}
