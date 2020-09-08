import 'package:flutter/material.dart';
import 'package:news_app/newspages/PageDetail.dart';
import 'package:news_app/api/url.dart';
import 'package:news_app/api/news.dart';


class NewsListWidget2 extends StatefulWidget {
  NewsListWidget2():super();


  _NewsListState createState() => _NewsListState(user:fetchPost(2));
}

class _NewsListState extends State<NewsListWidget2>
    with AutomaticKeepAliveClientMixin {
  Future<news> user;
  _NewsListState({Key key, this.user});

  //当前页
  int _page = 0;
  List<news> _datas;
  ScrollController _listController;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _listController = ScrollController();
    _listController.addListener(() {
      var maxScroll = _listController.position.maxScrollExtent;
      var pixels = _listController.position.pixels;
      if (maxScroll == pixels) {
        _page += 20;
        //_getNewsList();
      }
    });
  }

  @override
  void dispose() {
    _listController.dispose();
    super.dispose();
  }

  Future<Null> _pullToRefresh() async {
    _page = 0;
    _getNewsList();
    return null;
  }


  _getNewsList() {
  }



  _onItemClick(int index) {
    print(index);
    PageDetail(index);
    /*
    Navigator.of(context).push(MaterialPageRoute(
        builder: (ctx) => PageDetail(
          num:index,
          //postId: data.postid,
          //url: data.url,
          //title: "",
        )));
    //}

     */
  }

  Widget _renderRow(int position) {
    if (position.isOdd) return Divider();

    final index = position ~/ 2;
    //User data = lvdate[index];

    return Card(
      color: Colors.grey[250],
      elevation: 5.0,
      child: InkWell(
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Image.network(data.imgsrc, fit: BoxFit.fitWidth),
            Image.asset('assets/images/fblogo.jpg',fit: BoxFit.fitWidth,
              height: 50,
              width: 50,),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                lvdate[index].title,
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: lvdate[index].title.isEmpty
                  ? const EdgeInsets.all(0.0)
                  : const EdgeInsets.only(
                  left: 10.0, right: 10.0, bottom: 10.0),
              /*
              child: Text(
                //data.digest,
                "very good",
                style: TextStyle(
                  fontSize: 12.0,
                ),
              ),

               */
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: Text(

                lvdate[index].date,
                style: TextStyle(
                  fontSize: 12.0,
                ),
              ),
            ),
            Padding(
              padding:
              const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
              child: Text(
                lvdate[index].url,
                style: TextStyle(
                  fontSize: 12.0,
                ),
              ),
            )
          ],
        ),
        onTap: () {
          //_onItemClick(index);
          PageDetail(index);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (lvdate == null || lvdate.isEmpty) {
      return Center(child: CircularProgressIndicator());
    } else {
      Widget listView = ListView.builder(
        padding: EdgeInsets.all(10.0),
        itemCount: lvdate.length * 2,
        itemBuilder: (context, i) => _renderRow(i),
        controller: _listController,
      );
      return RefreshIndicator(child: listView, onRefresh: _pullToRefresh);
    }
  }
}
