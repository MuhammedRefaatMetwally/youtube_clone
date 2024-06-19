// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'short_video_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShortVideoModel _$ShortVideoModelFromJson(Map<String, dynamic> json) =>
    ShortVideoModel(
        caption: json['caption'] as String,
        userId: json['userId'] as String,
        shortVideo: json['shortVideo'] as String,
      datePublished: json["datePublished"] is Timestamp
          ? (json["datePublished"] as Timestamp).toDate()
          : json["datePublished"] is int
          ? DateTime.fromMillisecondsSinceEpoch(json["datePublished"] as int)
          : json["datePublished"] is String
          ? DateTime.parse(json["datePublished"] as String)
          : DateTime.now(),);

Map<String, dynamic> _$ShortVideoModelToJson(ShortVideoModel instance) =>
    <String, dynamic>{
      'caption': instance.caption,
      'userId': instance.userId,
      'shortVideo': instance.shortVideo,
      'datePublished': instance.datePublished.toIso8601String(),
    };
