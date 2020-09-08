import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:news_app/signpages/signin.dart';
import 'package:news_app/api/url.dart';
import 'package:news_app/signpages/person.dart';
import 'package:news_app/api/const.dart';
import 'package:news_app/signpages/signup.dart';
import 'package:shared_preferences/shared_preferences.dart';



String usename;
class Sign extends StatefulWidget{
  final InfoStorage storage;
  Sign({this.storage}):super();
  @override
  ok createState() => ok();
}

class ok extends State<Sign> {
  String rrr;
  int i=2;
  String _phone;
  String _info;
  List<String> page=[USER_OK,SIGN_UP,SIGN_IN];

  @override
  void initState(){
    super.initState();
    _getphone();
  }
  _getphone() async{
    SharedPreferences prefs=await SharedPreferences.getInstance();
    setState(() {
      _phone=prefs.get('userphone');
      usename=prefs.get('username');
    });
  }


  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    print(usename);
  if(usename!=null)
    {
      rrr='USER_OK';
      i=0;
    }
    if(usename==null)
    {
      rrr='SIGN_IN';
      i=2;
    }
  print(page[i]);


  //print(rrr);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Login",
      theme: ThemeData(primaryColor: Colors.blue[200]),
      routes: <String, WidgetBuilder>{
        //SPLASH_SCREEN: (BuildContext context) =>  SplashScreen(),

        SIGN_IN: (BuildContext context) =>  SignInPage(),
        SIGN_UP: (BuildContext context) =>  SignUpScreen(),
        USER_OK:(BuildContext context) =>  Userpage(),
      },
      initialRoute: page[i],


    );
  }
}