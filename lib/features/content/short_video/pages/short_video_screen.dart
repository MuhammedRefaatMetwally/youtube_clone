// ignore_for_file: public_member_api_docs, sort_constructors_first, use_build_context_synchronously
import 'dart:io';
import 'package:ffmpeg_kit_flutter/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter/return_code.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_editor/video_editor.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_clone/cores/helpers/extensions.dart';
import 'package:youtube_clone/cores/methods.dart';
import 'package:youtube_clone/cores/routing/routes.dart';
import 'package:youtube_clone/features/content/short_video/pages/short_video_details_page.dart';
import '../repository/short_video_repository.dart';
import '../../../content/short_video/widgets/trim_slinder.dart';

class ShortVideoScreen extends ConsumerStatefulWidget {
  final File shortVideo;

  const ShortVideoScreen({
    Key? key,
    required this.shortVideo,
  }) : super(key: key);

  @override
  ConsumerState<ShortVideoScreen> createState() => _ShortVideoScreenState();
}

class _ShortVideoScreenState extends ConsumerState<ShortVideoScreen> {
  VideoEditorController? editorController;
  late VideoPlayerController videoPlayerController;
  final exporingProgress = ValueNotifier<double>(0.0);

  @override
  void initState() {
    super.initState();
    editorController = VideoEditorController.file(
      widget.shortVideo,
      minDuration: const Duration(seconds: 3),
      maxDuration: const Duration(seconds: 60),
    );
    editorController!
        .initialize(aspectRatio: 4 / 3.6)
        .then((_) => setState(() {}));

    videoPlayerController = VideoPlayerController.file(widget.shortVideo)
      ..initialize().then((_) {
        setState(() {});
        videoPlayerController.play();
      });
  }

  Future<void> exportVideo() async {
    ref.read(isExportingProvider.notifier).state = true;
    final config = VideoFFmpegVideoEditorConfig(editorController!);
    final execute = await config.getExecuteConfig();
    final String command = execute.command;

    FFmpegKit.executeAsync(
      command,
          (session) async {
        final ReturnCode? code = await session.getReturnCode();
        if (ReturnCode.isSuccess(code)) {
          ref.read(isExportingProvider.notifier).state = false;

          context.pop();
          context.pushNamed(Routes.shortVideoDetailsScreen,arguments: widget.shortVideo);
        } else {
          showErrorSnackBar("Failed, video cannot be exported", context);
        }
      },
      null,
          (status) {
        exporingProgress.value =
            config.getFFmpegProgress(status.getTime().toInt());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isExporting = ref.watch(isExportingProvider);
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: 20.h),
          child: editorController!.initialized
              ? Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            context.pop();
                          },
                          icon: const Icon(Icons.arrow_back, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  if (videoPlayerController.value.isInitialized)
                    AspectRatio(
                      aspectRatio:  3/ 3.6,
                      child: VideoPlayer(videoPlayerController),
                    ),
                  const Spacer(),
                  MyTrimSlider(
                    controller: editorController!,
                    height: 45.h,
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 12.h, right: 8.w),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(18.r),
                          ),
                        ),
                        child: TextButton(
                          onPressed: exportVideo,
                          child: isExporting
                              ? const Center(
                              child: CircularProgressIndicator())
                              : const Text(
                            "DONE",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
              : const SizedBox(),
        ),
      ),
    );
  }
}
