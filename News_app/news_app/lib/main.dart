import 'package:flutter/material.dart';
import 'package:news_app/pages/Homebutton.dart';
import 'package:news_app/pages/Buttonbutton.dart';
import 'config.dart';
//import 'index.dart';

void main() => runApp(new FlutterNews());


class FlutterNews extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: Config.themeData,
      title: "News",
      home: BottomNavigationWidget(),
    );
  }
}