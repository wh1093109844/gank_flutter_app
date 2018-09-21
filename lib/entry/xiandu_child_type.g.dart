// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'xiandu_child_type.dart';

// **************************************************************************
// Generator: JsonSerializableGenerator
// **************************************************************************

XianduChildType _$XianduChildTypeFromJson(Map<String, dynamic> json) =>
    new XianduChildType(
        json['_id'] as String,
        json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at'] as String),
        json['icon'] as String,
        json['id'] as String,
        json['title'] as String);

abstract class _$XianduChildTypeSerializerMixin {
  String get _id;
  DateTime get created_at;
  String get icon;
  String get id;
  String get title;
  Map<String, dynamic> toJson() => <String, dynamic>{
        '_id': _id,
        'created_at': created_at?.toIso8601String(),
        'icon': icon,
        'id': id,
        'title': title
      };
}
