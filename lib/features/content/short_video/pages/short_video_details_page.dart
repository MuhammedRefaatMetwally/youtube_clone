import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:youtube_clone/cores/helpers/extensions.dart';
import '../repository/short_video_repository.dart';

class ShortVideoDetailsPage extends ConsumerStatefulWidget {
  final File video;

  const ShortVideoDetailsPage({
    Key? key,
    required this.video,
  }) : super(key: key);

  @override
  ConsumerState<ShortVideoDetailsPage> createState() =>
      _ShortVideoDetailsPageState();
}

class _ShortVideoDetailsPageState extends ConsumerState<ShortVideoDetailsPage> {
  final captionController = TextEditingController();
  final DateTime date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(isLoadingShortProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Video Details",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: SafeArea(
        child: Padding(
          padding:  EdgeInsets.only(top: 20.h, left: 10.w, right: 10.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: captionController,
                decoration: const InputDecoration(
                  hintText: "Write a caption...",
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: ElevatedButton(
                    onPressed: isLoading
                        ? null
                        : () async {
                            ref.read(isLoadingShortProvider.notifier).state =
                                true;
                            try {
                              await ref
                                  .watch(shortVideoProvider)
                                  .addShortVideoToFirestore(
                                    caption: captionController.text,
                                    video: widget.video.path,
                                    datePublished: date,
                                  );
                              context.pop();
                            } finally {
                              ref.read(isLoadingShortProvider.notifier).state =
                                  false;
                            }
                          },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.green,
                      // Text color
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(12.r), // Rounded corners
                      ),
                    ),
                    child: isLoading
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : const Text(
                            "Publish",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
