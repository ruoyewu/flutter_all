import 'dart:developer';

import 'package:all/model/bean/qingmang_bean.dart';
import 'package:all/model/ui_data.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

typedef OnLinkPress = void Function(String url);
typedef OnImagePress = void Function(
    List<String> imageList, String image, List<double> imagePositionList);

class ArticleDetailContentWidget extends StatefulWidget {
  ArticleDetailContentWidget(this.articleContent,
      {this.onLinkPress, this.onImagePress});

  final articleContent;
  OnLinkPress onLinkPress;
  OnImagePress onImagePress;

  @override
  State<StatefulWidget> createState() {
    return _ArticleDetailContentState();
  }
}

class _ArticleDetailContentState extends State<ArticleDetailContentWidget> {
  Map<String, ChewieController> _controllerMap;
  List<String> _imageList;
  Map<String, GlobalKey> _imageKeyMap;
  GlobalKey _globalKey;

  @override
  void initState() {
    super.initState();
    _controllerMap = Map();
    _imageKeyMap = Map();
    _imageList = List();
    _globalKey = GlobalKey();
  }

  @override
  void dispose() {
    super.dispose();
    _controllerMap.forEach((key, value) {
      value.videoPlayerController.dispose();
      value.dispose();
    });
    _controllerMap.clear();
    _imageKeyMap.forEach((key, value) {
      value = null;
    });
    _imageKeyMap.clear();
  }

  onImageTap(String image) {
    if (widget.onImagePress != null) {
      widget.onImagePress(
          _imageList,
          image,
          _imageList
              .map((image) => (_imageKeyMap[image]
                      .currentContext
                      .findRenderObject() as RenderBox)
                  .localToGlobal(Offset(0, 0),
                      ancestor: _globalKey.currentContext.findRenderObject())
                  .dy)
              .toList());
    }
  }

  @override
  Widget build(BuildContext context) {
    _imageList.clear();

    List<Widget> children = List();
    for (ArticleContentItem item in widget.articleContent) {
      children.add(_buildItem(item));
    }

    return Column(
      key: _globalKey,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    );
  }

  Widget _buildItem(ArticleContentItem item) {
//    log('build item: ${item.toJson()}');
    final type = item.type;
    switch (type) {
      case 0:
        return _buildText(item);
      case 1:
        return _buildImage(item);
        break;
      case 2:
        final video = item.media;
        return _buildVideo(video.source, video.cover, video.title);
        break;
      case 3:
        break;
    }
    log('not found type: ${item.type}');
    return Container();
  }

  Widget _buildText(ArticleContentItem item) {
    List<InlineSpan> children = List();
    final text = item.text.text;
    if (item.text.lineType != null) {
      switch (item.text.lineType) {
        case 'h2':
          children.add(_buildH2(text));
          break;
        case 'h3':
          children.add(_buildH3(text));
          break;
        case 'aside':
          children.add(_buildAside(text));
          break;
        default:
          log('not found lineType: ${item.text.lineType}');
      }
    } else if (item.text.markups != null) {
      int cur = 0;
      for (Markup markup in item.text.markups) {
        if (markup.start > cur) {
          children.add(_buildNormalText(text.substring(cur, markup.start)));
        }
        switch (markup.tag) {
          case 'a':
            children.add(_buildLink(
                text.substring(markup.start, markup.end), markup.source));
            break;
          case 'strong':
            children.add(_buildBold(text.substring(markup.start, markup.end)));
            break;
          case 'img':
            children.add(
                _buildImageSpan(markup.source, markup.width, markup.height));
            break;
          default:
            log('not found markup tag: ${markup.tag}');
        }
        cur = markup.end;
      }

      if (cur < text.length - 1) {
        children.add(_buildNormalText(text.substring(cur, text.length)));
      }
    } else {
      children.add(_buildNormalText(text));
    }

    Widget result = Text.rich(TextSpan(
      children: children,
    ));

    if (item.text.lineType != null && item.text.lineType == 'aside') {
      result = Align(
        alignment: Alignment.center,
        child: result,
      );
    }

    if (item.li != null) {
      result = _buildLi(result);
    }

    if (item.blockQuote != null && item.blockQuote == 1) {
      result = _buildQuote(result);
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      child: result,
    );
  }

  InlineSpan _buildNormalText(String info) {
    return TextSpan(
        text: info,
        style: TextStyle(
          fontSize: 17,
          height: 1.5,
          color: Colors.black87,
        ));
  }

  InlineSpan _buildH2(String info) {
    return TextSpan(
        text: info,
        style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Colors.black,
            height: 1.8));
  }

  InlineSpan _buildH3(String info) {
    return TextSpan(
        text: info,
        style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black,
            height: 1.7));
  }

  InlineSpan _buildAside(String info) {
    return TextSpan(
        text: info,
        style: TextStyle(color: UIData.COLOR_MONSOON, fontSize: 16));
  }

  InlineSpan _buildBold(String info) {
    return TextSpan(
        text: info,
        style: TextStyle(
            fontSize: 17, fontWeight: FontWeight.w600, color: Colors.black87));
  }

  InlineSpan _buildLink(String info, String url) {
    return TextSpan(
        text: info,
        style: TextStyle(
            fontSize: 16,
            color: UIData.COLOR_MOUNTAIN_MIST,
            fontWeight: FontWeight.bold,
            decoration: TextDecoration.underline,
            decorationColor: UIData.COLOR_MOUNTAIN_MIST),
        recognizer: TapGestureRecognizer()
          ..onTap = () {
            if (widget.onLinkPress != null) {
              widget.onLinkPress(url);
            }
          });
  }

  InlineSpan _buildImageSpan(String url, int width, int height) {
    _imageList.add(url);
    final tag = url + _imageList.length.toString();
    final key = _imageKeyMap.containsKey(tag)
        ? _imageKeyMap[tag]
        : GlobalObjectKey(tag);
    _imageKeyMap[url] = key;

    return WidgetSpan(
        child: GestureDetector(
            key: key,
            onTap: () => onImageTap(url),
            child: Hero(
                tag: tag,
                child: Image.network(
                  url,
                  height: height.toDouble(),
                  width: width.toDouble(),
                ))));
  }

  Widget _buildImage(ArticleContentItem item) {
    final image = item.image.source;
    _imageList.add(image);
    final tag = image + _imageList.length.toString();
    final key = _imageKeyMap.containsKey(tag)
        ? _imageKeyMap[tag]
        : GlobalObjectKey(tag);
    _imageKeyMap[image] = key;
    if (item.image.isInline != null && item.image.isInline) {
      log("build inline image");
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
      );
    } else {
      return Padding(
        key: key,
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: GestureDetector(
          onTap: () => onImageTap(image),
          child: SizedBox(
            width: double.infinity,
            child: Hero(
              tag: tag,
              child: Image.network(
                image,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      );
    }
  }

  Widget _buildVideo(String url, String cover, String title) {
    var videoUrl = url.substring(url.lastIndexOf('http'));
    log('video url is: $videoUrl, url is: $url');
//    videoUrl = 'https://v.qq.com/iframe/preview.html?width=500&height=375&auto=0&vid=t0507oeieo3';

    return Chewie(
      controller: _genController(url, cover),
    );
  }

  Widget _buildLi(Widget widget) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  width: 2,
                  color: Colors.blueGrey,
                )),
          ),
        ),
        Expanded(
          child:
              Padding(padding: const EdgeInsets.only(left: 8), child: widget),
        )
      ],
    );
  }

  Widget _buildQuote(Widget widget) {
    return Container(
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
                        shape: BoxShape.rectangle, color: Colors.blueGrey),
                  )),
              Expanded(
                child: Padding(
                    padding: const EdgeInsets.only(left: 8), child: widget),
              ),
            ],
          ),
        ));
  }

  ChewieController _genController(String url, String cover) {
    if (_controllerMap.containsKey(url)) {
      return _controllerMap[url];
    } else {
      double ratio;
      try {
        List<String> ls = cover.split('_');
        int len = ls.length;
        int height = int.parse(ls[len - 1].split('.')[0]);
        int width = int.parse(ls[len - 2]);
        ratio = width / height;
      } catch (e) {
        ratio = 16 / 9;
      }
      ChewieController controller = ChewieController(
        videoPlayerController: VideoPlayerController.network(url),
        placeholder: SizedBox(
            width: double.infinity,
            child: Image.network(
              cover,
              fit: BoxFit.cover,
            )),
        aspectRatio: ratio,
        autoInitialize: true,
        allowMuting: false,
      );
      _controllerMap[url] = controller;
      return controller;
    }
  }
}
