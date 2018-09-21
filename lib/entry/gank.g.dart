// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gank.dart';

// **************************************************************************
// Generator: JsonSerializableGenerator
// **************************************************************************

Gank _$GankFromJson(Map<String, dynamic> json) => new Gank(
    json['_id'] as String,
    json['createdAt'] as String,
    json['desc'] as String,
    (json['images'] as List)?.map((e) => e as String)?.toList(),
    json['publishedAt'] == null
        ? null
        : DateTime.parse(json['publishedAt'] as String),
    json['source'] as String,
    json['type'] as String,
    json['url'] as String,
    json['used'] as bool,
    json['who'] as String);

abstract class _$GankSerializerMixin {
  String get _id;
  String get createdAt;
  String get desc;
  List<String> get images;
  DateTime get publishedAt;
  String get source;
  String get type;
  String get url;
  bool get used;
  String get who;
  Map<String, dynamic> toJson() => <String, dynamic>{
        '_id': _id,
        'createdAt': createdAt,
        'desc': desc,
        'images': images,
        'publishedAt': publishedAt?.toIso8601String(),
        'source': source,
        'type': type,
        'url': url,
        'used': used,
        'who': who
      };
}
