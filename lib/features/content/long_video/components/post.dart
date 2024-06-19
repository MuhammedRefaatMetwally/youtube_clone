import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:youtube_clone/cores/helpers/extensions.dart';
import 'package:youtube_clone/features/auth/model/user_model.dart';
import 'package:youtube_clone/features/auth/provider/user_provider.dart';
import 'package:youtube_clone/features/content/long_video/widgets/video_info.dart';
import '../../../../cores/routing/routes.dart';
import '../model/video_model.dart';


class Post extends ConsumerWidget {
  final VideoModel video;
  const Post({
    Key? key,
    required this.video,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<UserModel> userModel =
    ref.watch(anyUserDataProvider(video.userId));

    return GestureDetector(
      onTap: () => _onVideoTap(context, video),
      child: Padding(
        padding:  EdgeInsets.only(bottom: 24.h),
        child: Column(
          children: [
            CachedNetworkImage(imageUrl: video.thumbnail),
            VideoInfo( ref: ref, userModel:userModel,video:video),
          ],
        ),
      ),
    );
  }

  void _onVideoTap(BuildContext context, VideoModel video) async {
    context.pushNamed(Routes.mainVideoScreen,arguments: video);

    await FirebaseFirestore.instance
        .collection("videos")
        .doc(video.videoId)
        .update({"views": FieldValue.increment(1)});
  }

}
