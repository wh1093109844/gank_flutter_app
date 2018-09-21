// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'xiandu_main_type.dart';

// **************************************************************************
// Generator: JsonSerializableGenerator
// **************************************************************************

XianduMainType _$XianduMainTypeFromJson(Map<String, dynamic> json) =>
    new XianduMainType(json['_id'] as String, json['name'] as String,
        json['en_name'] as String, json['rank'] as int);

abstract class _$XianduMainTypeSerializerMixin {
  String get _id;
  String get en_name;
  String get name;
  int get rank;
  Map<String, dynamic> toJson() => <String, dynamic>{
        '_id': _id,
        'en_name': en_name,
        'name': name,
        'rank': rank
      };
}
