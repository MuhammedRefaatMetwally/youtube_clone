// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentModel _$CommentModelFromJson(Map<String, dynamic> json) => CommentModel(
      commentText: json['commentText'] as String,
      videoId: json['videoId'] as String,
      commmentId: json['commmentId'] as String,
      displayName: json['displayName'] as String,
      profilePic: json['profilePic'] as String,
    );

Map<String, dynamic> _$CommentModelToJson(CommentModel instance) =>
    <String, dynamic>{
      'commentText': instance.commentText,
      'videoId': instance.videoId,
      'commmentId': instance.commmentId,
      'displayName': instance.displayName,
      'profilePic': instance.profilePic,
    };
