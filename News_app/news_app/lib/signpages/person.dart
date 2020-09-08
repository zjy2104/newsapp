import 'package:flutter/material.dart';
import 'package:news_app/api/url.dart';
import 'package:news_app/api/const.dart';
import 'package:news_app/ui/widgets/custom_shape.dart';
import 'package:news_app/ui/widgets/responsive_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
import 'dart:io';


String nameuser;
class Userpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SignInScreen(storage: InfoStorage()),
    );
  }
}

class SignInScreen  extends StatefulWidget {
  final InfoStorage storage;
  SignInScreen ({this.storage}):super();
  @override
  _SignInScreenState createState() => _SignInScreenState(getp:getphone(nameuser));
}

class _SignInScreenState extends State<SignInScreen > {
  Future<String> getp;
  //String nameuser;
  String _info;
  double _height;
  double _width;
  double _pixelRatio;
  bool _large;
  bool _medium;
  _SignInScreenState({Key key, this.getp});
  final myid = TextEditingController();
  final mypassword = TextEditingController();
  GlobalKey<FormState> _key = GlobalKey();


  @override
  void initState(){
    super.initState();
    widget.storage.readInfo().then((String zzz){
      setState((){
        _info=zzz;
      });
    });
  }

  void _increase() async{
    SharedPreferences prefs=await SharedPreferences.getInstance();
    setState(() {

    });
    await prefs.setString('userphone',phone);
    await prefs.setString('username',nameuser);
  }
  void clean() async{
    SharedPreferences prefs=await SharedPreferences.getInstance();
    prefs.remove('userphone');
    prefs.remove('username');
  }




  Future<String> _clear() async{
    return widget.storage.ClearInfo();
  }


  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    _pixelRatio = MediaQuery.of(context).devicePixelRatio;
    _large =  ResponsiveWidget.isScreenLarge(_width, _pixelRatio);
    _medium =  ResponsiveWidget.isScreenMedium(_width, _pixelRatio);
    nameuser=_info;
    _increase();
    return Material(
      child: Container(
        height: _height,
        width: _width,
        padding: EdgeInsets.only(bottom: 5),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              clipShape(),
              message(),
              SizedBox(height: _height / 8),
              Out(),
            ],
          ),
        ),
      ),
    );
  }

  Widget clipShape() {
    //double height = MediaQuery.of(context).size.height;
    return Stack(
      children: <Widget>[
        Opacity(
          opacity: 0.75,
          child: ClipPath(
            clipper: CustomShapeClipper(),
            child: Container(
              height:_large? _height/4 : (_medium? _height/3.75 : _height/3.5),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue[200], Colors.pinkAccent],
                ),
              ),
            ),
          ),
        ),
        Opacity(
          opacity: 0.5,
          child: ClipPath(
            clipper: CustomShapeClipper2(),
            child: Container(
              height: _large? _height/4.5 : (_medium? _height/4.25 : _height/4),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue[200], Colors.pinkAccent],
                ),
              ),
            ),
          ),
        ),
        Container(
          alignment: Alignment.bottomCenter,
          margin: EdgeInsets.only(top: _large? _height/30 : (_medium? _height/25 : _height/20)),
          child: Image.asset(
            'assets/images/login.png',
            height: _height/3.5,
            width: _width/3.5,
          ),
        ),
      ],
    );
  }
  Widget message(){
    return Container(
      child: new SizedBox(
        height: 210.0,  //设置高度
        child: new Card(
          elevation: 15.0,  //设置阴影
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(14.0))),  //设置圆角
          child: new Column(  // card只能有一个widget，但这个widget内容可以包含其他的widget
            children: [
              new ListTile(
                title: new Text(nameuser,
                    style: new TextStyle(fontWeight: FontWeight.w500)),
                //subtitle: new Text('161710128'),
                leading: new Icon(
                  Icons.restaurant_menu,
                  color: Colors.blue[500],
                ),
              ),
              new Divider(),
              new ListTile(
                title: new Text('手机号：'+phone,
                    style: new TextStyle(fontWeight: FontWeight.w500)),
                leading: new Icon(
                  Icons.contact_phone,
                  color: Colors.blue[500],
                ),
              ),
              new ListTile(
                title: new Text('每日一句：To be or not to be!'),
                leading: new Icon(
                  Icons.contact_mail,
                  color: Colors.blue[500],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget Out() {
    return RaisedButton(

      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      textColor: Colors.white,
      padding: EdgeInsets.all(0.0),
      child: Container(
        alignment: Alignment.center,
        //margin: EdgeInsets.only(top: _height / 5.0),
        width: _large? _width/4 : (_medium? _width/3.75: _width/3.5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          gradient: LinearGradient(
            colors: <Color>[Colors.blue[200], Colors.pinkAccent],
          ),
        ),
        padding: const EdgeInsets.all(12.0),
        //child: Text('登录',style: TextStyle(fontSize: _large? 14: (_medium? 12: 10))),
        child:Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                clean();
                Navigator.of(context).pushNamed(SIGN_IN);
                print("Routing to Sign up screen");
              },
              child: Text(
                  "退出登录",
                  style: TextStyle(fontSize: _large? 14: (_medium? 12: 10))),
            )
          ],
        ) ,
      ),
    );
  }
}