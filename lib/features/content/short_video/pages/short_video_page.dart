
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:youtube_clone/cores/screens/error_page.dart';
import 'package:youtube_clone/cores/screens/loader.dart';
import 'package:youtube_clone/features/content/short_video/widgets/short_video_tile.dart';
import '../model/short_video_model.dart';

class ShortVideoPage extends StatelessWidget {
  const ShortVideoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection("shorts").snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Loader();
              } else if (snapshot.hasError) {
                return const ErrorPage();
              } else if (!snapshot.hasData || snapshot.data == null) {
                return const ErrorPage();
              }

              final shortVideoMaps = snapshot.data!.docs;
              return ListView.builder(
                itemCount: shortVideoMaps.length,
                itemBuilder: (context, index) {
                  ShortVideoModel shortVideo =
                  ShortVideoModel.fromMap(shortVideoMaps[index].data());
                  return ShortVideoTile(
                    shortVideo: shortVideo,
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
