import 'package:json_annotation/json_annotation.dart';

part 'xiandu_main_type.g.dart';

@JsonSerializable()
class XianduMainType extends Object with _$XianduMainTypeSerializerMixin {
  String _id;
  String en_name;
  String name;
  int rank;
  String get id => _id;

  XianduMainType(this._id, this.name, this.en_name, this.rank);

  factory XianduMainType.fromJson(json) => _$XianduMainTypeFromJson(json);
}
