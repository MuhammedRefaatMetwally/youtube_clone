import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../model/video_model.dart';

class VideoDetails extends StatelessWidget {
  final VideoModel video;

  const VideoDetails({Key? key, required this.video}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(left: 13.w, top: 4.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            video.title,
            overflow: TextOverflow.ellipsis,
            softWrap: true,
            style:  TextStyle(
              fontSize: 17.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          Padding(
            padding:  EdgeInsets.only(top: 5.h),
            child: Row(
              children: [
                Padding(
                  padding:  EdgeInsets.only( right: 4.w),
                  child: Text(
                    video.views == 0 ? "No view" : "${video.views} views",
                    style: const TextStyle(
                      fontSize: 13.4,
                      color: Color(0xff5F5F5F),
                    ),
                  ),
                ),
                Padding(
                  padding:  EdgeInsets.only(left: 4.w, right: 8.w),
                  child: Text(
                    timeago.format(video.datePublished),
                    style:  TextStyle(
                      fontSize: 13.4.sp,
                      color: const Color(0xff5F5F5F),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}