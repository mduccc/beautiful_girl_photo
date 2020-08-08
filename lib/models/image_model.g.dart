// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImageModel _$ImageModelFromJson(Map<String, dynamic> json) {
  return ImageModel(
    thumbnail: json['thumbnail'] as String,
    urlFullSize: json['urlFullSize'] as String,
    heart: json['heart'] as bool,
    heartCount: (json['heartCount'] as num).toDouble(),
  );
}

Map<String, dynamic> _$ImageModelToJson(ImageModel instance) =>
    <String, dynamic>{
      'thumbnail': instance.thumbnail,
      'urlFullSize': instance.urlFullSize,
      'heart': instance.heart,
      'heartCount': instance.heartCount,
    };
