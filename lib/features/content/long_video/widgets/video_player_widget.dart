import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_clone/cores/screens/loader.dart';

class VideoPlayerWidget extends StatelessWidget {
  final VideoPlayerController? controller;
  final bool isShowIcons;
  final VoidCallback onToggleIcons;
  final VoidCallback onTogglePlayPause;
  final VoidCallback onGoForward;
  final VoidCallback onGoBackward;
  final bool isPlaying;
  const VideoPlayerWidget({
    Key? key,
    required this.controller,
    required this.isShowIcons,
    required this.onToggleIcons,
    required this.onTogglePlayPause,
    required this.onGoForward,
    required this.onGoBackward, required this.isPlaying ,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (controller == null || !controller!.value.isInitialized) {
      return Padding(
        padding: EdgeInsets.only(bottom: 100.h),
        child: const Loader(),
      );
    }

    return AspectRatio(
      aspectRatio: controller!.value.aspectRatio,
      child: GestureDetector(
        onTap: onToggleIcons,
        child: Stack(
          children: [
            VideoPlayer(controller!),
            if (isShowIcons) ...[
              Center(
                child: GestureDetector(
                  onTap: onTogglePlayPause,
                  child: SizedBox(
                    height: 50.h,
                    child: Image.asset(
                      isPlaying ? "assets/images/pause.png" : "assets/images/play.png",
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 30.w,
                top: 93,
                child: GestureDetector(
                  onTap: onGoForward,
                  child: SizedBox(
                    height: 50.h,
                    child: Image.asset(
                      "assets/images/go_ahead_final.png",
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 30.w,
                top: 94,
                child: GestureDetector(
                  onTap: onGoBackward,
                  child: SizedBox(
                    height: 50.h,
                    child: Image.asset(
                      "assets/images/go_back_final.png",
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                height: 7.5.h,
                child: VideoProgressIndicator(
                  controller!,
                  allowScrubbing: true,
                  colors: const VideoProgressColors(
                    playedColor: Colors.red,
                    bufferedColor: Colors.grey,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}