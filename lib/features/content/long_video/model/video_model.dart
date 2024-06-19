import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
part 'video_model.g.dart';
@JsonSerializable()
class VideoModel {
  final String videoUrl;
  final String thumbnail;
  final String title;
  final DateTime datePublished;
  final int views;
  final String videoId;
  final String userId;
  final List likes;
  final String type;
  VideoModel({
    required this.videoUrl,
    required this.thumbnail,
    required this.title,
    required this.datePublished,
    required this.views,
    required this.videoId,
    required this.userId,
    required this.likes,
    required this.type,
  });

  Map<String, dynamic> toMap()=> _$VideoModelToJson(this);

  factory VideoModel.fromMap(Map<String, dynamic> json) => _$VideoModelFromJson(json);
}
