import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ImagePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ImageWidgetState();
  }
}

class _ImageWidgetState extends State<ImagePage>
    with SingleTickerProviderStateMixin {
  static const MAX_OFFSET = 80;

  PageController _pageController;
  List<String> _imageList;
  List<double> _imagePositionList;
  String _image;
  Function _scrollToPositionFunction;

  AnimationController _animationController;
  double _startTranslateY = 0;
  double _startOpacity = 0;
  double _translateY = 0;
  double _opacity = 1;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 200),
      vsync: this,
    );
    _animationController.addListener(() {
      setState(() {
        double value = _animationController.value;
        _translateY = _startTranslateY * (1 - value);
        _opacity = value * (1 - _startOpacity) + _startOpacity;
        log('animation value: $_opacity');
      });
    });
//    SystemChrome.setEnabledSystemUIOverlays([]);
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  double _abs(double value) {
    return value > 0 ? value : -value;
  }

  double _clip(double value, {double max = 1, double min = 0}) {
    if (value > max) {
      return max;
    } else if (value < min) {
      return min;
    }
    return value;
  }

  double computeTranslate(double translate, double delta) {
    double proportion = _clip(_abs(translate)/MAX_OFFSET);
    delta = delta * (1.1 - proportion * proportion);
    return translate + delta;
  }

  @override
  Widget build(BuildContext context) {
    Map arguments = ModalRoute.of(context).settings.arguments ?? Map();
    _imageList = arguments['imageList'] ?? List.from(['']);
    _image = arguments['image'] ?? '';
    _scrollToPositionFunction = arguments['scrollFunction'];
    _imagePositionList = arguments['position'];

    if (_pageController == null) {
      _pageController = PageController(initialPage: _imageList.indexOf(_image));
    }

//    PhotoViewGallery

    return Scaffold(
      backgroundColor: Colors.black.withOpacity(_opacity),
      body: GestureDetector(
        onVerticalDragUpdate: (details) {
          setState(() {
            _translateY = computeTranslate(_translateY, details.delta.dy);
            _opacity = 1 - _clip(_abs(_translateY) / MAX_OFFSET);
          });
        },
        onVerticalDragEnd: (details) {
          if (_abs(_translateY) > MAX_OFFSET) {
            Navigator.pop(context);
          } else {
            _startTranslateY = _translateY;
            _startOpacity = _opacity;
            _animationController.value = 0;
            _animationController.animateTo(1, curve: Curves.decelerate);
          }
        },
        onVerticalDragDown: (details) {
          _animationController.stop();
        },
        child: Transform.translate(
          offset: Offset(0, _translateY),
          child: PhotoViewGestureDetectorScope(
            axis: Axis.horizontal,
            child: PageView.builder(
                controller: _pageController,
                itemCount: _imageList.length,
                physics: BouncingScrollPhysics(),
                onPageChanged: (index) {
                  if (_imagePositionList != null &&
                      _scrollToPositionFunction != null) {
                    _scrollToPositionFunction(_imagePositionList[index]);
                  }
                },
                itemBuilder: (context, index) {
                  return ClipRect(
                    child: PhotoView(
                      backgroundDecoration: BoxDecoration(
                        color: Colors.transparent
                      ),
                      imageProvider: NetworkImage(_imageList[index]),
                      heroAttributes: PhotoViewHeroAttributes(
                        tag: _imageList[index]
                      ),
                      onTapUp: (context, details, _) {
                        Navigator.pop(context);
                      },
                    ),
                  );
                }),
          ),
        ),
      ),
    );
  }
}
