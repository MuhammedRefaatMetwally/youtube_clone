// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:youtube_clone/features/auth/model/user_model.dart';

class TopHeader extends StatelessWidget {
  final UserModel user;
  const TopHeader({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: CircleAvatar(
            radius: 38.r,
            backgroundColor: Colors.grey,
            backgroundImage: CachedNetworkImageProvider(user.profilePic),
          ),
        ),
        Padding(
          padding:  EdgeInsets.only(top: 10.h, bottom: 4.h),
          child: Text(
            user.displayName,
            style:  TextStyle(
              fontSize: 26.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding:  EdgeInsets.only(bottom: 10.h),
          child: RichText(
            text: TextSpan(
              style: const TextStyle(
                color: Colors.blueGrey,
              ),
              children: [
                TextSpan(text: "@${user.username}  "),
                TextSpan(
                  text: user.subscriptions.isEmpty
                      ? "No subscription  "
                      : "${user.subscriptions.length} subscriptions ",
                ),
                TextSpan(
                  text: user.videos == 0 ? "No video" : "${user.videos} videos",
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
