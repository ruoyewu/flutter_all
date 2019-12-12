import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HeartLoadingPage extends StatelessWidget {
  HeartLoadingPage(
      {this.size = const Size(50, 50),
      this.color = Colors.blueGrey,
      this.duration = const Duration(seconds: 1)});

  Size size;
  Color color;
  Duration duration;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: HeartLoading(
        size: size,
        color: color,
        duration: duration,
      ),
    );
  }
}

class HeartLoadingBar extends StatelessWidget {
  HeartLoadingBar(
      {this.size = const Size(50, 50),
      this.color = Colors.blueGrey,
      this.duration = const Duration(seconds: 1),
      this.isLoading = true,
      this.title = '没有更多了...'});

  Size size;
  Color color;
  Duration duration;
  bool isLoading;
  String title;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: 50,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black12, width: 1),
        ),
        child: isLoading
            ? HeartLoading(
                size: size,
                color: color,
                duration: duration,
              )
            : Text(
                title,
                style: TextStyle(
                  fontSize: 15,
                  color: Color(0xFF787878),
                ),
              ));
  }
}

class HeartLoading extends StatefulWidget {
  HeartLoading(
      {this.size = const Size(50, 50),
      this.color = Colors.blueGrey,
      this.duration = const Duration(seconds: 1)});

  Size size;
  Color color;
  Duration duration;

  @override
  State<StatefulWidget> createState() {
    return _HeardLoadingState();
  }
}

class _HeardLoadingState extends State<HeartLoading>
    with SingleTickerProviderStateMixin {
  static const C = 0.551915024494;

  AnimationController _animationController;
  _Point _center;
  Paint _painter;

  List<_Pair> _data = List(8);
  List<_Pair> _ctrl = List(16);
  List<double> _curData = List(8);
  List<double> _curCtrl = List(16);

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(duration: widget.duration, vsync: this);
    _animationController.addListener(() {
      setState(() {
        final value = Curves.decelerate.transform(_animationController.value);
        for (int i = 0; i < _data.length; i++) {
          _curData[i] = _data[i].from + value * (_data[i].to - _data[i].from);
        }
        for (int i = 0; i < _ctrl.length; i++) {
          _curCtrl[i] = _ctrl[i].from + value * (_ctrl[i].to - _ctrl[i].from);
        }
      });
    });
    _animationController.repeat(reverse: true);
    _initSize();
  }

  @override
  void dispose() {
    _animationController.stop();
    _animationController.dispose();
    super.dispose();
  }

  _initSize() {
    final w = widget.size.width;
    final h = widget.size.height;
    _center = _Point(w / 2, h / 2);
    _initDraw();
  }

  _initDraw() {
    _painter = Paint()
      ..style = PaintingStyle.fill
      ..isAntiAlias = true
      ..color = widget.color;

    final radius = _center.x;
    final difference = radius * C;
    final step = radius / 10;

    _data[0] = _Pair(0, 0);
    _data[1] = _Pair(radius, radius - step * 7);
    _data[2] = _Pair(radius, radius);
    _data[3] = _Pair(0, 0);
    _data[4] = _Pair(0, 0);
    _data[5] = _Pair(-radius, -radius);
    _data[6] = _Pair(-radius, -radius);
    _data[7] = _Pair(0, 0);

    _ctrl[0] = _Pair(_data[0].from + difference, _data[0].to + difference);
    _ctrl[1] = _Pair(_data[1].from, _data[1].from);
    _ctrl[2] = _Pair(_data[2].from, _data[2].to);
    _ctrl[3] = _Pair(_data[3].from + difference, _data[3].to + difference);
    _ctrl[4] = _Pair(_data[2].from, _data[2].to - step);
    _ctrl[5] = _Pair(_data[3].from - difference, _data[3].to - difference);
    _ctrl[6] = _Pair(_data[4].from + difference, _data[4].to + difference);
    _ctrl[7] = _Pair(_data[5].from, _data[5].to + step * 5);
    _ctrl[8] = _Pair(_data[4].from - difference, _data[4].to - difference);
    _ctrl[9] = _Pair(_data[5].from, _data[5].to + step * 5);
    _ctrl[10] = _Pair(_data[6].from, _data[6].to + step);
    _ctrl[11] = _Pair(_data[7].from - difference, _data[7].to - difference);
    _ctrl[12] = _Pair(_data[6].from, _data[6].to);
    _ctrl[13] = _Pair(_data[7].from + difference, _data[7].to + difference);
    _ctrl[14] = _Pair(_data[0].from - difference, _data[0].to - difference);
    _ctrl[15] = _Pair(_data[1].from, _data[1].from);
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _HeartLoadingPainter(_painter, _center, _curData, _curCtrl),
      isComplex: true,
      willChange: true,
      size: widget.size,
    );
  }
}

class _HeartLoadingPainter extends CustomPainter {
  _HeartLoadingPainter(this.painter, this.center, this.data, this.ctrl);

  _Point center;
  Paint painter;
  List<double> data;
  List<double> ctrl;

  update(_Point center, Paint paint, List<double> data, List<double> ctrl) {
    this.center = center;
    this.painter = paint;
    this.data = data;
    this.ctrl = ctrl;
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(center.x, center.y);
    canvas.scale(1, -1);

    final path = Path();
    path.moveTo(data[0], data[1]);

    path.cubicTo(ctrl[0], ctrl[1], ctrl[2], ctrl[3], data[2], data[3]);
    path.cubicTo(ctrl[4], ctrl[5], ctrl[6], ctrl[7], data[4], data[5]);
    path.cubicTo(ctrl[8], ctrl[9], ctrl[10], ctrl[11], data[6], data[7]);
    path.cubicTo(ctrl[12], ctrl[13], ctrl[14], ctrl[15], data[0], data[1]);

    canvas.drawPath(path, painter);
  }

  @override
  bool shouldRepaint(_HeartLoadingPainter oldDelegate) {
    return true;
  }
}

class _Pair {
  _Pair(this.from, this.to);

  double from;
  double to;
}

class _Point {
  _Point(this.x, this.y);

  double x;
  double y;

  @override
  bool operator ==(other) {
    return this.x == other.x && this.y == other.y;
  }

  @override
  int get hashCode => x.hashCode + y.hashCode;
}
