import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:youtube_clone/features/content/Long_video/widgets/video_externel_buttons.dart';
import '../../../../cores/colors.dart';
import '../model/video_model.dart';
import '../repo/video_repository.dart';

class VideoActions extends StatelessWidget {
  final VideoModel video;
  final WidgetRef ref;

  const VideoActions({
    Key? key,
    required this.video,
    required this.ref,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(left: 9.w, top: 10.5.h, right: 9.w),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            Container(
              padding:  EdgeInsets.symmetric(horizontal: 15.w, vertical: 6.h),
              decoration:  BoxDecoration(
                color: softBlueGreyBackGround,
                borderRadius: BorderRadius.all(Radius.circular(25.r)),
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () async {
                      await ref.watch(longVideoProvider).likeVideo(
                            currentUserId: FirebaseAuth.instance.currentUser!.uid,
                            likes: video.likes,
                            videoId: video.videoId,
                          );
                    },
                    child: Icon(
                      Icons.thumb_up,
                      color: video.likes.contains(FirebaseAuth.instance.currentUser!.uid)
                          ? Colors.blue
                          : Colors.black,
                      size: 15.5,
                    ),
                  ),
                   SizedBox(width: 19.w),
                  const Icon(
                    Icons.thumb_down,
                    size: 15.5,
                  ),
                ],
              ),
            ),
             Padding(
              padding: EdgeInsets.only(left: 9.w, right: 9.w),
              child: const VideoExtraButton(
                text: "Share",
                iconData: Icons.share,
              ),
            ),
            const VideoExtraButton(
              text: "Remix",
              iconData: Icons.analytics_outlined,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 9, right: 9),
              child: VideoExtraButton(
                text: "Download",
                iconData: Icons.download,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
