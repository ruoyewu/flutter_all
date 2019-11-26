import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class ProviderConsumer<T extends ChangeNotifier> extends StatelessWidget {
  T _value;
  final Widget Function(BuildContext context, T value, Widget child) _builder;
  ProviderConsumer(this._value, this._builder);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>.value(
      value: _value,
      child: Consumer<T>(
        builder: _builder,
      ),
    );
  }
}

class ProviderConsumer2<T1 extends ChangeNotifier, T2 extends ChangeNotifier> extends StatelessWidget {
  T1 _value1;
  T2 _value2;
  final Widget Function(BuildContext context, T1 value1, T2 value2, Widget child) _builder;
  ProviderConsumer2(this._value1, this._value2, this._builder);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T1>.value(
      value: _value1,
      child: ChangeNotifierProvider<T2>.value(
        value: _value2,
        child: Consumer2<T1, T2>(
          builder: _builder,
        ),
      ),
    );
  }
}