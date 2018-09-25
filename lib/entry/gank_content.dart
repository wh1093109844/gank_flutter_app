import 'package:json_annotation/json_annotation.dart';

part 'gank_content.g.dart';

@JsonSerializable()
class Content extends Object {
  @JsonKey(name: '_id')
  String id;
  String content;
  DateTime created_at;
  DateTime publishedAt;
  String rand_id;
  String title;
  DateTime updated_at;

  Content(this.id, this.content, this.created_at, this.publishedAt, this.rand_id, this.title, this.updated_at);

  factory Content.fromJson(json) => _$ContentFromJson(json);
}
