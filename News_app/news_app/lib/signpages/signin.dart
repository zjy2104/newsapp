import 'package:flutter/material.dart';
import 'package:news_app/api/news.dart';
import 'package:news_app/api/const.dart';
import 'package:news_app/ui/widgets/custom_shape.dart';
import 'package:news_app/ui/widgets/responsive_ui.dart';
//import 'package:flutter_news/ui/widgets/textformfield.dart';
import 'package:dio/dio.dart';
import 'dart:io';
import 'package:news_app/signpages/person.dart';
import 'package:news_app/api/url.dart';
import 'package:news_app/ui/widgets/loading.dart';
import 'package:shared_preferences/shared_preferences.dart';

String res;
String nnn;

class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SignInScreen(storage: InfoStorage()),
    );
  }
}

class SignInScreen extends StatefulWidget {
  final InfoStorage storage;
  SignInScreen({this.storage}):super();
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  String _info;
  String _in;
  double _height;
  double _width;
  double _pixelRatio;
  bool _large;
  bool _medium;
  final myid = TextEditingController();
  final mypassword = TextEditingController();

  GlobalKey<FormState> _key = GlobalKey();
  //final myname = TextEditingController();
  //final myphon = TextEditingController();
  //final myword = TextEditingController();

/*
  @override
  void initState(){
    super.initState();

    widget.storage.readInfo().then((String zzz){
      setState((){
        _in=zzz;
        print(_in);
      });
    });

  }
  */




  Future<File> _saveInfo() async{
    return widget.storage.writeInfo(_info);
  }

  loadLoginByDio() async {
    try {
      var name=myid.text;
      var word=mypassword.text;
      nnn=name;
      _info=nnn;
      _saveInfo();
      //writeInfo(nnn);
      print('登陆中');
      Response response;
      Dio dio = new Dio();
      response = await dio.get(
          "http://192.168.0.14:8000/login/?&usernames=$name&id=5&okword=$word");
      res=response.data;
      //print(res);
      //"http://192.168.1.6:8000/sign/?usernames=ikl&phonenum=123456&id=5&okword=zdfdf");
      //"http://192.168.1.6:8000/sign/", data: {"username":'zidl', "phonenum": '74512', "id": '7'});
      if (response.statusCode == 200) {

        //print(name);
      } else {
        //#_result = 'error code : ${response.statusCode}';
        print("失败");
      }
    } catch (HttpResponse) {
      print('exc:$HttpResponse');
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
     _height = MediaQuery.of(context).size.height;
     _width = MediaQuery.of(context).size.width;
     _pixelRatio = MediaQuery.of(context).devicePixelRatio;
     _large =  ResponsiveWidget.isScreenLarge(_width, _pixelRatio);
     _medium =  ResponsiveWidget.isScreenMedium(_width, _pixelRatio);
     if(_in!=null)
       {
         print("go");
         //MaterialPageRoute(builder: (context) => Userpage());
         //Navigator.pushNamed(USER_OK);
       }
    return Material(
      child: Container(
        height: _height,
        width: _width,
        padding: EdgeInsets.only(bottom: 5),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              clipShape(),
              welcomeTextRow(),
              //signInTextRow(),
              form(),
              forgetPassTextRow(),
              SizedBox(height: _height / 12),
              button(context),
              signUpTextRow(),
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

  Widget welcomeTextRow() {
    return Container(
      margin: EdgeInsets.only(left: _width / 20, top: _height / 800),
      child: Row(
        children: <Widget>[
          Text(
            "Welcome",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: _large? 60 : (_medium? 50 : 40),
            ),
          ),
        ],
      ),
    );
  }

  /*
  Widget signInTextRow() {
    return Container(
      margin: EdgeInsets.only(left: _width / 15.0),
      child: Row(
        children: <Widget>[
          Text(
            "Sign in to your account",
            style: TextStyle(
              fontWeight: FontWeight.w200,
              fontSize: _large? 20 : (_medium? 17.5 : 15),
            ),
          ),
        ],
      ),
    );
  }
*/
  Widget form() {
    return Container(
      margin: EdgeInsets.only(
          left: _width / 12.0,
          right: _width / 12.0,
          top: _height / 15.0),
      child: Form(
        key: _key,
        child: Column(
          children: <Widget>[
            emailTextFormField(),
            SizedBox(height: _height / 40.0),
            passwordTextFormField(),
          ],
        ),
      ),
    );
  }

  Widget emailTextFormField() {
    return TextField(
      keyboardType: TextInputType.text,
      controller: myid,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(10.0),
        icon: Icon(Icons.email),
        labelText: '昵称',
      ),
    );

  }

  Widget passwordTextFormField() {
    return TextField(
      keyboardType: TextInputType.visiblePassword,
      controller: mypassword,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(10.0),
        icon: Icon(Icons.lock),
        labelText: '密码',
      ),
    );
  }

  Widget forgetPassTextRow() {
    return Container(
      margin: EdgeInsets.only(top: _height / 40.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "忘记密码?",
            style: TextStyle(fontWeight: FontWeight.w400,fontSize: _large? 14: (_medium? 12: 10)),
          ),
          SizedBox(
            width: 5,
          ),
          GestureDetector(
            onTap: () {
              print("Routing");
            },
            child: Text(
              "找回密码",
              style: TextStyle(
                  fontWeight: FontWeight.w600, color: Colors.blue[200]),
            ),
          )
        ],
      ),
    );
  }

  Widget button(BuildContext context) {
    return RaisedButton(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      /*
      onPressed: () {
          print("Routing to your account");
          Scaffold
              .of(context)
              .showSnackBar(SnackBar(content: Text('Login Successful')));

      },
       */
      //onPressed: loadLoginByDio,
      onPressed: (){
        /*
        LoadingPage loadingPage = LoadingPage(context);
        loadingPage.show();
        Future.delayed(
            Duration(seconds: 3),
                () {
              loadingPage.close();
            },
        );

         */
        loadLoginByDio();

      },
      textColor: Colors.white,
      padding: EdgeInsets.all(0.0),
      child: Container(
        alignment: Alignment.center,
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
                if(res=='登陆成功')
                {
                  Navigator.of(context).pushNamed(USER_OK);
                  print("Routing to Sign up screen");

                }

                else{
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        // Retrieve the text the user has entered by using the
                        // TextEditingController.
                        content: Text(res),
                      );
                    },
                  );
                }


              },
              child: Text(
                "登录",
                  style: TextStyle(fontSize: _large? 14: (_medium? 12: 10))),
            )
          ],
        ) ,
      ),
    );
  }

  Widget signUpTextRow() {
    return Container(
      margin: EdgeInsets.only(top: _height / 120.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "没有账号?",
            style: TextStyle(fontWeight: FontWeight.w400,fontSize: _large? 14: (_medium? 12: 10)),
          ),
          SizedBox(
            width: 5,
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(SIGN_UP);
              print("Routing to Sign up screen");
            },
            child: Text(
              "注册",
              style: TextStyle(
                  fontWeight: FontWeight.w800, color: Colors.blue[200], fontSize: _large? 19: (_medium? 17: 15)),
            ),
          )
        ],
      ),
    );
  }

}
