import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../auth/model/user_model.dart';

class ProfilePicture extends StatelessWidget {
  final AsyncValue<UserModel> userModel;
  const ProfilePicture({super.key,required this.userModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(top: 8.h, left: 5.w),
      child: CircleAvatar(
        radius: 20.r,
        backgroundColor: Colors.grey,
        backgroundImage: CachedNetworkImageProvider(userModel.value?.profilePic ?? ""),
      ),
    );
  }
}
