// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gank_content.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Content _$ContentFromJson(Map<String, dynamic> json) {
  return Content(
      json['_id'] as String,
      json['content'] as String,
      json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      json['publishedAt'] == null
          ? null
          : DateTime.parse(json['publishedAt'] as String),
      json['rand_id'] as String,
      json['title'] as String,
      json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String));
}

Map<String, dynamic> _$ContentToJson(Content instance) => <String, dynamic>{
      '_id': instance.id,
      'content': instance.content,
      'created_at': instance.created_at?.toIso8601String(),
      'publishedAt': instance.publishedAt?.toIso8601String(),
      'rand_id': instance.rand_id,
      'title': instance.title,
      'updated_at': instance.updated_at?.toIso8601String()
    };
