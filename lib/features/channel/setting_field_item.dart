// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingsItem extends StatelessWidget {
  final String identifier;
  final VoidCallback onPressed;
  final String value;

  const SettingsItem({
    Key? key,
    required this.identifier,
    required this.onPressed,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(left: 16.w, right: 14.w, top: 6.h, bottom: 4.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                identifier,
                style:  TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 15.sp,
                ),
              ),
               SizedBox(height: 4.h),
              Text(value),
            ],
          ),
          GestureDetector(
            onTap: onPressed,
            child: Image.asset(
              "assets/icons/pen.png",
              height: 21.h,
            ),
          ),
        ],
      ),
    );
  }
}
