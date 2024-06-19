import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:riverpod/src/common.dart';
import 'package:youtube_clone/features/auth/model/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_clone/features/content/long_video/widgets/video_stats.dart';

import '../../../auth/model/user_model.dart';
import '../model/video_model.dart';

class VideoTitle extends StatelessWidget {
  final String title;
  final AsyncValue<UserModel> userModel;
  final VideoModel video;
  const VideoTitle({super.key, required this.title, required this.userModel, required this.video});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding:  EdgeInsets.only(left: 8.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          VideoStats(userModel:  userModel,video: video,),
        ],
      ),
    );
  }
}
