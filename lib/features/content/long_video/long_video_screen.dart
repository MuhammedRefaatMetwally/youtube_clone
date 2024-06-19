import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:youtube_clone/cores/screens/error_page.dart';
import 'package:youtube_clone/features/content/long_video/components/post.dart';
import '../long_video/model/video_model.dart';

class LongVideoScreen extends StatelessWidget {
  const LongVideoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("videos").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const ErrorPage();
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Skeletonizer(
                enabled: true,
                child: ListView.builder(
                  itemCount: 20,
                  itemBuilder: (context, index) {
                    return const SizedBox(
                      width: double.infinity,
                      height: double.infinity,
                    );
                  },
                ));
          }
          final videoMaps = snapshot.data!.docs;
          final videos = videoMaps.map(
            (video) {
              return VideoModel.fromMap(
                video.data(),
              );
            },
          ).toList();

          return Skeletonizer(
            enabled: snapshot.connectionState == ConnectionState.waiting,
            child: ListView.builder(
              itemCount: videos.length,
              itemBuilder: (context, index) {
                return Post(
                  video: videos[index],
                );
              },
            ),
          );
        },
      ),
    );
  }
}
