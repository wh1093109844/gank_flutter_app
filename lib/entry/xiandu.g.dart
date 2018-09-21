// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'xiandu.dart';

// **************************************************************************
// Generator: JsonSerializableGenerator
// **************************************************************************

Xiandu _$XianduFromJson(Map<String, dynamic> json) => new Xiandu(
    json['_id'] as String,
    json['content'] as String,
    json['cover'] as String,
    json['crawled'] as int,
    json['created_at'] == null
        ? null
        : DateTime.parse(json['created_at'] as String),
    json['deleted'] as bool,
    json['published_at'] == null
        ? null
        : DateTime.parse(json['published_at'] as String),
    json['row'] as String,
    json['site'] == null ? null : new Site.fromJson(json['site']),
    json['title'] as String,
    json['uid'] as String,
    json['url'] as String);

abstract class _$XianduSerializerMixin {
  String get _id;
  String get content;
  String get cover;
  int get crawled;
  DateTime get created_at;
  bool get deleted;
  DateTime get published_at;
  String get row;
  Site get site;
  String get title;
  String get uid;
  String get url;
  Map<String, dynamic> toJson() => <String, dynamic>{
        '_id': _id,
        'content': content,
        'cover': cover,
        'crawled': crawled,
        'created_at': created_at?.toIso8601String(),
        'deleted': deleted,
        'published_at': published_at?.toIso8601String(),
        'row': row,
        'site': site,
        'title': title,
        'uid': uid,
        'url': url
      };
}

Site _$SiteFromJson(Map<String, dynamic> json) => new Site(
    json['cat_cn'] as String,
    json['cat_en'] as String,
    json['desc'] as String,
    json['feed_id'] as String,
    json['icon'] as String,
    json['id'] as String,
    json['name'] as String,
    json['subscribers'] as int,
    json['type'] as String,
    json['url'] as String);

abstract class _$SiteSerializerMixin {
  String get cat_cn;
  String get cat_en;
  String get desc;
  String get feed_id;
  String get icon;
  String get id;
  String get name;
  int get subscribers;
  String get type;
  String get url;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'cat_cn': cat_cn,
        'cat_en': cat_en,
        'desc': desc,
        'feed_id': feed_id,
        'icon': icon,
        'id': id,
        'name': name,
        'subscribers': subscribers,
        'type': type,
        'url': url
      };
}
