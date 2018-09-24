
import 'package:json_annotation/json_annotation.dart';

part 'xiandu.g.dart';

@JsonSerializable()
class Xiandu extends Object with _$XianduSerializerMixin {
  String _id;
  String content;
  String cover;
  int crawled;
  DateTime created_at;
  bool deleted;
  DateTime published_at;
  dynamic raw;
  Site site;
  String title;
  String uid;
  String url;

  Xiandu(this._id, this.content, this.cover, this.crawled, this.created_at, this.deleted, this.published_at, this.raw, this.site, this.title, this.uid, this.url);

  factory Xiandu.formJson(json) => _$XianduFromJson(json);
}

@JsonSerializable()
class Site extends Object with _$SiteSerializerMixin {
  String cat_cn;
  String cat_en;
  String desc;
  String feed_id;
  String icon;
  String id;
  String name;
  int subscribers;
  String type;
  String url;

  Site(this.cat_cn, this.cat_en, this.desc, this.feed_id, this.icon, this.id, this.name, this.subscribers, this.type, this.url);

  factory Site.fromJson(json) => _$SiteFromJson(json);
}
