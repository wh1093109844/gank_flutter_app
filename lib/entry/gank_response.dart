import 'package:json_annotation/json_annotation.dart';
part 'gank_response.g.dart';

@JsonSerializable()
class GankResponse extends Object {
	bool error;
	dynamic results;

	GankResponse(this.error, this.results);

	factory GankResponse.fromJson(Map<String, dynamic> json) => _$GankResponseFromJson(json);
}
