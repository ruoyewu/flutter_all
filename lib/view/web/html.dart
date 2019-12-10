
import 'package:all/view/widget/widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/image_properties.dart';
import 'package:html/dom.dart' as dom;

class HtmlPage extends StatelessWidget {
	@override
	Widget build (BuildContext context) {
		Map arguments = ModalRoute
			.of(context)
			.settings
			.arguments;
		final html = arguments['html'];

		return Scaffold(
			appBar: AppBar(
				title: Text(
					'Html'
				),
			),
			body: SingleChildScrollView(
				child: Builder(
					builder: (context) {
						return Column(
							mainAxisSize: MainAxisSize.min,
							children: <Widget>[
								Padding(
									padding: const EdgeInsets.symmetric(
										vertical: 10, horizontal: 10),
									child: Html(
										data: html,
										useRichText: true,
										blockSpacing: 0,
										shrinkToFit: true,
										defaultTextStyle: TextStyle(
											fontSize: 16,
											height: 1.6,
											color: Colors.black54,
										),
										linkStyle: TextStyle(
											fontWeight: FontWeight.bold,
											fontSize: 15,
										),
										customRender: (dom.Node node, List<Widget> children) {
											if (node is dom.Element) {
												if (node.localName == 'img') {
//													return Text(node.attributes['src']);
												}
											}
											return null;
										},
										imageProperties: ImageProperties(
											width: double.infinity,
											height: double.negativeInfinity,
											fit: BoxFit.fitWidth
										),
										onImageTap: (source) {
											Widgets.showSnackBar(context, source);
										},
										onLinkTap: (url) {
											Widgets.showSnackBar(context, url);
										},
									),
								),
								ListView.builder(
									itemCount: 100,
									shrinkWrap: true,
									physics: NeverScrollableScrollPhysics(),
									itemBuilder: (context, index) {
										return Text('test');
									},
								),
							],
						);
					}
				),
			),
		);
	}
}