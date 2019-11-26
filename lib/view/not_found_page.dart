import 'package:flutter/material.dart';

class NotFoundPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("page not found"),
      ),
      body: Center(
        child: Text("no sush page,\n please ensure your route", style: TextStyle(fontSize: 20),),
      ),
    );
  }
}