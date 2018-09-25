import 'package:json_annotation/json_annotation.dart';

part 'xiandu_child_type.g.dart';

@JsonSerializable()
class XianduChildType extends Object {

  String id;
  DateTime created_at;
  String icon;
  String title;

  XianduChildType(this.created_at, this.icon, this.id, this.title);

  factory XianduChildType.fromJson(json) => _$XianduChildTypeFromJson(json);
}
