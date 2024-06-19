import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uuid/uuid.dart';
import 'package:youtube_clone/cores/helpers/extensions.dart';
import 'package:youtube_clone/cores/methods.dart';
import 'package:youtube_clone/features/content/long_video/repo/video_repository.dart';

class VideoDetailsPage extends ConsumerStatefulWidget {
  final File? video;
  const VideoDetailsPage({super.key,
    this.video,
  });

  @override
  ConsumerState<VideoDetailsPage> createState() => _VideoDetailsPageState();
}

class _VideoDetailsPageState extends ConsumerState<VideoDetailsPage> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  File? image;
  bool isThumbnailSelected = false;
  String randomNumber = const Uuid().v4();
  String videoId = const Uuid().v4();
  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(isLoadingProvider);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding:  EdgeInsets.only(
            top: 20.h,
            left: 10.w,
            right: 10.w,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                "Enter the title",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                ),
              ),
               SizedBox(height: 5.h),
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  hintText: "Enter the title",
                  prefixIcon: Icon(Icons.title),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
               SizedBox(height: 30.h),
              const Text(
                "Enter the Description",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                ),
              ),
               SizedBox(height: 5.h),
              TextField(
                controller: descriptionController,
                maxLines: 5,
                decoration: const InputDecoration(
                  hintText: "Enter the Description",
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),

              Padding(
                padding:  EdgeInsets.only(top: 12.h),
                child: Container(
                  decoration:  BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.all(
                      Radius.circular(11.r),
                    ),
                  ),
                  child: TextButton(
                    onPressed: () async {
                      // pick image
                      image = await pickImage();
                      isThumbnailSelected = true;
                      setState(() {});
                    },
                    child: const Text(
                      "SELECT THUMBNAIL",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              isThumbnailSelected
                  ? Padding(
                      padding:  EdgeInsets.only(top: 12.h, bottom: 12.w),
                      child: Image.file(
                        image!,
                        cacheHeight: 160,
                        cacheWidth: 400,
                      ),
                    )
                  : const SizedBox(),

              isThumbnailSelected
                  ? Padding(
                      padding:  EdgeInsets.only(top: 12.h),
                      child: Container(
                        decoration:  BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.all(
                            Radius.circular(11.r),
                          ),
                        ),
                        child: TextButton(
                          onPressed: isLoading
                              ? null
                              : () async {
                            ref.read(isLoadingProvider.notifier).state = true;
                            try {
                              // publish video
                              String thumbnail = await putFileInStorage(
                                  image, randomNumber, "image");

                              String videoUrl = await putFileInStorage(
                                  widget.video, randomNumber, "video");

                              await ref
                                  .read(longVideoProvider)
                                  .uploadVideoToFirestore(
                                videoUrl: videoUrl,
                                thumbnail: thumbnail,
                                title: titleController.text,
                                videoId: videoId,
                                datePublished: DateTime.now(),
                                userId: FirebaseAuth
                                    .instance.currentUser!.uid,
                              );

                              context.pop();
                            } finally {
                              ref.read(isLoadingProvider.notifier).state = false;
                            }
                          },
                          child: isLoading
                              ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                              : const Text(
                            "Publish",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
              )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
