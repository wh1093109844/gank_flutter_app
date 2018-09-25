// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'xiandu_main_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

XianduMainType _$XianduMainTypeFromJson(Map<String, dynamic> json) {
  return XianduMainType(json['_id'] as String, json['name'] as String,
      json['en_name'] as String, json['rank'] as int);
}

Map<String, dynamic> _$XianduMainTypeToJson(XianduMainType instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'en_name': instance.en_name,
      'name': instance.name,
      'rank': instance.rank
    };
