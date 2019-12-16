import 'package:all/view/widget/widget.dart';
import 'package:flutter/material.dart';

class UserNotLoginWidget extends StatelessWidget {
	UserNotLoginWidget(this.onLoginTap);

	Function onLoginTap;

	@override
  Widget build(BuildContext context) {
		return RefreshIndicator(
			onRefresh: () {},
		  child: Center(
		  	child: InkWell(
		  		onTap: onLoginTap,
		  		child: Container(
		  			width: 100,
		  			height: 40,
		  			decoration: Widgets.buttonBoxDecoration,
		  			alignment: Alignment.center,
		  			child: Text('点击登录'),
		  		),
		  	),
		  ),
		);
  }
}