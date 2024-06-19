
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/video_model.dart';

final longVideoProvider = Provider(
  (ref) => VideoRepository(firestore: FirebaseFirestore.instance),
);
final isLoadingProvider = StateProvider<bool>((ref) => false);

class VideoRepository {
  FirebaseFirestore firestore;
  VideoRepository({
    required this.firestore,
  });

  Future<void> uploadVideoToFirestore({
    required String videoUrl,
    required String thumbnail,
    required String title,
    required String videoId,
    required DateTime datePublished,
    required String userId,
  }) async {
    VideoModel video = VideoModel(
      videoUrl: videoUrl,
      thumbnail: thumbnail,
      title: title,
      datePublished: datePublished,
      views: 0,
      videoId: videoId,
      userId: userId,
      likes: [],
      type: "video",
    );

    await firestore.collection("videos").doc(videoId).set(video.toMap());
  }

  Future<void> likeVideo({
    required List? likes,
    required videoId,
    required currentUserId,
  }) async {
    if (!likes!.contains(currentUserId)) {
      await FirebaseFirestore.instance
          .collection("videos")
          .doc(videoId)
          .update({
        "likes": FieldValue.arrayUnion([currentUserId])
      });
    }
    if (likes.contains(currentUserId)) {
      await FirebaseFirestore.instance
          .collection("videos")
          .doc(videoId)
          .update({
        "likes": FieldValue.arrayRemove([currentUserId])
      });
    }
  }
}
