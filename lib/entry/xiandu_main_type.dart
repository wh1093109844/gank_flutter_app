import 'package:json_annotation/json_annotation.dart';

part 'xiandu_main_type.g.dart';

@JsonSerializable()
class XianduMainType extends Object {

  @JsonKey(name: '_id')
  String id;
  String en_name;
  String name;
  int rank;

  XianduMainType(this.id, this.name, this.en_name, this.rank);

  factory XianduMainType.fromJson(json) => _$XianduMainTypeFromJson(json);
}
