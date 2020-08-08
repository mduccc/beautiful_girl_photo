import 'package:json_annotation/json_annotation.dart';

part 'image_model.g.dart';

@JsonSerializable(nullable: false)
class ImageModel {
  final String thumbnail;
  final String urlFullSize;
  bool heart;
  final double heartCount;

  ImageModel(
      {this.thumbnail = '',
      this.urlFullSize = '',
      this.heart = false,
      this.heartCount = 0});

  factory ImageModel.fromJson(Map<String, dynamic> json) =>
      _$ImageModelFromJson(json);

  Map<String, dynamic> toJson() => _$ImageModelToJson(this);
}
