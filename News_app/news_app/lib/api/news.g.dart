// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

news _$newsFromJson(Map<String, dynamic> json) {
  return news(
    json['count'] as int,
    json['title'] as String,
    json['date'] as String,
    json['editor'] as String,
    json['url'] as String,
    json['content'] as String,
    json['newid'] as int,
  );
}

Map<String, dynamic> _$newsToJson(news instance) => <String, dynamic>{
      'count': instance.count,
      'title': instance.title,
      'date': instance.date,
      'editor': instance.editor,
      'url': instance.url,
      'content': instance.content,
      'newid': instance.newid,
    };
