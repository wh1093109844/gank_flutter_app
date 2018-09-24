import 'package:json_annotation/json_annotation.dart';

part 'gank_content.g.dart';

@JsonSerializable()
class Content extends Object with _$ContentJsonSerializerMixin{
  String _id;
  String content;
  DateTime created_at;
  DateTime publishedAt;
  String rand_id;
  String title;
  DateTime updated_at;

  String get id => _id;

  Content(this._id, this.content, this.created_at, this.publishedAt, this.rand_id, this.title, this.updated_at);

  factory Content.fromJson(json) => _$ContentFromJson(json);
}
