import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../cores/widgets/flat_button.dart';
import '../../../auth/model/user_model.dart';
import '../../../channel/users_channel/subscribe_respository.dart';
import '../model/video_model.dart';

class ChannelInfo extends StatelessWidget {
  final VideoModel video;
  final AsyncValue<UserModel> user;
  final WidgetRef ref;

  const ChannelInfo({
    Key? key,
    required this.video,
    required this.user,
    required this.ref,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return user.when(
      data: (userData) {
        return Padding(
          padding:  EdgeInsets.only(left: 12.w, top: 8.h, right: 9.w),
          child: Row(
            children: [
              CircleAvatar(
                radius: 16,
                backgroundColor: Colors.grey,
                backgroundImage: CachedNetworkImageProvider(userData.profilePic),
              ),
              Padding(
                padding:  EdgeInsets.only(left: 10.w, right: 4.w),
                child: Text(
                  userData.displayName,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 6.w, left: 2.w),
                child: Text(
                  userData.subscriptions.isEmpty
                      ? "No subscriptions"
                      : "${userData.subscriptions.length} subscriptions",
                  style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w500),
                ),
              ),
              const Spacer(),
              SizedBox(
                height: 35.h,
                width: 100.w,
                child: Padding(
                  padding:  EdgeInsets.only(right: 6.w),
                  child: Expanded(
                    child: FlatButton(
                      text: "Subscribe",
                      onPressed: () async {
                        await ref
                            .watch(subscribeChannelProvider)
                            .subscribeChannel(
                              userId: userData.userId,
                              currentUserId: FirebaseAuth.instance.currentUser!.uid,
                              subscriptions: userData.subscriptions,
                            );
                      },
                      colour: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Text('Error: $err'),
    );
  }
}
