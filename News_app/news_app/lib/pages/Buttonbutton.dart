import 'package:flutter/material.dart';
//import 'package:flutter_news/pages/AboutPage.dart';
import 'package:news_app/pages/HomePage.dart';
import 'package:news_app/pages/category.dart';
import 'package:news_app/pages/sign.dart';


class BottomNavigationWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => BottomNavigationWidgetState();
}

class BottomNavigationWidgetState extends State<BottomNavigationWidget> {
  final _bottomNavigationColor = Colors.blue;
  int _currentIndex = 0;
  List<Widget> list = List();

  @override
  void initState() {
    list
      ..add(HomePage())
      //..add(Category())
      ..add(Sign());
      //..add(AboutPage());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: list[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: _bottomNavigationColor,
              ),
              title: Text(
                '首页',
                style: TextStyle(color: _bottomNavigationColor),
              )),
          /*
          BottomNavigationBarItem(
              icon: Icon(
                Icons.category,
                color: _bottomNavigationColor,
              ),
              title: Text(
                '分类',
                style: TextStyle(color: _bottomNavigationColor),
              )),

           */
          BottomNavigationBarItem(
              icon: Icon(
                Icons.account_circle,
                color: _bottomNavigationColor,
              ),
              title: Text(
                '关于',
                style: TextStyle(color: _bottomNavigationColor),
              )),
        ],
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.shifting,
      ),
    );
  }
}