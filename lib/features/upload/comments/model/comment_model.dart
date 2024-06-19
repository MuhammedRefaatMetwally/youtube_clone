import 'package:json_annotation/json_annotation.dart';
part 'comment_model.g.dart';
@JsonSerializable()
class CommentModel {
  final String commentText;
  final String videoId;
  final String commmentId;
  final String displayName;
  final String profilePic;
  CommentModel({
    required this.commentText,
    required this.videoId,
    required this.commmentId,
    required this.displayName,
    required this.profilePic,
  });

  Map<String, dynamic> toMap() => _$CommentModelToJson(this);

  factory CommentModel.fromMap(Map<String, dynamic> json) =>_$CommentModelFromJson(json);
}
