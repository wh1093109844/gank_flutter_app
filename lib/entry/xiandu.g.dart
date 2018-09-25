// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'xiandu.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Xiandu _$XianduFromJson(Map<String, dynamic> json) {
  return Xiandu(
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
      json['raw'],
      json['site'] == null ? null : Site.fromJson(json['site']),
      json['title'] as String,
      json['uid'] as String,
      json['url'] as String);
}

Map<String, dynamic> _$XianduToJson(Xiandu instance) => <String, dynamic>{
      '_id': instance.id,
      'content': instance.content,
      'cover': instance.cover,
      'crawled': instance.crawled,
      'created_at': instance.created_at?.toIso8601String(),
      'deleted': instance.deleted,
      'published_at': instance.published_at?.toIso8601String(),
      'raw': instance.raw,
      'site': instance.site,
      'title': instance.title,
      'uid': instance.uid,
      'url': instance.url
    };

Site _$SiteFromJson(Map<String, dynamic> json) {
  return Site(
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
}

Map<String, dynamic> _$SiteToJson(Site instance) => <String, dynamic>{
      'cat_cn': instance.cat_cn,
      'cat_en': instance.cat_en,
      'desc': instance.desc,
      'feed_id': instance.feed_id,
      'icon': instance.icon,
      'id': instance.id,
      'name': instance.name,
      'subscribers': instance.subscribers,
      'type': instance.type,
      'url': instance.url
    };
