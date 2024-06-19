import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:youtube_clone/cores/colors.dart';
import 'package:youtube_clone/cores/widgets/image_button.dart';

class Buttons extends StatelessWidget {
  const Buttons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:  EdgeInsets.only(top: 16.h),
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  height: 41.h,
                  decoration:  BoxDecoration(
                    color: softBlueGreyBackGround,
                    borderRadius: BorderRadius.all(
                      Radius.circular(9.r),
                    ),
                  ),
                  child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Manage Videos",
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ImageButton(
                  onPressed: () {},
                  image: "pen.png",
                  haveColor: true,
                ),
              ),
              Expanded(
                child: ImageButton(
                  onPressed: () {},
                  image: "time-watched.png",
                  haveColor: true,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
