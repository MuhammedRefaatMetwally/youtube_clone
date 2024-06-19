// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VideoModel _$VideoModelFromJson(Map<String, dynamic> json) => VideoModel(
      videoUrl: json['videoUrl'] as String,
      thumbnail: json['thumbnail'] as String,
      title: json['title'] as String,
      datePublished: json["datePublished"] is Timestamp
          ? (json["datePublished"] as Timestamp).toDate()
          : DateTime.fromMillisecondsSinceEpoch(
            json["datepublished"] as int,
      ),
      views: (json['views'] as num).toInt(),
      videoId: json['videoId'] as String,
      userId: json['userId'] as String,
      likes: json['likes'] as List<dynamic>,
      type: json['type'] as String,
    );

Map<String, dynamic> _$VideoModelToJson(VideoModel instance) =>
    <String, dynamic>{
      'videoUrl': instance.videoUrl,
      'thumbnail': instance.thumbnail,
      'title': instance.title,
      'datePublished': instance.datePublished,
      'views': instance.views,
      'videoId': instance.videoId,
      'userId': instance.userId,
      'likes': instance.likes,
      'type': instance.type,
    };
