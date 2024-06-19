import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../../../../cores/screens/error_page.dart';
import '../../../../cores/screens/loader.dart';
import '../model/video_model.dart';
import '../components/post.dart';

class RelatedVideos extends StatelessWidget {
  final VideoModel video;

  const RelatedVideos({
    Key? key,
    required this.video,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("videos")
          .where("videoId", isNotEqualTo: video.videoId)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const ErrorPage();
        } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(
            child: Text('No videos available.'),
          );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const Loader();
        }

        final videosMap = snapshot.data!.docs;
        final videos = videosMap
            .map((videoData) => VideoModel.fromMap(videoData.data()))
            .toList();

        return ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: videos.length,
          itemBuilder: (context, index) {
            return Post(video: videos[index]);
          },
        );
      },
    );
  }
}
