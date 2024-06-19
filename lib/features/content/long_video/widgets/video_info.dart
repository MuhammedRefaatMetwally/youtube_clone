import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/src/consumer.dart';
import 'package:riverpod/src/common.dart';
import 'package:youtube_clone/features/auth/model/user_model.dart';
import 'package:youtube_clone/features/content/long_video/widgets/profile_picture.dart';
import 'package:youtube_clone/features/content/long_video/widgets/video_title.dart';
import '../model/video_model.dart';

class VideoInfo extends StatelessWidget {
  final AsyncValue<UserModel> userModel;
  final WidgetRef ref;
  final VideoModel video;
  const VideoInfo({super.key, required this.userModel,required this.ref, required this.video});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ProfilePicture(userModel: userModel),
            VideoTitle(title: video.title,userModel:userModel,video:video),
            const Spacer(),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.more_vert),
            ),
          ],
        ),

      ],
    );
  }
}
