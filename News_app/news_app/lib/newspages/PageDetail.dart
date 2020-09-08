import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/main.dart';
import 'package:news_app/modules/common/CommonText.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html/dom.dart' as dom;
import 'package:dio/dio.dart';
import 'package:news_app/api/comment.dart';
import 'package:news_app/pages/sign.dart';
import 'package:news_app/api/url.dart';
import 'package:news_app/api/const.dart';

//import 'package:flutter_news/modules/ModelPageData.dart';

/// 资讯详情页


class PageDetail extends StatefulWidget {

  //final dynamic requestParams;
  //final String site;

  final int num;
  PageDetail(this.num) : super();

  _PageDetailState createState() => _PageDetailState(num,comment:catchcomm(num));
}


class _PageDetailState extends State<PageDetail>{

  int index;
  Future<Comment> comment;
  _PageDetailState(this.index,{this.comment}): super();
  //final int num;
  //int index=num;
  //int commentcount=commdate.length;

  int commentcount=number;
  final commenttext = TextEditingController();
  loadDataByDio() async {
    try {
      var text=commenttext.text;
      print(lvdate[index].count);
      int new_id=lvdate[index].count;
      print('注册中');
      Response response;
      Dio dio = new Dio();
      response = await dio.get(
          "http://192.168.0.14:8000/commentadd/?&comment=$text&name_id=$usename&count=$new_id");
      //"http://192.168.1.6:8000/sign/?usernames=ikl&phonenum=123456&id=5&okword=zdfdf");
      //"http://192.168.1.6:8000/sign/", data: {"username":'zidl', "phonenum": '74512', "id": '7'});
      if (response.statusCode == 200) {

        print("成功");
      } else {
        //#_result = 'error code : ${response.statusCode}';
        print("失败");
      }
    } catch (exception) {
      print('exc:$exception');
    }
    setState(() {});
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    commenttext.dispose();
    super.dispose();
  }




  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
            title: CommonText('新闻详情',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 22.0
                )
            ),



            brightness: Brightness.light,
            centerTitle: true,
            elevation: 0.0,
            backgroundColor: Colors.grey.withOpacity(0.2)
        ),
        //body: BlocProvider(
        //bloc: blocDetail,
        //body: PageDetailContent(),
        body:buildLayout(),

    );
  }
  Widget buildLayout(){
    //print(commentcount);
    //print("shuliang1");
    List<Widget> renderList = [
      // 标题
      this.getCircleTitle(),
      SizedBox(height: 7.0),
      this.getSubTitle(),
      this.getDescriptionArea(),
      this.getCircleCommentBar(),
    ];
    //int i;
    for(int i=0;i<commentcount;i++)
    {
      renderList.add(this.getCommentsNumArea(i));
    }
    return ListView(
      padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
      children: renderList,
    );
  }





  Widget getCircleTitle() {
    return CommonText(
      //contentItem.title,
      //'专家:病毒所离华南海鲜市场50公里 不可能泄漏病毒',
      //title,
        lvdate[index].title,
        style: TextStyle(
            fontSize: 21.0,
            color: Colors.black,
            fontWeight: FontWeight.bold
        )
    );
  }





  Widget getSubTitle() {
    return Padding(
      padding: EdgeInsets.fromLTRB(15.0, 20.0, 26.0, 0.0),
      child: Row(
        children: <Widget>[
          CommonText(lvdate[index].date,style: TextStyle(color: Color(0xFFaeb2bc), fontSize: 12)),
          Spacer(),
          this.getSubTitleNum(0)
        ],
      ),
    );
  }

  Widget getSubTitleNum(int postTitleNum) {
    Color backgroundColor;
    Color fontColor;

    if (postTitleNum > 0) {
      backgroundColor = Color(0xFFffe0b9);
      fontColor = Color(0xFFe99934);
    }

    if (postTitleNum > 5) {
      backgroundColor = Color(0xFFafcdee);
      fontColor = Color(0xFF004da1);
    }

    return postTitleNum > 0 ? Container(
      width: 18.0,
      height: 18.0,
      decoration: BoxDecoration(
          color: backgroundColor,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(3.0)
      ),
      child: Center(
          child: CommonText(
              postTitleNum.toString(),
              style: TextStyle(
                  color: fontColor,
                  fontSize: 10,
                  fontWeight: FontWeight.bold
              )
          )
      ),
    ) : Container();
  }





  Widget getDescriptionArea() {
    double containerWidth = MediaQuery.of(this.context).size.width - 50.0;
    double textWidth = containerWidth - 40;


    return Padding(
        padding: EdgeInsets.fromLTRB(1.0, 0.0, 0.0, 0.0),
        //alignment: Alignment.topLeft,

        child: Container(
          //width: containerWidth,
          margin: EdgeInsets.only(left: 0),
          child: Row(
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              CircleAvatar(
                //backgroundImage: CommentImageNetwork.imageNetwork(item.userPic),
                radius: 15.0,
              ),
              SizedBox(width: 1.0),
              Container(
                  width: textWidth,
                  alignment: Alignment(-1,-1),
                  child: Html(
                    data: lvdate[index].content,
                  )
              )
            ],
          ),
        )
    );
  }


  Widget getCommentsNumArea(int i) {
    print(i);
    print("lingyige");
    return Padding(
      padding: EdgeInsets.fromLTRB(15.0, 25.0, 20.0, 30.0),
      child: Row(
        children: <Widget>[
          CommonText(
            commdate[i].nameId+':   '+commdate[i].comment,
              //'good',
              style: TextStyle(
                  color: Color(0xFF5f6f7f).withOpacity(0.5),
                  fontSize: 15
              )
          ),
          Spacer(),
          this.buildCommentIcon(Icons.favorite_border, 1),
        ],
      ),
    );
  }

  /// 留言区图标按钮
  Widget buildCommentIcon(IconData iconComment, int commentNum) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
            width: 12.0,
            height: 12.0,
            child: IconButton(
              padding: EdgeInsets.all(0.0),
              icon: Icon(iconComment, color: Color(0xFF5f6f7f).withOpacity(0.5), size: 12.0),
              onPressed: () {},
            )
        ),
        SizedBox(width: 5.0),
        CommonText(
            commentNum.toString(),
            style: TextStyle(
                color: Color(0xFF5f6f7f).withOpacity(0.5),
                fontSize: 10
            )
        )
      ],
    );
  }




  Widget getCircleCommentBar() {
    return Padding(
      padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 20.0),
      child: Row(
        children: <Widget>[
          Expanded(
              flex: 8,
              child: TextField(
                  keyboardType: TextInputType.text,
                  controller: commenttext,
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 12.0, color: Colors.black),
                  decoration: InputDecoration(
                    fillColor: Color(0xFFe4e9f5),
                    filled: true,
                    labelText: '共有$number条留言',
                    //labelText: snapshotComment.data.comment > 0 ? '共有 ${snapshotComment.data.comment} 条留言' : '',
                    labelStyle: TextStyle(color: Colors.grey, fontSize: 15.0),
                    prefixIcon: Container(
                      child: Icon(Icons.comment, color: Colors.black.withOpacity(0.6), size: 26.0),
                    ),
                    suffixText: 'Enter comment words',
                    border: InputBorder.none,
                  ),
                  onChanged: (text) {
                    print('change $text');
                  },
                  onSubmitted: (text) {
                    print('submit $text');
                  }
              )
          ),
          this.getJumpToNextButton(2),
        ],
      ),
    );
  }

  /// 跳转到留言页

  Widget getJumpToNextButton(int commentLength) {
    return Expanded(
      child: IconButton(
          icon:Icon(Icons.airplay),
          color: Colors.black,
          iconSize: 30.0,
          onPressed: (){
            if(usename!=null)
              loadDataByDio();
            else
            {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    // Retrieve the text the user has entered by using the
                    // TextEditingController.
                    content: Text("请登录"),
                  );
                },
              );
            }
          }
      ),
    );
  }
}

/*
/// 详情页显示内容
class PageDetailContent extends StatefulWidget {

  final int index;
  PageDetailContent(this.index) : super();

  _PageDetailContentState createState() => _PageDetailContentState(index);
}


class _PageDetailContentState extends State<PageDetailContent> {
  String com="no";
  //Future<Comment> comment;
  //final int num;
  //BlocDetail blocDetailInfo;
  //int count=lvdate[zzz].count;
  _PageDetailContentState(this.index): super();


  @override

  Widget build(BuildContext context) {


    return Material(

        child: buildLayout(),
           //This trailing comma makes auto-formatting nicer for build methods.
    );




    //return this.buildLayout();
    //buildLayout();
  }





}

 */
