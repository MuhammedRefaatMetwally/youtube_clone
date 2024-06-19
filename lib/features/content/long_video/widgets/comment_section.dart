import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:youtube_clone/features/content/Long_video/widgets/video_first_comment.dart';

import '../../../auth/model/user_model.dart';
import '../../../upload/comments/model/comment_model.dart';
import '../model/video_model.dart';
import '../../comment/provider/comment_provider.dart';
import '../../comment/commnet_sheet.dart';

class CommentSection extends StatelessWidget {
  final VideoModel video;
  final AsyncValue<UserModel> user;
  final WidgetRef ref;

  const CommentSection({
    Key? key,
    required this.video,
    required this.user,
    required this.ref,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 12.h),
      child: GestureDetector(
        onTap: () {
          showModalBottomSheet(
            context: context,
            builder: (context) => CommentSheet(video: video),
          );
        },
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 9.h, horizontal: 12.w),
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.all(Radius.circular(8.r)),
          ),
          child: Consumer(
            builder: (context, ref, child) {
              final AsyncValue<List<CommentModel>> comments = ref.watch(commentsProvider(video.videoId));

              return comments.when(
                data: (commentsData) {
                  if (commentsData.isEmpty) {
                    return  SizedBox(height: 20.h);
                  }

                  return VideoFirstComment(comments: commentsData, user: user.value!);
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (err, stack) => Text('Error: $err'),
              );
            },
          ),
        ),
      ),
    );
  }
}
