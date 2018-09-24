// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gank_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GankResponse _$GankResponseFromJson(Map<String, dynamic> json) {
  return GankResponse(json['error'] as bool, json['results']);
}

Map<String, dynamic> _$GankResponseToJson(GankResponse instance) =>
    <String, dynamic>{'error': instance.error, 'results': instance.results};
