// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:youtube_clone/cores/methods.dart';
import 'package:youtube_clone/cores/widgets/image_item.dart';

class CreateBottomSheet extends StatelessWidget {
  const CreateBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xffFFFFFF),
      child: Padding(
        padding:  EdgeInsets.only(left: 7.w, top: 12.w),
        child: SizedBox(
          height: 270,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Padding(
                padding: EdgeInsets.only(left: 10.w),
                child: const Text(
                  "Create",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
               SizedBox(height: 28.h),
              SizedBox(
                height: 38,
                child: ImageItem(
                  itemText: "Create a Short",
                  itemClicked: () async {
                    await pickShortVideo(context);
                  },
                  imageName: "short-video.png",
                  haveColor: true,
                ),
              ),
               SizedBox(height: 12.h),
              SizedBox(
                height: 38,
                child: ImageItem(
                  itemText: "Upload a Video",
                  itemClicked: () async {
                    await pickVideo(context);
                  },
                  imageName: "upload.png",
                  haveColor: true,
                ),
              ),
               SizedBox(height: 12.h),
              SizedBox(
                height: 38,
                child: ImageItem(
                  itemText: "Go Live",
                  itemClicked: () {},
                  imageName: "go-live.png",
                  haveColor: true,
                ),
              ),
              SizedBox(height: 12.h),
              SizedBox(
                height: 38.h,
                child: ImageItem(
                  itemText: "Create a post",
                  itemClicked: () {},
                  imageName: "create-post.png",
                  haveColor: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
