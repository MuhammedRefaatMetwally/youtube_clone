// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:youtube_clone/cores/colors.dart';

class VideoExtraButton extends StatelessWidget {
  final String text;
  final IconData iconData;
  const VideoExtraButton({
    Key? key,
    required this.text,
    required this.iconData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:  EdgeInsets.symmetric(
        horizontal: 12.w,
        vertical: 3.h,
      ),
      decoration:  BoxDecoration(
        color: softBlueGreyBackGround,
        borderRadius: BorderRadius.all(
          Radius.circular(25.r),
        ),
      ),
      child: Row(
        children: [
          Icon(iconData),
           SizedBox(width: 6.w),
          Text(text),
        ],
      ),
    );
  }
}
