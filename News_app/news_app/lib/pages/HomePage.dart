import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:news_app/newspages/newslist1.dart';
import 'package:news_app/newspages/newlist2.dart';
import 'package:news_app/newspages/newslist3.dart';


int newid;
class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  TabController _tabController;
  int new_num;


  @override
  void initState(){  //生命周期函数：
    super.initState();
    _tabController=new TabController(
        vsync: this,
        length: 3
    );
    _tabController.addListener((){
      new_num=_tabController.index;
      //print(_tabController.index);
    });
  }

  @override
  dispose() {
    _tabController.dispose();
    super.dispose();
  }

  //初始化列表内容
  Widget _initChannelList() {
    int i=_tabController.index;
    newid=i;
    print(_tabController.index);
    return TabBarView(
      controller: _tabController,
      children: [
        NewsListWidget1(),
        NewsListWidget2(),
        NewsListWidget3(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      //length: channels.length,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          //leading: Icon(Icons.title),
          title: Text("ONE NEWS",
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.center,),
          //bottom: _initChannelTitle(),
          bottom: TabBar(
            controller:this._tabController,
            tabs: <Widget>[
              Tab(text: '头条'),
              Tab(text: '财经'),
              Tab(text: '体育'),
            ],
          ),
          /*
          actions: <Widget>[

            IconButton(
                icon: Icon(Icons.brightness_4),
                onPressed: (() {
                  Constants.eventBus.fire(
                      Constants.currentTheme == Constants.dayTheme
                          ? ThemeEvent(Constants.nightTheme)
                          : ThemeEvent(Constants.dayTheme));
                }))
          ],
          */
        ),
        body: _initChannelList(),
      ),
    );
  }
  @override
  bool get wantKeepAlive => true;
}