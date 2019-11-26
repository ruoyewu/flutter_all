import 'dart:developer';

import 'package:all/model/bean/article_detail_content_item.dart';
import 'package:all/model/ui_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ArticleDetailContentWidget extends StatelessWidget {
  ArticleDetailContentWidget(this.articleContentList);

  final articleContentList;

  @override
  Widget build(BuildContext context) {
    final itemTypeList = ArticleItemType.values;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics: NeverScrollableScrollPhysics(),
        itemCount: articleContentList.length,
        itemBuilder: (context, index) {
          ArticleDetailContentItem item = articleContentList[index];
          switch (itemTypeList[int.parse(item.type)]) {
            case ArticleItemType.NONE:
              return Padding(padding: const EdgeInsets.all(0),);
              break;
            case ArticleItemType.TEXT:
              return _buildText(item.info);
              break;
            case ArticleItemType.IMAGE:
              return _buildImage(item.info);
              break;
            case ArticleItemType.VIDEO:
              return _buildVideo(item.info);
              break;
            case ArticleItemType.H1:
              return _buildH1(item.info);
              break;
            case ArticleItemType.H2:
              return _buildH2(item.info);
              break;
            case ArticleItemType.LI:
              return _buildLi(item.info);
              break;
            case ArticleItemType.TEXT_CENTER:
              return _buildTextCenter(item.info);
              break;
            case ArticleItemType.QUOTE:
              return _buildQuote(item.info);
              break;
            case ArticleItemType.H3:
              return _buildH3(item.info);
              break;
            case ArticleItemType.ITALIC:
              return _buildItalic(item.info);
              break;
          }
          return Padding(padding: const EdgeInsets.all(0),);
        },
      ),
    );
  }

  Widget _buildH1(String info) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Text(
        info,
        style: TextStyle(
          letterSpacing: 1,
          wordSpacing: 1,
          fontSize: 20,
          height: 1.5,
          color: Colors.black
        ),
      ),
    );
  }

  Widget _buildH2(String info) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Text(
        info,
        style: TextStyle(
          letterSpacing: 0.8,
          wordSpacing: 0.8,
          fontSize: 18,
          height: 1.3,
          color: Colors.black87
        ),
      ),
    );
  }

  Widget _buildH3(String info) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        info,
        style: TextStyle(
          letterSpacing: 0.5,
          wordSpacing: 0.5,
          fontSize: 16,
          height: 1.2,
          color: Colors.black87
        ),
      ),
    );
  }

  Widget _buildText(String info) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        info,
        style: TextStyle(
          fontSize: 15,
          height: 1.6,
          color: Colors.black54
        ),
      ),
    );
  }

  Widget _buildImage(String info) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      width: double.infinity,
      child: Image.network(info, fit: BoxFit.cover,),
    );
  }

  Widget _buildVideo(String info) {
    return Padding(
      padding: const EdgeInsets.all(0),
    );
  }

  Widget _buildLi(String info) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(width: 0.5, color: Colors.blueGrey,)
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Text(
              info,
              style: TextStyle(
                fontSize: 14,
                height: 1.5,
                color: Colors.black45
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTextCenter(String info) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      alignment: Alignment.center,
      child: Text(
        info,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 13,
          color: Colors.grey
        ),
      ),
    );
  }

  Widget _buildQuote(String info) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      alignment: Alignment.centerLeft,
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(
              width: 6,
              height: double.infinity,
              child: DecoratedBox(
                 decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.blueGrey
                ),
              )
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Text(
                  info,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black38,
                  ),
                ),
              ),
            ),
          ],
        ),
      )
    );
  }

  Widget _buildItalic(String info) {

  }
}
