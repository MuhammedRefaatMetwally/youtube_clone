// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      displayName: json['displayName'] as String,
      username: json['username'] as String,
      email: json['email'] as String,
      profilePic: json['profilePic'] as String,
      subscriptions: json['subscriptions'] as List<dynamic>,
      videos: (json['videos'] as num).toInt(),
      userId: json['userId'] as String,
      description: json['description'] as String,
      type: json['type'] as String,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'displayName': instance.displayName,
      'username': instance.username,
      'email': instance.email,
      'profilePic': instance.profilePic,
      'subscriptions': instance.subscriptions,
      'videos': instance.videos,
      'userId': instance.userId,
      'description': instance.description,
      'type': instance.type,
    };
