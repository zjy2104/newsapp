import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:news_app/signpages/signin.dart';
import 'package:http/http.dart' as http;
import 'news.dart';
import 'comment.dart';
//import 'package:flutter_news/widgets/NewsListWidget.dart';
import 'package:path_provider/path_provider.dart';


String phone;
List<news> lvdate;
List<news> newdate;
int tlength;
List<Comment> commdate;
//int zzz=num;
int number;

Future<news> fetchPost(int newid) async{
  //Utf8Decoder decode = new Utf8Decoder();
  final response = await http.get('http://192.168.0.14:8000/news/?search=$newid');
  final data=json.decode(response.body);
  tlength=data.length;
  var i=0;
  news rep;
  lvdate=List<news>();
  for(i=0;i<tlength;i++)
    {
      lvdate.add(news.fromJson(data[i]));
    }
  final responsenew = await http.get('http://192.168.0.14:8000/news/');
  final datanew=json.decode(responsenew.body);
  //tlength=datanew.length;
  i=0;
  newdate=List<news>();
  for(i=0;i<tlength;i++)
  {
    newdate.add(news.fromJson(datanew[i]));
  }
  return rep;
  //}
}

Future<Comment> catchcomm(int num) async{

  //int commentbody;
  int commentid=lvdate[num].count;
  final response = await http.get('http://192.168.0.14:8000/comment/?search=$commentid');
  final data=json.decode(response.body);

  number=data.length;
  //print(commentbody);
 // number=commentbody;
  var i=0;
  Comment rep;
  commdate=List<Comment>();
  for(i=0;i<number;i++)
  {
    commdate.add(Comment.fromJson(data[i]));
  }
  //print(commdate[0].nameId);
  print("yes");

  print(commdate.length);
  print("yes");
  return rep;
  //}
}





Future<String> getphone(String nameuser) async {
  try {
    print('登陆中');
    Response response;
    Dio dio = new Dio();
    response = await dio.get(
        "http://192.168.0.14:8000/person/?&usernames=$nnn");
    phone=response.data;
    print(phone);
    //"http://192.168.1.6:8000/sign/?usernames=ikl&phonenum=123456&id=5&okword=zdfdf");
    //"http://192.168.1.6:8000/sign/", data: {"username":'zidl', "phonenum": '74512', "id": '7'});
    if (response.statusCode == 200) {

      print("成功");
    } else {
      //#_result = 'error code : ${response.statusCode}';
      print("失败");
    }
  } catch (HttpResponse) {
    print('exc:$HttpResponse');
  }
  //setState(() {});
}





class InfoStorage{
  Future<String> get _localPath async{
    final directory=await getApplicationDocumentsDirectory();
    return directory.path;
  }
  Future<File> get _localFile async{
    final path=await _localPath;
    return File('$path/111.txt');
  }
  Future<File> writeInfo(String info) async{
    final file=await _localFile;
    print("ok");
    return file.writeAsString(info);
  }
  Future<String> readInfo() async{
    try{
      final file=await _localFile;
      print(file);
      String info=await file.readAsStringSync();
      print(info);
      print("111");
      return info;
    }catch(e){
      print("error");
      return null;
    }
  }
  Future<String> ClearInfo() async{
    final file=await _localFile;
    await file.delete();
    print("ok");
    return "ok";
  }
}


