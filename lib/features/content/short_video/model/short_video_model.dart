
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
part 'short_video_model.g.dart';
@JsonSerializable()
class ShortVideoModel {
  final String caption;
  final String userId;
  final String shortVideo;
  final DateTime datePublished;
  ShortVideoModel({
    required this.caption,
    required this.userId,
    required this.shortVideo,
    required this.datePublished,
  });

  Map<String, dynamic> toMap()=> _$ShortVideoModelToJson(this);

  factory ShortVideoModel.fromMap(Map<String, dynamic> json) =>_$ShortVideoModelFromJson(json);
}
