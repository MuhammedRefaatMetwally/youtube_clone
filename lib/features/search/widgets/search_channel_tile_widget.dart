import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:youtube_clone/cores/helpers/extensions.dart';
import 'package:youtube_clone/cores/routing/routes.dart';

import 'package:youtube_clone/cores/widgets/flat_button.dart';
import 'package:youtube_clone/features/auth/model/user_model.dart';
import 'package:youtube_clone/features/channel/users_channel/pages/user_channel_page.dart';
import 'package:youtube_clone/features/channel/users_channel/subscribe_respository.dart';

class SearchChannelTile extends ConsumerWidget {
  final UserModel user;

  const SearchChannelTile({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.only(top: 10.h, left: 10.w),
      child: GestureDetector(
        onTap: () {
          context.pushNamed(Routes.userChannelPage, arguments: user.userId);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatar(
              radius: 40.r,
              backgroundColor: Colors.grey,
              backgroundImage: CachedNetworkImageProvider(user.profilePic),
            ),
            Padding(
              padding: EdgeInsets.only(left: 45.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.displayName,
                    style: TextStyle(
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    "@${user.username}",
                    style: TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 13.sp,
                    ),
                  ),
                  Text(
                    user.subscriptions.isEmpty
                        ? "No subscription"
                        : "${user.subscriptions.length} subscriptions",
                    style: const TextStyle(
                      color: Colors.blueGrey,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  SizedBox(
                    height: 40.h,
                    width: 110.w,
                    child: FlatButton(
                      text: "Subscribe",
                      onPressed: () async {
                        await ref
                            .watch(subscribeChannelProvider)
                            .subscribeChannel(
                              userId: user.userId,
                              currentUserId:
                                  FirebaseAuth.instance.currentUser!.uid,
                              subscriptions: user.subscriptions,
                            );
                      },
                      colour: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
