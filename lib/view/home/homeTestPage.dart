
import 'package:all/model/ui_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeTestPage extends StatelessWidget {
	@override
  Widget build(BuildContext context) {
    // TODO: implement build
    return CupertinoPageScaffold(
	    navigationBar: CupertinoNavigationBar(
		    middle: Text("detail"),
	    ),
	    child: Material(
	      child: Center(
		      child: InkWell(
			      onTap: () {
				      Navigator.pushNamed(context, UIData.ROUTE_HOME);
			      },
			      child: SizedBox(
				      width: 100,
				      height: 100,
				      child: Text("click",
					      style: TextStyle(
						      backgroundColor: Colors.white,
						      color: Colors.grey,
					      ),),
			      ),
		      ),
	      ),
	    ),
    );
  }
}