import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../../auth/model/user_model.dart';
import '../model/video_model.dart';
class VideoStats extends StatelessWidget {
  final AsyncValue<UserModel> userModel;
  final VideoModel video;
  const VideoStats({super.key, required this.userModel, required this.video});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          userModel.value?.displayName ?? "",
          style: const TextStyle(
            color: Colors.blueGrey,
          ),
        ),
        Padding(
          padding:  EdgeInsets.symmetric(horizontal: 8.w),
          child: Text(
            video.views == 0 ? "No View" : "${video.views} views",
            style: const TextStyle(
              color: Colors.blueGrey,
            ),
          ),
        ),
        Text(
          timeago.format(video.datePublished),
          style: const TextStyle(
            color: Colors.blueGrey,
          ),
        ),
      ],
    );;
  }
}
