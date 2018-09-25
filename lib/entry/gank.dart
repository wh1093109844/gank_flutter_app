import 'package:json_annotation/json_annotation.dart';
part 'gank.g.dart';

@JsonSerializable()
class Gank extends Object {
  @JsonKey(name: '_id')
	String id;
	String createdAt;
	String desc;
	List<String> images;
	DateTime publishedAt;
	String source;
	String type;
	String url;
	bool used;
	String who;

	Gank(this.id, this.createdAt, this.desc, this.images, this.publishedAt, this.source, this.type, this.url, this.used, this.who);

	factory Gank.fromJson(Map<String, dynamic> json) => _$GankFromJson(json);
}
