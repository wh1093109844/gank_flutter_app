// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gank_response.dart';

// **************************************************************************
// Generator: JsonSerializableGenerator
// **************************************************************************

GankResponse _$GankResponseFromJson(Map<String, dynamic> json) =>
    new GankResponse(json['error'] as bool, json['results'] as List);

abstract class _$GankResponseSerializerMixin {
  bool get error;
  List<dynamic> get results;
  Map<String, dynamic> toJson() =>
      <String, dynamic>{'error': error, 'results': results};
}
