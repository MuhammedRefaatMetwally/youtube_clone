import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/short_video_model.dart';

final shortVideoProvider = Provider(
  (ref) => ShortVideoRepository(
    auth: FirebaseAuth.instance,
    firestore: FirebaseFirestore.instance,
  ),
);
final isLoadingShortProvider = StateProvider<bool>((ref) => false);
final isExportingProvider = StateProvider<bool>((ref) => false);


class ShortVideoRepository {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;
  ShortVideoRepository({
    required this.auth,
    required this.firestore,
  });

  Future<void> addShortVideoToFirestore({
    required String caption,
    required String video,
    required DateTime datePublished,
  }) async {
    ShortVideoModel shortVideo = ShortVideoModel(
      caption: caption,
      userId: auth.currentUser!.uid,
      shortVideo: video,
      datePublished: datePublished,
    );
    await firestore.collection("shorts").add(shortVideo.toMap());
  }
}
