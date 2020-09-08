import 'package:json_annotation/json_annotation.dart';

part 'comment.g.dart';


List<Comment> getCommentList(List<dynamic> list){
  List<Comment> result = [];
  list.forEach((item){
    result.add(Comment.fromJson(item));
  });
  return result;
}
@JsonSerializable()
class Comment extends Object {

  @JsonKey(name: 'count')
  int count;

  @JsonKey(name: 'name_id')
  String nameId;

  @JsonKey(name: 'comment')
  String comment;

  Comment(this.count,this.nameId,this.comment,);

  factory Comment.fromJson(Map<String, dynamic> srcJson) => _$CommentFromJson(srcJson);

  Map<String, dynamic> toJson() => _$CommentToJson(this);

}


