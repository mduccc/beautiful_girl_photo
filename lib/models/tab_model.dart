import 'package:json_annotation/json_annotation.dart';

part 'tab_model.g.dart';

@JsonSerializable(nullable: false)
class TabModel {
  final String tabID;
  final String tabName;

  const TabModel({this.tabID, this.tabName});

  factory TabModel.fromJson(Map<String, dynamic> json) =>
      _$TabModelFromJson(json);

  Map<String, dynamic> toJson() => _$TabModelToJson(this);
}
