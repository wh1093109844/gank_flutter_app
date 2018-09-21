import 'package:json_annotation/json_annotation.dart';

part 'xiandu_child_type.g.dart';

@JsonSerializable()
class XianduChildType extends Object with _$XianduChildTypeSerializerMixin{

  String _id;
  DateTime created_at;
  String icon;
  String id;
  String title;

  XianduChildType(this._id, this.created_at, this.icon, this.id, this.title);

  factory XianduChildType.fromJson(json) => _$XianduChildTypeFromJson(json);
}
