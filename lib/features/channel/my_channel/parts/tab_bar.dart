import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PageTabBar extends StatelessWidget {
  const PageTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: EdgeInsets.only(top: 14.h),
      child: TabBar(
        isScrollable: true,
        labelStyle: TextStyle(
          fontSize: 15.sp,
          fontWeight: FontWeight.w500,
        ),
        indicatorSize: TabBarIndicatorSize.label,
        indicatorPadding: EdgeInsets.only(top: 12.h),
        tabs: const[
          Text("Home"),
          Text("Videos"),
          Text("shorts"),
          Text("community"),
          Text("playlists"),
          Text("channels"),
          Text("about"),
        ],
      ),
    );
  }
}
