import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingPage extends StatefulWidget {
	@override
  State<StatefulWidget> createState() {
    return _SettingPageState();
  }
}

class _SettingPageState extends State<SettingPage> {
	@override
  Widget build(BuildContext context) {
		return DefaultTabController(
			length: 5,
		  child: Scaffold(
		  	appBar: AppBar(
				  bottom: TabBar(
					  tabs: _buildTabs(5)),
			  ),
		  	body: PageView.builder(
		  		itemCount: 5,
		  		itemBuilder: (context, index) {
		  			return _Page();
		  	}),
		  ),
		);
  }

  _buildTabs(int count) {
		List<Widget> children = List();
		for (int i = 0; i < count; i++) {
			children.add(Tab(text: i.toString(),));
		}
		return children;
  }
}

class _Page extends StatefulWidget {
	@override
  State<StatefulWidget> createState() {
    return _PageState();
  }
}

class _PageState extends State<_Page> with AutomaticKeepAliveClientMixin {

	@override
  bool get wantKeepAlive => true;

	@override
  Widget build(BuildContext context) {
		super.build(context);
		return RefreshIndicator(
			onRefresh: () {
				return Future.value(true);
			},
		  child: ListView.builder(
		  	itemCount: 50,
		  	itemBuilder: (context, index) {
		  		return ListTile(title: Text(index.toString()),);
		  	},
		  ),
		);
  }
}