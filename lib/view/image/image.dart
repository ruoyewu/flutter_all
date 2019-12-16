import 'dart:developer';

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
  String _suffix;
  Function _scrollToPositionFunction;

  AnimationController _animationController;
  double _dragStartX = 0;
  double _startTranslateY = 0;
  double _startTranslateX = 0;
  double _startOpacity = 0;
  double _translateY = 0;
  double _translateX = 0;
  double _opacity = 1;
  double _scale = 1;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 200),
      vsync: this,
    );
    _animationController.addListener(() {
      setState(() {
        _onValueChanged(_animationController.value);
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  void _onValueChanged(double value) {
    _translateY = _startTranslateY * (1 - value);
    _translateX = _startTranslateX * (1 - value);
    _opacity = (value * (1 - _startOpacity) + _startOpacity + 0.2).clamp(0, 1).toDouble();
    _scale = _opacity / 4 + 0.75;
  }

  double _computeTranslate(double translate, double delta) {
    double proportion = (translate.abs()/MAX_OFFSET).clamp(0, 1).toDouble();
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
    _suffix = arguments['suffix']?? '';

    if (_pageController == null) {
      _pageController = PageController(initialPage: _imageList.indexOf(_image));
    }
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(_opacity),
      body: GestureDetector(
        onVerticalDragStart: (details) {
          _dragStartX = details.globalPosition.dx;
        },
        onVerticalDragUpdate: (details) {
          setState(() {
            _translateY = _computeTranslate(_translateY, details.delta.dy);
            _translateX = details.localPosition.dx - _dragStartX;
            _opacity = (1.2 - (_translateY.abs() / MAX_OFFSET).clamp(0, 1)).clamp(0, 1).toDouble();
            _scale = _opacity / 4 + 0.75;
          });
        },
        onLongPressMoveUpdate: (details) {
          log('${details.localPosition.dx}');
        },
        onPanUpdate: (details) {
          log('${details.localPosition.dx}');
        },
        onVerticalDragEnd: (details) {
          if (_translateY.abs() > MAX_OFFSET) {
            Navigator.pop(context);
          } else {
            _startTranslateY = _translateY;
            _startTranslateX = _translateX;
            _startOpacity = _opacity;
            _animationController.value = 0;
            _animationController.animateTo(1, curve: Curves.decelerate);
          }
        },
        onVerticalDragDown: (details) {
          _animationController.stop();
        },
        child: Transform.scale(
          scale: _scale,
          child: Transform.translate(
            offset: Offset(_translateX, _translateY),
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
                          tag: '${_imageList[index]}_${index}_${_suffix}',
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
      ),
    );
  }
}
