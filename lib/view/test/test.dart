import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TestPage extends StatelessWidget {
	@override
	Widget build (BuildContext context) {
		return Material(
			child: Scaffold(
				body: Center(
				  child: SizedBox(
				    height: 100,
				    child: ListWheelScrollView.useDelegate(
				  		itemExtent: 20, childDelegate: ListWheelChildBuilderDelegate(
				  		builder: (context, index) {
				  			return ListTile(
				  				title: const Text('wheel list'),
				  			);
				  		},
				  		childCount: 100
				  	)),
				  ),
				),
			),
		);
	}
}
