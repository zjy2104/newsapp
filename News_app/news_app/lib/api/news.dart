import 'package:json_annotation/json_annotation.dart';

part 'news.g.dart';


List<news> getnewsList(List<dynamic> list){
  List<news> result = [];
  list.forEach((item){
    result.add(news.fromJson(item));
  });
  return result;
}
@JsonSerializable()
class news extends Object {

  @JsonKey(name: 'count')
  int count;

  @JsonKey(name: 'title')
  String title;

  @JsonKey(name: 'date')
  String date;

  @JsonKey(name: 'editor')
  String editor;

  @JsonKey(name: 'url')
  String url;

  @JsonKey(name: 'content')
  String content;

  @JsonKey(name: 'newid')
  int newid;

  news(this.count,this.title,this.date,this.editor,this.url,this.content,this.newid,);

  factory news.fromJson(Map<String, dynamic> srcJson) => _$newsFromJson(srcJson);

  Map<String, dynamic> toJson() => _$newsToJson(this);

}


