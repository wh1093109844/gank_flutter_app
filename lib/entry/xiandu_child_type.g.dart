// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'xiandu_child_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

XianduChildType _$XianduChildTypeFromJson(Map<String, dynamic> json) {
  return XianduChildType(
      json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      json['icon'] as String,
      json['id'] as String,
      json['title'] as String);
}

Map<String, dynamic> _$XianduChildTypeToJson(XianduChildType instance) =>
    <String, dynamic>{
      'id': instance.id,
      'created_at': instance.created_at?.toIso8601String(),
      'icon': instance.icon,
      'title': instance.title
    };
