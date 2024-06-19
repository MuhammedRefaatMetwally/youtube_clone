// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:youtube_clone/features/auth/model/user_model.dart';
import 'package:youtube_clone/features/upload/comments/model/comment_model.dart';

class VideoFirstComment extends StatelessWidget {
  final List<CommentModel> comments;
  final UserModel user;
  const VideoFirstComment({
    Key? key,
    required this.comments,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Text(
              "Comments",
              style: TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
             SizedBox(width: 6.w),
            Text("${comments.length}"),
          ],
        ),
        Padding(
          padding:  EdgeInsets.only(top: 7.5.h),
          child: Row(
            children: [
              CircleAvatar(
                radius: 14,
                backgroundColor: Colors.grey,
                backgroundImage: CachedNetworkImageProvider(
                  user.profilePic,
                ),
              ),
               SizedBox(width: 7.w),
              SizedBox(
                width: 280.w,
                child: Text(
                  comments[0].commentText,
                  maxLines: 2,
                  style:  TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 13.5.sp,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
